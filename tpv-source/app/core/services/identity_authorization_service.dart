// ignore_for_file: unused_field

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:warranty/app/core/services/auth/lib/flutter_appauth_platform_interface.dart';

import '/app/core/interfaces/net_work_info.dart';
import '../../../app/core/cache/future_cache.dart';
import '../../../app/core/interfaces/autorization_service.dart';
import '../../../app/core/services/local_storage.dart';
import '../../../app/core/services/logger_service.dart';
import '../../../app/core/services/network_manager_service.dart';
import '../../../app/core/services/paths_service.dart';
import '../../../app/core/services/user_session.dart';
import '../../../app/core/services/util_service.dart';
import '../../../app/modules/security/domain/models/profile_model.dart';
import '../../../globlal_constants.dart';
import '../../routes/app_routes.dart';
import 'custom_flutter_app_auth.dart' as cfaa;
import 'scim2impl.dart';

class IdentityAuthorizationService implements AuthorizationService {
  BuildContext? context;

  final String key;

  //final FlutterAppAuth flutterAppAuth = const FlutterAppAuth();
  cfaa.CustomFlutterAppAuth cflutterAppAuth = cfaa.CustomFlutterAppAuth();

  final bool withPkce;

  late UserSession _session;

  final bool ignoreOnError, active;

  final String authorizationEndpoint;

  final String tokenEndpoint;

  final String endSessionEndpoint;

  final String userinfoEndpoint;

  final String consumerKey;

  final String? consumerSecret;

  final String domain, authDomain, authIssuer, redirectUri;

  late List<String> _scopes;

  late AuthorizationServiceConfiguration serviceConfiguration;

  late String _prefijo;

  Timer? timer;

  late String scimDomain;

  ProfileModel? _profile;

  Timer? ctlTimerToExpire;
  late Scim2Impl _scim;
  bool hostResolved = true;
  bool hostConfigurationResolved = true;

  bool checking = false;
  bool isvalid = false;
  IdentityAuthorizationService({
    required this.key,
    required this.authorizationEndpoint,
    required this.tokenEndpoint,
    required this.endSessionEndpoint,
    required this.userinfoEndpoint,
    required this.consumerKey,
    required this.authDomain,
    required this.authIssuer,
    required this.redirectUri,
    required this.active,
    required this.ignoreOnError,
    required this.withPkce,
    this.domain = "enzona.net",
    this.consumerSecret,
    List<String> scopes = const [
      'openid',
      'openid apim:subscribe',
      'email',
      'offline_access',
      'api'
    ],
  }) {
    _prefijo = "${key}_";
    log("Iniciando instancia de IdentityAuthorizationService...");
    serviceConfiguration = AuthorizationServiceConfiguration(
      authorizationEndpoint: authorizationEndpoint,
      tokenEndpoint: tokenEndpoint,
      endSessionEndpoint: endSessionEndpoint,
      userinfoEndpoint: userinfoEndpoint,
    );
    cflutterAppAuth = cflutterAppAuth.load(
      clientId: consumerKey,
      clientSecret: consumerSecret,
      redirectUri: redirectUri,
      authorizationEndpoint: authorizationEndpoint,
      authIssuer: authIssuer,
      tokenEndpoint: tokenEndpoint,
      discoveryUrl: "$authIssuer/.well-known/openid-configuration",
      endSessionEndpoint: endSessionEndpoint,
      userinfoEndpoint: userinfoEndpoint,
    );
    scimDomain = "https://$authDomain/t/carbon.super/scim2";
    //Scim2ManagerService().initServices(headers)
    //_scim = Scim2Impl(path: scimDomain);
    log("SCIM2 API-URL => https://$scimDomain");
    _scopes = scopes;
    log("scimEndpoint=$scimDomain");
    log("authorizationEndpoint=$authorizationEndpoint");
    log("tokenEndpoint=$tokenEndpoint");
    log("endSessionEndpoint=$endSessionEndpoint");
    loadSessionData(_session = UserSession(authorizationService: this))
        .then((value) {
      _session = value;
    });
    //_session.clearSession();
    // clear();
  }

  String? get accessToken => _session.getAccessToken;

  bool get authenticated =>
      _session.getExpirationDate != null && !_session.hasExpired();

  String? get expiresIn => _session.getExpirationDate != null
      ? _session.getExpirationDate!.toString()
      : null;

  String get getPrefijo => _prefijo;
  Map<String, dynamic>? get getProfileMap =>
      _profile != null ? _profile!.toJson() : null;
  List<String> get getScopes => _scopes;

  String? get idToken => _session.getIdToken;

  String get refreshToken => _session.getRefreshToken ?? "";

  String? get tokenType => _session.getTokenType;

