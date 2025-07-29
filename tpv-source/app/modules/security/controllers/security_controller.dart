// ignore_for_file: unrelated_type_equality_checks, unused_element

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:pkce/pkce.dart';

import '../../../routes/app_routes.dart';
import '/globlal_constants.dart';
import '../../../../app/core/config/errors/errors.dart';
import '../../../../app/core/interfaces/entity_model.dart';
import '../../../../app/core/interfaces/router.dart';
import '../../../../app/core/interfaces/use_case.dart';
import '../../../../app/core/services/local_storage.dart';
import '../../../../app/core/services/logger_service.dart';
import '../../../../app/core/services/manager_authorization_service.dart';
import '../../../../app/core/services/notifications_service.dart';
import '../../../../app/modules/security/domain/models/token_model.dart';
import '../../../../app/modules/security/domain/usecases/authenticate_usecase.dart';
import '../../../../app/modules/security/domain/usecases/filter_profile_usecase.dart';
import '../../../../app/modules/security/domain/usecases/get_profile_usecase.dart';
import '../../../../app/modules/security/domain/usecases/list_profile_usecase.dart';
import '../../../core/controllers/custom_getx_controller.dart';
import '../../../core/services/codes_app_service.dart';
import '../../../core/services/launch_url_service.dart';
import '../../../core/services/paths_service.dart';
import '../../../core/services/util_service.dart';
import '../data/providers/token_provider.dart';
import '../data/repositories/profile_repository_impl.dart';
import '../data/repositories/token_repository_impl.dart';
import '../domain/models/profile_model.dart';

enum AuthStatus { cheking, authenticated, notAuthenticated }

class SecurityController extends CustomGetxController {
  static SecurityController? _instance = SecurityController._internal();
  static SecurityController get getInstance =>
      _instance ??= SecurityController._internal();
  AuthStatus authStatus = AuthStatus.notAuthenticated;
  AuthenticateUseCase<TokenModel> authenticateUseCase =
      AuthenticateUseCase<TokenModel>(
          Get.put(TokenRepositoryImpl<TokenModel>()));
  FilterProfileUseCase<ProfileModel> filterProfileUseCase =
      FilterProfileUseCase<ProfileModel>(
          Get.put(ProfileRepositoryImpl<ProfileModel>()));
  ListProfileUseCase<ProfileModel> listOrderUseOrder =
      ListProfileUseCase<ProfileModel>(Get.find());

  GetProfileUseCase<ProfileModel> getProfileUseCase =
      GetProfileUseCase<ProfileModel>(Get.find());

  ProfileModel? profile;
  Future<bool> _wasAuthenticated = Future.value(false);
  SecurityController() : super() {
    _instance ??= this;
  }
  SecurityController._internal() {
    log("Iniciando instancia de SecurityController...");
  }
  Future<bool> get alreadyAuthenticated => _wasAuthenticated;

