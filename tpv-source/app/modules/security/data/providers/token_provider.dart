import 'package:dartz/dartz.dart';
import 'package:pkce/pkce.dart';

import '/globlal_constants.dart';
import '../../../../../app/core/interfaces/router.dart';
import '../../../../../app/core/services/identity_authorization_service.dart';
import '../../../../../app/core/services/local_storage.dart';
import '../../../../../app/core/services/logger_service.dart';
import '../../../../../app/core/services/manager_authorization_service.dart';
import '../../../../../app/core/services/util_service.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/get_provider.dart';
import '../../../../core/services/codes_app_service.dart';
import '../../../../core/services/default_header_request_service.dart';
import '../../../../core/services/paths_service.dart';
import '../../domain/models/token_model.dart';

class TokenProvider extends GetProviderImpl {
  IdentityAuthorizationService? auth =
      ManagerAuthorizationService().get(defaultIdpKey);

  Future<String> getCodeVerifier() async {
    String? codeVerifier =
        auth != null ? await auth!.read(key: "codeVerifier") : null;
    if (codeVerifier != null) {
      return codeVerifier;
    } else {
      throw CacheException();
    }
  }

  Future<TokenModel?> getToken(String code) async {
    final codeVerifier =
        auth != null ? await auth!.read(key: "codeVerifier") : null;
    var body =
        'client_id=${CodesAppServices.clientId}&grant_type=authorization_code';
    body = '$body&redirect_uri=${Router.redirectUri('/static.html')}';
    body = '$body&post_logout_redirect_uri=${Router.redirectUri('/')}';
    body = '$body&code=$code&code_verifier=$codeVerifier';
    super.setBaseUrl("");

    final resp = await post(
      "https://${PathsService.identityTokenEndpoint}",
      body,
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Methods': 'GET, POST, PATCH, OPTIONS',
        'Access-Control-Allow-Headers':
            'X-Requested-With, Origin, Content-Type, X-Auth-Token'
      },
      contentType: 'application/x-www-form-urlencoded',
    );
    log("Retornando token...");
    if (resp.body == null) {
      throw RemoteResponseException();
    }
    log("TokenModel:\n${(resp.body as TokenModel).toJson()}");
    return resp.body;
  }

  Future<bool> isAuthenticated() async {
    log('Entrando a isAuthenticated on Token Provider');
    final token = await LocalSecureStorage.storage.get("accessToken", "");
    final expTime = await LocalSecureStorage.storage.get("expirationTime", "");
    log("Token: $token");
    log("Tiempo de expiración en: $expTime son las ${DateTime.now()}");
    if (token == null) {
      log('El token no es válido');
      return false;
    } else {
      if (DateTime.now().isBefore(DateTime.parse(expTime!.toString()))) {
        log('El token es válido');
        return true;
      } else {
        log('El token expiró, se procede a su renegociación');

        try {
          final responseToken = await refreshToken();
          return responseToken.fold((l) {
            LocalSecureStorage.storage.deleteAll();
            return false;
          }, (newToken) async {
            log("Token renegociado: ${newToken.accessToken}");
            await saveTokenModel(newToken);
            log('Auth repository: Token renegociado correctamente');
            return true;
          });
        } on ServerException {
          LocalSecureStorage.storage.deleteAll();
          return false;
        }
      }
    }
  }

  Future<String> isValidToken(String user) async {
    final token = auth != null ? await auth!.read(key: 'refreshToken') : null;
    final accessToken =
        auth != null ? await auth!.read(key: 'accessToken') : null;
    var body = 'token=$token';
    final resp = await post('${PathsService.tokenIntrospect}/$user', body,
        contentType: 'application/x-www-form-urlencoded',
        headers: {
          'Authorization': 'Bearer $accessToken',
        });
    return resp.body;
  }

  Future<Either<ServerException, TokenModel>> login(String code) async {
    if (code.isEmpty) {
      code = auth != null ? await auth!.read(key: "authCode") ?? "" : "";
    }
    if (code.isNotEmpty) {
      auth != null
          ? await auth!.write("authCode", code)
          : log("Imposible salvar código de autenticación...");
    }
    var body =
        'client_id=${CodesAppServices.clientId}&grant_type=authorization_code';
    body = '$body&redirect_uri=${Router.redirectUri}';
    body = '$body&post_logout_redirect_uri=/';
    String? codeVerifier = await getCodeVerifier();
    body = '$body&code=$code&code_verifier=$codeVerifier';
    try {
      final remoteToken = await getToken(body);
      log("TOKEN: ${remoteToken!.accessToken}");
      log("ID TOKEN :${remoteToken.idToken.toString()} ");
      final parts = remoteToken.idToken!.split('.');
      if (parts.length != 3) {
        throw Exception('invalid token');
      }
      var decode = UtilService.decodeBase64(parts[1]);
      log("Decodificado el id tokennnnnnnnnn : $decode");
      await saveTokenModel(remoteToken);
      log('controller: usuario autenticado correctamente');
      return Right(remoteToken);
    } on ServerException {
      return Left(ServerException());
    }
  }

  Future<Either<ServerException, dynamic>> logOut() async {
    final logoutUrl = Uri.parse(await _urlLogout());
    /*await auth.remove('accessToken');
    await auth.remove('idToken');
    await auth.remove('refreshToken');*/
    final headers = DefaultHeaderRequestService.getHttpDefaulHeader();
    super.setBaseUrl("");
    final resp = await get(
      logoutUrl.toString(),
      headers: headers,
    );
    if (resp.statusCode == 401) {
      return Left(HttpServerException(fault: resp.body, response: resp));
    }
    auth != null
        ? await auth!.clear()
        : log("Imposible eliminar información...");
    return Right(resp.bodyString);
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic> && map.containsKey("accessToken")) {
        return TokenModel.fromMap(map);
      }
      log("MAP====>>>>:\n${map.toString()}");
      return TokenModel.fromMap({});
    };

    //super.setBaseUrl('https://${PathsService.identityHost}');
    //httpClient.defaultContentType = 'application/x-www-form-urlencoded';
  }

  Future<Either<ServerException, TokenModel>> refreshToken() async {
    final localRefreshToken =
        auth != null ? await auth!.read(key: 'refreshToken') : null;
    if (localRefreshToken == null) return Right(TokenModel.fromMap({}));
    log("Local refreshToken=$localRefreshToken");
    var body =
        'client_id=${PathsService.identityAuthClientId}&grant_type=refresh_token';
    body = '$body&refresh_token=$localRefreshToken';
    log("Comenzando a renegociar el token en: $baseUrl");
    super.setBaseUrl("https://${PathsService.identityHost}");
    final resp = await post("/oauth2/token", body,
        contentType: 'application/x-www-form-urlencoded',
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Credentials': 'true',
          'Access-Control-Allow-Methods': 'GET, POST, PATCH, OPTIONS',
          'Access-Control-Allow-Headers':
              'X-Requested-With, Origin, Content-Type, X-Auth-Token'
        });
    log("Recibida respuesta del identity...");
    if (resp.statusCode != 200) {
      return Left(HttpServerException(response: resp));
    }
    return Right(resp.body);
  }

  Future<void> savePkce(String codeVerifier, String codeChallenge) async {
    auth != null
        ? await auth!.write(
            'codeVerifier',
            codeVerifier,
          )
        : log("Imposible salvar codeVerifier...");
    auth != null
        ? await auth!.write(
            'codeChallenge',
            codeChallenge,
          )
        : log("Imposible salvar codeChallenge...");
  }

  Future<Either<Failure, void>> savePkcePair(PkcePair pkcePair) async {
    try {
      await savePkce(pkcePair.codeVerifier, pkcePair.codeChallenge);
      void empty;
      return Right(empty);
    } on CacheException {
      return Left(CacheFailure(message: 'error'));
    }
  }

  Future<void> saveTokenModel(TokenModel tokenModel) async {
    if (tokenModel.accessToken != null) {
      await LocalSecureStorage.storage.write(
        'accessToken',
        tokenModel.accessToken!,
      );
    }
    if (tokenModel.expiresIn != null) {
      await LocalSecureStorage.storage
          .write('expirationTime', tokenModel.expiresIn!.toIso8601String());
    }
    if (tokenModel.idToken != null) {
      await LocalSecureStorage.storage.write('idToken', tokenModel.idToken!);
    }
    if (tokenModel.refreshToken != null) {
      await LocalSecureStorage.storage
          .write('refreshToken', tokenModel.refreshToken!);
    }
    await LocalSecureStorage.storage
        .write('clientID', PathsService.identityAuthClientId);
  }

  Future<String> _urlLogout() async {
    final idToken = auth != null ? await auth!.read(key: 'idToken') : "";
    final code = auth != null ? await auth!.read(key: 'idToken') : "";
    String query = 'id_hint_token=$idToken';
    query = '$query&code=$code';
    query =
        '$query&post_logout_redirect_uri=${Router.redirectUri('/static.html')}';
    return 'https://${PathsService.identityLogoutEndpoint}?$query';
  }
}