  Future<String> authorize({
    bool refresh = false,
  }) async {
    try {
      info('For $key=> Comenzando a ejecutar authorize()');
      final storedRefreshToken = await getRefreshToken();
      final refreshTokenExpiration = await getExpirationTime();
      final refreshTokenExpired =
          DateTime.now().isAfter(refreshTokenExpiration);
      if (storedRefreshToken.isNotEmpty && refreshTokenExpired) {
        final newAccessToken = await renewAccessToken(storedRefreshToken);
        if (newAccessToken.isNotEmpty) {
          return newAccessToken;
        }
      }

      // Invoke '/token' endpoint with obtained authorizationCode and codeVerifier
      final response = FutureCache.instance.add<TokenResponse?>(
        key: "$key-getTokenResponse",
        future: () async {
          return getTokenResponse(refresh: refresh);
        },
      );

      final TokenResponse? tokenResponse = await response;

      if (tokenResponse != null) {
        // Add tokens to secure storage.
        _processToken(tokenResponse);
        return tokenResponse.accessToken!;
      }
      log(tokenResponse ?? "For $key=> Error en token response");
    } on Exception catch (e, s) {
      log('For $key=> login error: $e - stack: $s');
    }
    return "";
  }

  Future<String> authorizeAndExchangeCode() async {
    /* if (!(await isHostConfigurationResolved())) {
      return Future.value("");
    }*/

    try {
      //
      final storedRefreshToken = await getRefreshToken();
      //final refreshTokenExpiration = await getExpirationTime();
      bool hasExpired = _session.hasExpired();
      if (!hasExpired) {
        return _session.getAccessToken!;
      }
      /*final refreshTokenExpired =
          DateTime.now().isAfter(refreshTokenExpiration);*/
      if (storedRefreshToken.isNotEmpty && hasExpired) {
        final newAccessToken = await renewAccessToken(storedRefreshToken);
        if (newAccessToken.isNotEmpty) {
          return newAccessToken;
        }
      }
      //
      //setRefreshToken(storedRefreshToken);
      //setNonce(await getNonce());
      //log("For $key=> Nonce=${_session.getNonce}");
      //
      AuthorizationTokenRequest authRequest = _session.getNonce.isNotEmpty
          ? AuthorizationTokenRequest(
              consumerKey,
              redirectUri,
              issuer: authIssuer,
              scopes: _scopes,
              allowInsecureConnections: true,
              clientSecret: consumerSecret,
              serviceConfiguration: serviceConfiguration,
              preferEphemeralSession: Platform.isIOS || Platform.isMacOS,
              promptValues: ['login'],
              /*additionalParameters: {
                //'code_challenge_method': 'S256',
                'ui_locales': 'es',
                'acr_values':
                    'custom_css_url:asset:///assets/css/custom_login.css'
              },*/
              /*additionalParameters: {
                "token_type_hint": "access_token",
                //'approval_prompt': 'auto',//force
                "nonce": _session.getNonce,
              },*/
              nonce: _session.getNonce,
              //discoveryUrl: "$authIssuer/.well-known/openid-configuration",
            )
          : AuthorizationTokenRequest(
              consumerKey,
              redirectUri,
              issuer: authIssuer,
              scopes: _scopes,
              allowInsecureConnections: true,
              clientSecret: consumerSecret,
              serviceConfiguration: serviceConfiguration,
              /*additionalParameters: {
                "token_type_hint": "access_token",
                //'approval_prompt': 'auto',//force
              },*/
              preferEphemeralSession: Platform.isIOS || Platform.isMacOS,
              promptValues: ['login'],
              //discoveryUrl: "$authIssuer/.well-known/openid-configuration",
            );
      final resp = FutureCache.instance.add<AuthorizationTokenResponse?>(
        key: "$key-flutterAppAuth.authorizeAndExchangeCode",
        future: () async {
          try {
            return cflutterAppAuth.authorizeAndExchangeCode(authRequest);
          } catch (e) {
            log(e.toString());
          }
          return Future.value(null);
        },
      );
      final response = await resp;
      if (response != null) {
        if (response.idToken != null) {
          _processToken(response);
        }
      }
    } on PlatformException catch (pe) {
      error(pe.code);
      error(pe.message ?? "For $key=> Sin mensaje");
      error(pe.details ?? "For $key=> Sin details");
      error(pe.stacktrace ?? "For $key=> Sin stacktrace");
      error("${(pe.message ?? pe.stacktrace ?? pe.details)}");
      return Future.value("");
    }
    return Future.value(_session.getAccessToken);
  }

  clear({
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) {
    LocalSecureStorage.storage.delete("${_prefijo}tokenType");
    LocalSecureStorage.storage.delete("${_prefijo}accessToken");
    LocalSecureStorage.storage.delete("${_prefijo}clientID");
    LocalSecureStorage.storage.delete("${_prefijo}idToken");
    LocalSecureStorage.storage.delete("${_prefijo}expirationTime");
    LocalSecureStorage.storage.delete("${_prefijo}nonce");
    LocalSecureStorage.storage.delete("${_prefijo}refreshToken");
    LocalSecureStorage.storage.delete("${_prefijo}tenant_domain");
    LocalSecureStorage.storage.delete("${_prefijo}scopes");
  }

  /// Function to clear refresh token
  Future<String> clearRefreshToken() async {
    await LocalSecureStorage.storage.delete('${_prefijo}refreshToken');
    return Future.value("deleted");
  }

  closeTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
  }