  Future<Either<Failure, EntityModelList<ProfileModel>>> filterOrders() =>
      filterProfileUseCase.filter();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result = Future.value();
    if (uc is FilterProfileUseCase<ProfileModel>) {
      filterProfileUseCase = uc;
      result = filterOrders().then((value) => Future.value(value as T));
    } else if (uc is GetProfileUseCase<ProfileModel>) {
      getProfileUseCase = uc;
    } else {
      result = getProfiles().then((value) => Future.value(value as T));
    }
    return result;
  }

  Future<String?> getIdToken() {
    final idp = ManagerAuthorizationService().get(defaultIdpKey);
    return idp != null ? idp.getIdToken() : Future.value("");
  }

  ProfileModel getProfile(String idToken) {
    final parts = idToken.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }
    profile = profileModelFromJson(UtilService.decodeBase64(parts[1]));
    return profile!;
  }

  Future<Either<Failure, ProfileModel>> getProfileByParams() =>
      getProfileUseCase.getProfile();

  Future<Either<Failure, EntityModelList<ProfileModel>>> getProfiles() =>
      listOrderUseOrder.getAll();

  Future<bool> isAuthenticated() async {
    log('Entrando a isAuthenticated On Security Controller');
    authStatus = AuthStatus.cheking;
    final service = ManagerAuthorizationService().get(defaultIdpKey);

    final authenticated = service != null
        ? await service.setContext(Get.context!).isAuthenticated()
        : false;
    if (authenticated) {
      log('El token es válido');
      authStatus = AuthStatus.authenticated;
      update();
      return _wasAuthenticated = Future.value(true);
    } else {
      log('El token no es válido');
      /*if (service != null) {
        service.clear();
        service.deleteAll();
        service.endSession();
      }*/

      authStatus = AuthStatus.notAuthenticated;
      update();
      return _wasAuthenticated = Future.value(false);
    }
  }

  Future<bool> isUserAuthenticated() => authenticateUseCase.isAuthenticated();

  bool isValid() {
    return authStatus == AuthStatus.authenticated;
  }

  Future<ProfileModel?> loadProfile() async {
    final service = ManagerAuthorizationService().get(defaultIdpKey);
    final session = service?.getUserSession();
    String? idToken = session?.getIdToken;
    profile = null;
    try {
      /* if (idToken == null || idToken.isEmpty) {
        await service!.refreshAccessToken();
        idToken = session?.getIdToken;
      }*/
      if (idToken != null && idToken.isNotEmpty) {
        profile = getProfile(idToken);
        if (profile != null && session != null) {
          profile!.setLastAuthenticated(DateTime.now());
          profile!.setAuthenticationExpireIn(session.getExpirationDate);
          log("Perfil:${profile!.toJson().toString()}");
          session.addData("profile", profileModelToJson(profile!),
              replace: true);
        } else {
          session?.remove("profile");
        }
      }
    } on Exception catch (ex) {
      log("Error===>${ex.toString()}");
      session?.remove("profile");
    }
    return Future.value(profile);
  }

  login(String code) {
    final provider = Get.find<TokenProvider>();
    log('Se recive respuesta del identity auth_code: $code');
    LocalSecureStorage.storage.write('authCode', code);
    provider.getToken(code).then((token) {
      log('Se recibe Token desde el identity: ${token!.accessToken}');
      DateTime expirationTime =
          DateTime.now().add(token.expiresIn!.timeZoneOffset);
      LocalSecureStorage.storage.write('accessToken', token.accessToken ?? "");
      LocalSecureStorage.storage.write('idToken', token.idToken ?? "");
      final service = ManagerAuthorizationService().get(defaultIdpKey);
      if (service != null) {
        service.write('refreshToken', token.refreshToken ?? "");
        LocalSecureStorage.storage
            .write('expirationTime', expirationTime.toString());
        //TODO Cargar el perfil del usuario antes de navegar al HOME
        authStatus = AuthStatus.authenticated;
        update();
        Get.toNamed(Routes.getInstance.getPath("APP_HOME"));
        log('controller: usuario autenticado correctamente');
      } else {
        authStatus = AuthStatus.notAuthenticated;
        update();
        Get.toNamed(Routes.getInstance.getPath("APP_HOME"));
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    }).catchError((e) {
      NotificationService.showMsgError("Usuario o contraseña incorrecta.");
      throw 'Error en login --> $e';
    });
  }

  logout() async {
    final logoutUrl = Uri.parse(_urlLogout());
    final service = ManagerAuthorizationService().get(defaultIdpKey);
    service != null ? await service.clear() : null;
    authStatus = AuthStatus.notAuthenticated;
    update();
    LaunchUrlService.openUrl(logoutUrl, true);
    Get.toNamed(Routes.getInstance.getPath("INDEX"));
  }

  Future<bool> refreshtoken() async {
    log('Entrando a refresToken');
    bool status = false;
    final provider = Get.find<TokenProvider>();
    var value = await provider.refreshToken();
    value.fold((l) {
      status = false;
      log('error renegociando el token');
    }, (token) {
      DateTime expirationTime =
          DateTime.now().add(token.expiresIn!.timeZoneOffset);
      LocalSecureStorage.storage.write('accessToken', token.accessToken ?? "");
      LocalSecureStorage.storage.write('idToken', token.idToken ?? "");
      LocalSecureStorage.storage
          .write('refreshToken', token.refreshToken ?? "");
      LocalSecureStorage.storage
          .write('expirationTime', expirationTime.toString());
      status = true;
      log('El token a sido renegociado');
    });
    return status;
  }

  Future<Either<Failure, void>> savePkcePair(PkcePair pkcePair) async {
    return authenticateUseCase.savePkcePair(pkcePair);
  }

  Future<bool> toLogin() async {
    final response = await authenticateUseCase.call(null);
    return response.fold((l) => Future.value(false), (r) => Future.value(true));
  }

  Map<String, dynamic> _parseJwt(String idToken) {
    try {
      final ProfileMap = getProfile(idToken);
      return ProfileMap.toJson();
    } on Exception {
      log("Error al intentar obtener un token.");
      return {};
    }
  }

  String _urlLogin() {
    final service = ManagerAuthorizationService().get(defaultIdpKey);
    String uri =
        '${PathsService.identityAuthorizationEndpoint}?response_type=code';
    uri = '$uri&client_id=${CodesAppServices.clientId}&scope=openid';
    uri = '$uri&redirect_uri=${Router.redirectUri('/static.html')}';
    uri =
        '$uri&code_challange=${service != null ? service.read(key: 'codeChallenge') : ""}}';
    uri = '$uri&code_challange_method=S256';
    return uri;
  }

  String _urlLogout() {
    final service = ManagerAuthorizationService().get(defaultIdpKey);
    String query =
        'id_hint_token=${service != null ? service.read(key: 'idToken') : ""}';
    query =
        '$query&code=${service != null ? service.read(key: 'authCode') : ""}';
    query =
        '$query&post_logout_redirect_uri=${Router.redirectUri('/static.html')}';
    return 'https://${PathsService.identityLogoutEndpoint}?$query';
  }
}
