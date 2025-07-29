// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';

import '/app/core/config/app_config.dart';
import '/app/core/interfaces/entity_model.dart';
import '/globlal_constants.dart';
import '../../../app/core/services/identity_authorization_service.dart';
import '../../../app/core/services/logger_service.dart';

class ManagerAuthorizationService {
  static final ManagerAuthorizationService _instance =
      ManagerAuthorizationService._internal();
  final Map<String, IdentityAuthorizationService> _authorizationServices = {};

  List<IdentityAuthorizationService> _idps = [];

  factory ManagerAuthorizationService() => _instance;

  ManagerAuthorizationService._internal() {
    Get.lazyPut<ManagerAuthorizationService>(() => this);
    log("Iniciando Administración de instancias de AuthorizationService...");
  }
  Map<String, IdentityAuthorizationService> get getServices =>
      _authorizationServices;

  IdentityAuthorizationService create({
    required String key,
    required String authorizationEndpoint,
    required String tokenEndpoint,
    required String endSessionEndpoint,
    required String userinfoEndpoint,
    required String consumerKey,
    required String authDomain,
    required String authIssuer,
    required String redirectUri,
    String? consumerSecret,
    bool active = true,
    bool ignoreOnError = false,
    bool withPkce = true,
    String domain = "enzona.net",
    List<String> scopes = const [
      'openid',
      'openid apim:subscribe',
      'email',
      'offline_access',
      'api'
    ],
  }) {
    log("For $key=> Iniciando instancia de IdentityAuthorizationService con identificador=$key");
    log("For $key=> authorizationEndpoint=$authorizationEndpoint");
    log("For $key=> tokenEndpoint=$tokenEndpoint");
    log("For $key=> endSessionEndpoint=$endSessionEndpoint");
    log("For $key=> userinfoEndpoint=$userinfoEndpoint");
    final service = IdentityAuthorizationService(
      key: key,
      authorizationEndpoint: authorizationEndpoint,
      tokenEndpoint: tokenEndpoint,
      scopes: scopes,
      endSessionEndpoint: endSessionEndpoint,
      userinfoEndpoint: userinfoEndpoint,
      consumerKey: consumerKey,
      consumerSecret: consumerSecret,
      authDomain: authDomain,
      authIssuer: authIssuer,
      redirectUri: redirectUri,
      active: active,
      ignoreOnError: ignoreOnError,
      withPkce: withPkce,
    );
    if (!_authorizationServices.containsKey(key)) {
      _authorizationServices[key] = service;
    }
    return service;
  }

  IdentityAuthorizationService? get(String key) {
    log("For $key=> Getting instance of IdentityAuthorizationService for $key");
    final result = has(key) ? _authorizationServices[key] : null;
    return result;
  }

  bool has(String key) {
    return _authorizationServices.isNotEmpty &&
        _authorizationServices.containsKey(key) &&
        _authorizationServices[key] != null;
  }

  List<IdentityAuthorizationService> loadIdentityServices() {
    final model = ConfigApp.getInstance.getConfigModelAsMap();
    if (model.isNotEmpty && model.containsKey("idps")) {
      _idps = List<IdentityAuthorizationService>.from(
          model["idps"].map((json) => create(
                key: EntityModel.getValueFromJson("key", json, "key"),
                consumerKey:
                    EntityModel.getValueFromJson("consumerKey", json, ""),
                consumerSecret:
                    EntityModel.getValueFromJson("consumerSecret", json, null),
                domain:
                    EntityModel.getValueFromJson("domain", json, "enzona.net"),
                redirectUri: EntityModel.getValueFromJson(
                    "redirectUri", json, "$globalApplicationId://apk-callback"),
                authDomain:
                    EntityModel.getValueFromJson("authDomain", json, ""),
                authIssuer:
                    EntityModel.getValueFromJson("authIssuer", json, ""),
                authorizationEndpoint: EntityModel.getValueFromJson(
                    "authorizationEndpoint", json, "/authorize"),
                tokenEndpoint: EntityModel.getValueFromJson(
                    "tokenEndpoint", json, "/token"),
                endSessionEndpoint: EntityModel.getValueFromJson(
                    "endSessionEndpoint", json, "/logout"),
                userinfoEndpoint: EntityModel.getValueFromJson(
                    "userinfoEndpoint", json, "/userinfo"),
                scopes: EntityModel.getValueFromJson("scopes", json, [
                  'openid',
                  'openid apim:subscribe',
                  'email',
                  'offline_access',
                  'api'
                ]),
                ignoreOnError: EntityModel.getValueFromJson(
                  "ignoreOnError",
                  json,
                  false,
                  reader: (key, data, defaultValue) {
                    if (data.containsKey(key)) {
                      return data[key].toString() == "true";
                    }
                    return false;
                  },
                ),
                active: EntityModel.getValueFromJson(
                  "active",
                  json,
                  false,
                  reader: (key, data, defaultValue) {
                    if (data.containsKey(key)) {
                      return data[key].toString() == "true";
                    }
                    return false;
                  },
                ),
                withPkce: EntityModel.getValueFromJson(
                  "withPkce",
                  json,
                  false,
                  reader: (key, data, defaultValue) {
                    return data.containsKey(key) && data[key] == "true";
                  },
                ),
              )));
      return _idps;
    }
    return [];
  }
}