  deleteAll() {
    LocalSecureStorage.storage.deleteAll();
  }

  Future<bool> endSession({String? idToken}) async {
    try {
      idToken = idToken ?? await getIdToken();
      final callBackUrl =
          '$globalApplicationId://${Routes.getInstance.getPath("APP_HOME")}';
      _session.clearSession();

      if (idToken.isNotEmpty) {
        final endSessionRequest = EndSessionRequest(
          idTokenHint: idToken,
          issuer: authIssuer,
          serviceConfiguration: serviceConfiguration,
          postLogoutRedirectUrl: callBackUrl,
          allowInsecureConnections: true,
        );
        final endSessionResponse =
            await cflutterAppAuth.endSession(endSessionRequest);

        log('For $key => Estado de la sesión: ${endSessionResponse.state}');
      }
    } catch (error) {
      log(error.toString());
      return false;
    }

    return true;
  }

  dynamic get(
    String key,
    dynamic defaultValue, {
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) {
    final exists = LocalSecureStorage.storage.hasData(key);
    if (exists) return LocalSecureStorage.storage.get(key, defaultValue);
    return defaultValue;
  }

  /// Function to get access token from secure storage
  Future<String> getAccessToken() async {
    _session.setAccessToken(
        await LocalSecureStorage.storage.read('${_prefijo}accessToken') ?? "");
    return Future.value(_session.getAccessToken);
  }

  Future<AuthorizationResponse?> getAuthorizationResponse() async {
    if (!(await isHostConfigurationResolved())) return Future.value(null);
    setNonce(await getNonce());

    info("For $key=> Sending Authorization Request...");

    final request = AuthorizationRequest(
      consumerKey,
      redirectUri,
      issuer: authIssuer,
      scopes: _scopes,
      promptValues: ['login'],
      serviceConfiguration: serviceConfiguration,
      allowInsecureConnections: true,
      nonce: _session.getNonce,
      //discoveryUrl: "$authIssuer/.well-known/openid-configuration",
    );
    log('For $key=> Executing Authorization Request...');
    try {
      final AuthorizationResponse? authorizationResponse =
          await cflutterAppAuth.authorize(request);
      if (authorizationResponse == null) return Future.value(null);
      log('For $key=> Proccessing Authorization response...');
      if (authorizationResponse.nonce != null) {
        setNonce(authorizationResponse.nonce!);
      }
      _processAuthResponse(authorizationResponse);
      return Future.value(authorizationResponse);
    } on PlatformException catch (ex) {
      log("For $key=> Message: ${ex.message}.");
    }

    return Future.value(null);
  }

  Future<AuthorizationTokenResponse?> getAuthorizationTokenResponse() async {
    if (!(await isHostConfigurationResolved())) return Future.value(null);
    final nonce = await getNonce();

    info("For $key=> Sending Authorization Request withNonce=$nonce");
    /**       
     _clientId,
          _redirectUrl,
          serviceConfiguration: _serviceConfiguration,
          scopes: _scopes,
          preferEphemeralSession: preferEphemeralSession,
     */
    final request = AuthorizationTokenRequest(
      consumerKey,
      redirectUri,
      // issuer: authIssuer,
      scopes: _scopes,
      //promptValues: ['login'],
      serviceConfiguration: serviceConfiguration,
      allowInsecureConnections: true,
      preferEphemeralSession: Platform.isIOS || Platform.isMacOS,
      // nonce: nonce,
      //discoveryUrl: "$authIssuer/.well-known/openid-configuration",
    );
    log('For $key=> Executing Authorization Request...');
    try {
      final resp = FutureCache.instance.add<AuthorizationTokenResponse?>(
        key: "$key-flutterAppAuth.authorizeAndExchangeCode",
        future: () async {
          return cflutterAppAuth.authorizeAndExchangeCode(request);
        },
      );
      final AuthorizationTokenResponse? authorizationTokenResponse = await resp;
      log('For $key=> Authorization Token Response Ok');
      if (authorizationTokenResponse != null) {
        _processAuthTokenResponse(authorizationTokenResponse);
        return Future.value(authorizationTokenResponse);
      }
    } on Exception catch (ex) {
      log("For $key=> Message: ${ex.toString()}.");
    }

    return Future.value(null);
  }

  /// Function to get client ID from secure storage
  Future<String> getClientID() async {
    String? clientID =
        await LocalSecureStorage.storage.read('${_prefijo}clientID');
    if (clientID == null || clientID.isEmpty) {
      LocalSecureStorage.storage.write('${_prefijo}clientID', consumerKey);
      return Future.value(consumerKey);
    }
    return Future.value(clientID);
  }

  // Obtener el token de acceso
  Future<String> getCustomAccessToken() async {
    var response = await http.post(
      Uri.parse(tokenEndpoint),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization':
            'Basic ${base64.encode(utf8.encode('$consumerKey:$consumerSecret'))}'
      },
      body: {
        'grant_type': 'password',
        'username': 'tu-usuario',
        'password': 'tu-contraseña'
      },
    );
    var token = jsonDecode(response.body)['access_token'];
    return token;
  }

  /// Function to get Expiration Time from secure storage
  Future<DateTime> getExpirationTime() async {
    final timeExpired =
        await LocalSecureStorage.storage.read('${_prefijo}expirationTime');
    _session.setExpirationDate(
        timeExpired != null ? DateTime.parse(timeExpired) : DateTime.now());
    return Future.value(_session.getExpirationDate);
  }

  /// Function to get ID token from secure storage
  Future<String> getIdToken() async {
    _session.setIdToken(
        await LocalSecureStorage.storage.read('${_prefijo}idToken'));
    return Future.value(_session.getIdToken);
  }

  Future<String> getNonce() => _session.getNonce.isEmpty
      ? _session.getCreateNonce()
      : Future.value(_session.getNonce);

  /// Function to get refresh token from secure storage
  Future<String> getRefreshToken() async {
    final refreshT =
        await LocalSecureStorage.storage.read('${_prefijo}refreshToken');
    _session.setRefreshToken(refreshT ?? "");
    return Future.value(refreshT ?? "");
  }

  /// Function to get Expiration Time from secure storage
  Future<DateTime> getRefreshTokenExpirationTime() async {
    final timeExpired = await LocalSecureStorage.storage
        .read('${_prefijo}refreshExpirationTime');
    _session.setRefreshTokenExpirationTime(
        timeExpired != null ? DateTime.parse(timeExpired) : DateTime.now());
    return Future.value(_session.getRefreshTokenExpirationTime);
  }

  /// Function to get tenant domain from secure storage
  Future<String> getTenantDomain() async {
    String? tenantDomain =
        await LocalSecureStorage.storage.read('${_prefijo}tenant_domain');
    if (tenantDomain == null || tenantDomain.isEmpty) {
      return Future.value(PathsService.identityTenantDomain);
    }
    return Future.value(tenantDomain);
  }

  Future<TokenResponse?> getTokenResponse({
    bool refresh = false,
  }) async {
    TokenRequest? tRequest = await _createTokenRequest(refresh: refresh);
    info("For $key=> CallBackUrl=$redirectUri");
    final result = FutureCache.instance.add<TokenResponse?>(
      key: "$key-flutterAppAuth.token",
      future: () async {
        return cflutterAppAuth.token(tRequest);
      },
    );
    final tokenResponse = await result;
    return Future.value(tokenResponse);
  }

  UserSession getUserSession() => _session;

  Future<bool> hasConnection(Duration timeOut) async {
    final result = await NetworkInfoImpl.instance
        .setTimeOut(timeOut)
        .hasConnection("https://$authDomain");
    return Future.value(result);
  }

  hasData(String key) {
    return LocalSecureStorage.storage.hasData(key);
  }

  bool isAccessTokenValid(String? at) => at != null && at.isNotEmpty;

  Future<bool> isAuthenticated() => isValid();

  Future<bool> isHostConfigurationResolved() async {
    if (hostConfigurationResolved) return true;
    hostConfigurationResolved = await NetworkManagerService.instance
        .hasConnection("https://$authDomain/.well-known/openid-configuration");
    log("Comprobando: https://$authDomain/.well-known/openid-configuration");
    return Future.value(hostResolved = hostConfigurationResolved);
  }

  Future<bool> isHostResolved() async {
    if (hostResolved) return true;
    hostResolved = await NetworkManagerService.instance
        .hasConnection("https://$authDomain");
    log("Comprobando: https://$authDomain");
    return Future.value(hostConfigurationResolved = hostResolved);
  }

  bool isTokenEmpty() => idToken == null || idToken == "";

  Future<bool> isValid({
    bool refreshIfExpired = true,
  }) async {
    //if (!(await isHostConfigurationResolved())) return false;
    if (checking && !isvalid || !checking && isvalid) {
      return Future.value(isvalid);
    }
    checking = true;
    if (_session.getExpirationDate == null) {
      log("For $key=> Asignando tiempo de expiración desde storage...");
      var expirationTime =
          await LocalSecureStorage.storage.read("${_prefijo}expirationTime");
      _session.setExpirationDate(
          expirationTime != null ? DateTime.parse(expirationTime) : null);
    }

    final expired = _session.hasExpired();
    isvalid =
        !isTokenEmpty() && expired == false && _session.getSecoundsToExpire > 0;
    log("For $key=> Token ${isTokenEmpty() ? 'is null' : 'is not null'} And ${expired ? 'has been expired' : 'has not been expired'} And isvalid=$isvalid");
    try {
      if (!isvalid) {
        var autorized = "";
        if (refreshIfExpired == true && expired) {
          log("For $key=> ${withPkce ? 'Ejecutando authorizeAndExchangeCode' : 'Ejecutando login'}");
          final tokenResponse = withPkce
                  ? authorizeAndExchangeCode() /*FutureCache.instance.add<String>(
                  key: "$key-authorizeAndExchangeCode",
                  future: () async {
                    final tmp = await authorizeAndExchangeCode();
                    return Future.value(tmp);
                  },
                )*/
                  : authorize(
                      refresh: refreshIfExpired,
                    ) /*FutureCache.instance.add<String>(
                  key: "$key-authorize",
                  future: () async {
                    final tmp = authorize(
                      refresh: refreshIfExpired,
                    );
                    return Future.value(tmp);
                  },
                )*/
              ;
          autorized = await tokenResponse;
          //tokenResponse.then((value) => autorized = value);
        } else {
          log("For $key=> Ejecutando updateAccessToken/refreshAccessToken ...");
          final tokenResponse = FutureCache.instance.add<String?>(
            key: "$key-refreshAccessToken",
            future: () async {
              return refreshAccessToken();
            },
          );
          autorized = (await tokenResponse) ?? "";
        }
        log("For $key=> Autorized=$autorized");
        isvalid = autorized != "";
      }
    } on PlatformException catch (ex) {
      log("For $key=> PlatformException: ${ex.message}\n${ex.stacktrace}");
      isvalid = false;
    } on Exception catch (ex) {
      log("For $key=> Exception ${ex.toString()}");
      isvalid = false;
    }

    if (isvalid) {
      _session.setAccessToken(accessToken);
      _session.setIdToken(idToken);
    } else {
      _session.setAccessToken(null);
      _session.setIdToken(null);
    }
    checking = false;
    return Future.value(isvalid);
  }

  Future<UserSession> loadSessionData(UserSession session) async {
    final result = await Future.wait([
      getIdToken(),
      getAccessToken(),
      getExpirationTime(),
      getNonce(),
      getRefreshToken(),
      getRefreshTokenExpirationTime(),
    ]);
    String idToken = result.elementAt(0) as String;
    String accessToken = result.elementAt(1) as String;
    DateTime expTime = result.elementAt(2) as DateTime;
    String nonce = result.elementAt(3) as String;
    String refreshToken = result.elementAt(4) as String;
    DateTime refreshTokenExpTime = result.elementAt(5) as DateTime;
    //_session = UserSession(authorizationService: this);
    session.setIdToken(idToken);
    session.setAccessToken(accessToken);
    session.setExpirationDate(expTime);
    session.setNonce(nonce);
    session.setRefreshToken(refreshToken);
    session.setRefreshTokenExpirationTime(refreshTokenExpTime);
    return Future.value(_session = session);
  }

  /// Parse retrieved ID token and return the resulting Json object.
  Map<String, Object> parseIdToken(String idToken) {
    final List<String> parts = idToken.split('.');
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  // Personalizar la plantilla de autenticación
  Future personalizeAuthTemplate(String token) async {
    var response = await http.post(
      Uri.parse("$authDomain/api/identity/authntemplates/customize"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({
        'templateName': 'Default',
        'properties': [
          {'name': 'background-color', 'value': '#F8F8F8'},
          {'name': 'font-family', 'value': 'Arial'},
          {'name': 'logo', 'value': 'https://tu-app.com/logo.png'}
        ],
      }),
    );
  }

  Future<String?> read({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) {
    return LocalSecureStorage.storage.read(key);
  }

  /// Get a new access token from the refresh token using
  /// 'refresh token grant type'
  Future<String?> refreshAccessToken() async {
    //if (!(await isHostConfigurationResolved())) return "";
    String storedRefreshToken = await getRefreshToken();
    bool hasExpired = _session.hasExpired();
    if (!hasExpired) {
      if (_session.getRefreshToken != null &&
          _session.getRefreshToken!.isNotEmpty &&
          storedRefreshToken != _session.getRefreshToken) {
        setRefreshToken(storedRefreshToken = _session.getRefreshToken!);
      }
      if (storedRefreshToken.isNotEmpty) {
        return Future.value(storedRefreshToken);
      } else if (_session.getRefreshToken != null &&
          _session.getRefreshToken!.isNotEmpty) {
        return Future.value(_session.getRefreshToken);
      } else if (!withPkce &&
          _session.getAccessToken != null &&
          _session.getAccessToken!.isNotEmpty) {
        return Future.value(_session.getAccessToken);
      }
    }
    if (storedRefreshToken.isNotEmpty) {
      final resp = await cflutterAppAuth.refreshAccessToken(storedRefreshToken);
      if (resp.refreshToken != null) {
        setRefreshToken(storedRefreshToken = resp.refreshToken!);
        return Future.value(_session.getRefreshToken);
      }
    }
    final tokenRequest = FutureCache.instance.add<TokenRequest>(
      key: "$key-_createTokenRequest",
      future: () async {
        return _createTokenRequest(refresh: true);
      },
    );
    final TokenRequest? request = await tokenRequest;
    try {
      TokenResponse? response;

      if (request != null) {
        //request.scopes = _scopes;
        if (request.refreshToken != null && request.refreshToken!.isEmpty ||
            hasExpired) {
          final tokenResponse = withPkce
              ? FutureCache.instance.add<String>(
                  key: "$key-authorizeAndExchangeCode",
                  future: () async {
                    return authorizeAndExchangeCode();
                  },
                )
              : FutureCache.instance.add<String>(
                  key: "$key-authorize",
                  future: () async {
                    return authorize();
                  },
                );
          final tr = await tokenResponse;
          return Future.value(tr);
        }
      }
      String fkey = "$key-flutterAppAuth.token(request)";
      //TODO verificar que la url del API esté accesible y darle tratamiento.
      final tokenResponse = FutureCache.instance.add<TokenResponse?>(
        key: fkey,
        future: () async {
          return cflutterAppAuth.token(request!);
        }, //
      );
      response = await tokenResponse;

      if (response != null) {
        _processToken(response);
        return response.accessToken ?? response.idToken ?? "";
      }
    } on PlatformException catch (ex) {
      log("For $key=> PlatformException: ${ex.message}\n${ex.stacktrace}");
      if (ex.details.toString().contains("Unable to resolve host")) {
        hostResolved = false;
        hostConfigurationResolved = false;
      } else if (ex.details.toString().contains("Network error")) {}
      return withPkce
          ? authorizeAndExchangeCode()
          : authorize(
              refresh: true,
            );
    }
    return "";
  }

  removeWhere(bool Function(String, dynamic) test) {
    closeTimer();
    LocalSecureStorage.storage.removeWhere(test);
  }

  removeWhereKeyContains(String str) {
    closeTimer();
    LocalSecureStorage.storage.removeWhereKeyContains(str);
  }

  removeWhereKeyEndWith(String str) {
    closeTimer();
    LocalSecureStorage.storage.removeWhereKeyEndWith(str);
  }

  removeWhereKeyStartWith(String str) {
    closeTimer();
    LocalSecureStorage.storage.removeWhereKeyStartWith(str);
  }

  Future<String> renewAccessToken(String refreshToken) async {
    try {
      final clientId = await getClientID();
      final response = FutureCache.instance.add<TokenResponse?>(
        key: "$key-getTokenResponse",
        future: () async {
          try {
            log("$key-Mis scopes:${_scopes.toString()}");
            final TokenResponse? tok = await cflutterAppAuth.token(TokenRequest(
              clientId,
              redirectUri,
              //discoveryUrl: "$authIssuer/.well-known/openid-configuration",
              refreshToken: refreshToken,
              scopes: ['openid'], //, 'profile', 'email'
              serviceConfiguration: serviceConfiguration,
            ));
            if (tok != null && tok.accessTokenExpirationDateTime != null) {
              _processToken(tok);
            }
            return Future.value(tok);
          } catch (e) {
            e.printError();
          }
          return null;
        },
      );
      final tokenResponse = await response;
      if (tokenResponse != null) {
        // Add tokens to secure storage.
        if (tokenResponse.idToken != null ||
            tokenResponse.accessToken != null) {
          _processToken(tokenResponse);
        }
        return tokenResponse.accessToken ?? "";
      }
      log(tokenResponse ?? "For $key=> Error en token response");
    } on PlatformException catch (e, s) {
      log('For $key=> login error: $e - stack: $s');
      if (context != null) {
        showDialog(
          context: context!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error de conexión'),
              content: Text(
                  'No se pudo conectar con la API. Por favor, verifica tu conexión a Internet e intenta nuevamente.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Aceptar'),
                ),
              ],
            );
          },
        );
      }
    } on Exception catch (e, s) {
      log('For $key=> login error: $e - stack: $s');
      if (context != null) {
        showDialog(
          context: context!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error de conexión'),
              content: Text(
                  'No se pudo conectar con la API. Por favor, verifica tu conexión a Internet e intenta nuevamente.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Aceptar'),
                ),
              ],
            );
          },
        );
      }
    }
    return "";
  }

  /// Function to set access token to secure storage
  Future<String> setAccessToken(String accessToken) async {
    _session.setAccessToken(accessToken);
    await LocalSecureStorage.storage
        .write('${_prefijo}accessToken', accessToken);
    return Future.value(accessToken);
  }

  Future<DateTime> setAccessTokenExpirationDateTime(DateTime dateTime) async {
    _session.setExpirationDate(dateTime);
    if (_profile != null) {
      _profile!.setAuthenticationExpireIn(dateTime);
    }
    final str = dateTime.toString();
    await LocalSecureStorage.storage.write('${_prefijo}expirationTime', str);
    info(
        'For $key=> Actualizando TokenExpirationDateTime para Identity Service=$key');
    ctlTimerToExpire = Timer.periodic(Duration(seconds: 1), (Timer t) async {
      if (ctlTimerToExpire != null && _session.hasExpired()) {
        if (_session.getSecoundsToExpire <= 0) {
          /*_session.setSecoundsToExpire(
              dateTime.difference(DateTime.now()).inSeconds.abs());*/
          await refreshAccessToken();
        }
        if (ctlTimerToExpire != null) ctlTimerToExpire!.cancel();
        ctlTimerToExpire = null;
      }
      if (_session.getSecoundsToExpire > 0) {
        _session.decrease(1);
      }
    });

    //_session.setExpirationDate(dateTime);
    var moment = DateTime.now();
    //
    var refreshTokenOn = dateTime.difference(moment).inSeconds.abs() - 30;
    timer = timer ??
        Timer.periodic(Duration(seconds: refreshTokenOn), (Timer t) async {
          if (timer != null && _session.hasExpired()) {
            //_session.clearSession();
            if (withPkce) {
              final tokenResponse = FutureCache.instance.add<String?>(
                key: "$key-refreshAccessToken",
                future: () async {
                  return refreshAccessToken();
                },
              );
              await tokenResponse;
            } else {
              final tokenResponse = FutureCache.instance.add<String>(
                key: "$key-authorize",
                future: () async {
                  return authorize();
                },
              );
              await tokenResponse;
            }
            if (timer != null) timer!.cancel();
            timer = null;
          }
        });
    return Future.value(dateTime);
  }

  /// Function to set client ID to secure storage
  Future<String> setClientID(String clientID) async {
    await LocalSecureStorage.storage.write('${_prefijo}clientID', clientID);
    return Future.value(clientID);
  }

  IdentityAuthorizationService setContext(BuildContext context) {
    this.context = context;
    cflutterAppAuth.setContext(context);
    return this;
  }

  /// Function to set ID token to secure storage
  Future<String> setIdToken(String idToken) async {
    _session.setIdToken(idToken);
    await LocalSecureStorage.storage
        .write('${_prefijo}idToken', _session.getIdToken);
    return Future.value(_session.getIdToken);
  }

  Future<String> setNonce(String nonce) async {
    _session.setNonce(nonce);
    await LocalSecureStorage.storage
        .write('${_prefijo}nonce', _session.getNonce);
    return Future.value(_session.getNonce);
  }

  /// Function to set refresh token to secure storage
  Future<String> setRefreshToken(String refreshToken) async {
    _session.setRefreshToken(refreshToken);
    await LocalSecureStorage.storage
        .write('${_prefijo}refreshToken', _session.getRefreshToken ?? "");
    return Future.value(_session.getRefreshToken ?? "");
  }

  /// Function to get Expiration Time from secure storage
  Future<DateTime> setRefreshTokenExpirationTime(DateTime time) async {
    await LocalSecureStorage.storage
        .write('${_prefijo}refreshExpirationTime', time.toString());
    _session.setRefreshTokenExpirationTime(time);
    return Future.value(_session.getRefreshTokenExpirationTime);
  }

  Future<List<String>> setScopes(List<String> scopes) async {
    await LocalSecureStorage.storage
        .write('${_prefijo}scopes', (_scopes = scopes).toString());
    return Future.value(_scopes);
  }

  /// Function to set tenant domain to secure storage
  Future<String> setTenantDomain(String tenantDomain) async {
    await LocalSecureStorage.storage
        .write('${_prefijo}tenant_domain', tenantDomain);
    return Future.value(tenantDomain);
  }

  Future<String> setTokenType(String tokenType) async {
    _session.setTokenType(tokenType);
    await LocalSecureStorage.storage
        .write('${_prefijo}tokenType', _session.getTokenType ?? "");
    return Future.value(_session.getTokenType ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      "isValid": authenticated,
      "token": idToken,
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      "scope": getScopes,
      "idToken": idToken,
      "tokenType": tokenType,
      "expiresIn": expiresIn,
    };
  }

  Future<String?> toLogin() async {
    log("Authenticating...");
    if (!(await isValid())) {
      final tokenResponse = withPkce
          ? FutureCache.instance.add<String>(
              key: "$key-authorizeAndExchangeCode",
              future: () async {
                return authorizeAndExchangeCode();
              },
            )
          : FutureCache.instance.add<String>(
              key: "$key-authorize",
              future: () async {
                return authorize();
              },
            );
      return tokenResponse;
    }
    final tokenResponse = FutureCache.instance.add<String>(
      key: "$key-refreshAccessToken",
      future: () async {
        return refreshAccessToken();
      },
    );
    await tokenResponse;
    log("For $key=> Already authenticated");
    return Future.value(_session.getIdToken);
  }

  write(String key, String value) {
    return LocalSecureStorage.storage.write(key, value);
  }

  Future<TokenRequest> _createTokenRequest({bool refresh = false}) async {
    info(
        "For $key=> Creando TokenRequest with Pkce=$withPkce AND refresh=$refresh");
    if (refresh) {
      info("For $key=> Reading refresh token from local store...");
      final token = FutureCache.instance.add<String>(
        key: "$key-getRefreshToken",
        future: () async {
          return getRefreshToken();
        },
      );
      final rtoken = await token ?? "";
      setRefreshToken(rtoken);
      info(
          "For $key=> Refresh token from local store=${_session.getRefreshToken}");

      return withPkce
          ? TokenRequest(
              consumerKey,
              redirectUri,
              //discoveryUrl: "$authIssuer/.well-known/openid-configuration",
              issuer: authIssuer,
              allowInsecureConnections: true,
              clientSecret: consumerSecret,
              refreshToken: _session.getRefreshToken,
              grantType: 'refresh_token',
              serviceConfiguration: serviceConfiguration,
              nonce: _session.getNonce,
            )
          : _session.getRefreshToken != null &&
                  _session.getRefreshToken!.isNotEmpty
              ? TokenRequest(
                  consumerKey,
                  redirectUri,
                  authorizationCode: _session.getAuthorizationCode,
                  codeVerifier: _session.getCodeVerifier,
                  nonce: _session.getNonce,
                  scopes: _scopes,
                  //discoveryUrl: "$authIssuer/.well-known/openid-configuration",
                  issuer: authIssuer,
                  allowInsecureConnections: true,
                  clientSecret: consumerSecret,
                  refreshToken: _session.getRefreshToken,
                  grantType: 'refresh_token',
                  serviceConfiguration: serviceConfiguration,
                )
              : TokenRequest(
                  consumerKey,
                  redirectUri,
                  authorizationCode: _session.getAuthorizationCode,
                  codeVerifier: _session.getCodeVerifier,
                  nonce: _session.getNonce,
                  //discoveryUrl: "$authIssuer/.well-known/openid-configuration",
                  issuer: authIssuer,
                  allowInsecureConnections: true,
                  clientSecret: consumerSecret,
                  serviceConfiguration: serviceConfiguration,
                  grantType: "client_credentials",
                );
    }
    if (withPkce) {
      final authTokenResponse =
          FutureCache.instance.add<AuthorizationTokenResponse?>(
        key: "$key-getAuthorizationTokenResponse",
        future: () async {
          return getAuthorizationTokenResponse();
        },
      );
      final AuthorizationTokenResponse? authorizationTokenResponse =
          await authTokenResponse;
      if (authorizationTokenResponse != null) {
        info("For $key=> Authorization Response satisfactoriamente ");
        return TokenRequest(
          consumerKey,
          redirectUri,
          issuer: authIssuer,
          scopes: _scopes,
          allowInsecureConnections: true,
          clientSecret: consumerSecret, //
          serviceConfiguration: serviceConfiguration,
          authorizationCode: _session.getAuthorizationCode,
          codeVerifier: _session.getCodeVerifier,
          nonce: _session.getNonce,
          //discoveryUrl: "$authIssuer/.well-known/openid-configuration",
        );
      }
    } else {
      info("For $key=> Request por Client Credentials");
      return TokenRequest(
        consumerKey,
        redirectUri,
        scopes: _scopes,
        //discoveryUrl: "$authIssuer/.well-known/openid-configuration",
        issuer: authIssuer,
        allowInsecureConnections: true,
        clientSecret: consumerSecret,
        grantType: "client_credentials",
        serviceConfiguration: serviceConfiguration,
      );
    }
    info("For $key=> Request por defecto");
    return TokenRequest(
      consumerKey,
      redirectUri,
      scopes: _scopes,
      //discoveryUrl: "$authIssuer/.well-known/openid-configuration",
      issuer: authIssuer,
      allowInsecureConnections: true,
      clientSecret: consumerSecret,
      grantType: "client_credentials",
      serviceConfiguration: serviceConfiguration,
    );
  }

  void _processAuthResponse(AuthorizationResponse response) {
    log('For $key=> Proccessing Authorization Response...');
    _session.loadAuthorizationResponse(response);
  }

  void _processAuthTokenResponse(AuthorizationTokenResponse response) {
    log('For $key=> Proccessing Authorization Token Response...');
    _session.loadAuthorizationTokenResponse(response);
  }

  _processProfile(String tokenEncoded) {
    final parts = tokenEncoded.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }
    _profile = profileModelFromJson(UtilService.decodeBase64(parts[1]));
    if (_profile != null) {
      ProfileModel? profileStored = _session.getBy<ProfileModel>(
        "profile",
        converter: (data, key) {
          return ProfileModel.fromJson(json.decode(data[key]));
        },
      );
      if (profileStored != null &&
          profileStored.userName != _profile!.userName) {
        log("For $key=> Se ha detectado un cambio de usuario autenticado. Se procede a sobre escribir el perfil del usuario anterior.");
        _session.addData("profile", _profile!, replace: true);
      } else {
        _profile!.setLastAuthenticated(DateTime.now());

        _session.addData(
          "profile",
          _profile!,
          replace: true,
        );
      }
      _session.setUserName(_profile!.sub);
    }
  }

  _processToken(TokenResponse token) async {
    log("For $key=> User Authenticated, next Expiration DateTime on :${token.accessTokenExpirationDateTime}");
    if (token.idToken != null) {
      final String tok = token.idToken!;
      setIdToken(tok);
      if (tok.split('.').length == 3) {
        _processProfile(tok);
      }
    }
    if (token.refreshToken != null) {
      setRefreshToken(token.refreshToken ?? "");
    }
    if (token.accessToken != null) {
      setAccessToken(token.accessToken ?? "");
    }
    if (token.accessTokenExpirationDateTime != null) {
      setAccessTokenExpirationDateTime(token.accessTokenExpirationDateTime!);
      setRefreshTokenExpirationTime(token.accessTokenExpirationDateTime!);
      if (_profile != null) {
        _profile!
            .setAuthenticationExpireIn(token.accessTokenExpirationDateTime);
      }
    }
    log(_session.toJson());
  }
}
