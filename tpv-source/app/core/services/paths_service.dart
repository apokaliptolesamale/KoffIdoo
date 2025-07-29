// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:io';

import '../../../globlal_constants.dart';

class PathsService {
  static final enzonaHost = "enzona.net";

  // Configuraciones para authenticación contra identity.
  static final identityHost =
      Platform.isAndroid ? 'identity.$enzonaHost' : 'identity.$enzonaHost';

  // Your Key for identity configuration service
  static final identityKey = 'identity';

  //ApiUrl
  static final identityApiUrl = "https://api.$identityHost";

  // Your Token End point in WSO2 Store
  static final identityTokenEndpoint = '$identityHost/oauth2/token';
  // Your Logout End point in WSO2 Store
  static final identityLogoutEndpoint = '$identityHost/oidc/logout';
  // Your Authorization End point in WSO2 Store
  static final identityAuthorizationEndpoint = '$identityHost/oauth2/authorize';
  // Your client ID obtained by creating an application in WSO2 Store
  static String identityAuthClientId = 'RhvYfINtZYnPrjjhOzf958qNWrsa';
  //static String identityAuthClientId = 'ofr3Wz9nnfZaFd18OewdZYvuTaEa';
  // Your client secret by creating an application in WSO2 Store
  static String identityAuthClientSecret = "wfn72Mr248Az2zAn5auN4C4GKVAa";
  //static String identityAuthClientSecret = "Prpn_XHMzVz3PBaK20OJ0BGyDnoa";

  // WSO2 API Cloud URL domain
  static String identityAuthDomain = identityHost;
  // Auth token issuer domain
  static String identityAuthIssuer = 'https://$identityAuthDomain';
  // Call back URL specified in your application
  static String apkRedirectUri = '$globalApplicationId://apk-callback';
  // Your tenant domain
  static String identityTenantDomain = 'carbon';

  /// Configuraciones para authenticación contra ApiManager.
  // Your Key for identity configuration service

  static final apiManagerHost =
      Platform.isAndroid ? 'apiez.$enzonaHost' : 'apiez.$enzonaHost';

  static final apiManagerConsumerKey = "wvl7R0op9fHRbQHA_YdZ_ABRuPIa";

  static final apiManagerConsumerSecret = "20KGS_e1Lefths4qVlqhwcPs7GQa";

  // Your Logout End point in WSO2 Store
  static final apiManagerLogoutEndpoint = '$apiManagerHost/logout';

  // Your Token End point in WSO2 Store
  static final apiManagerTokenEndpoint = '$apiManagerHost/token';

  // Your Authorization End point in WSO2 Store
  static final apiManagerAuthorizationEndpoint = '$apiManagerHost/authorize';

  // WSO2 API Cloud URL domain
  static String apiManagerAuthDomain = apiManagerHost;
  // Auth token issuer domain
  static String apiManagerAuthIssuer = 'https://$apiManagerAuthDomain';
  // Your tenant domain
  static String apiManagerTenantDomain = 'carbon';

  /// Configuraciones para authenticación contra ApiManager.
  // Your Key for identity configuration service
  static final apiFucKey = 'apiFucManager';
  static final apiFucManagerHost =
      Platform.isAndroid ? 'apis-fuc.minjus.gob.cu' : 'apis-fuc.minjus.gob.cu';

  static final apiFucManagerConsumerKey = "WtW1tsbmUj37dHhyF7SBF4yqdJsa";

  static final apiFucManagerConsumerSecret = "lx8Rh9mdMeC9KWhGx2yiByTFyxAa";

  // Your Logout End point in WSO2 Store
  static final apiFucManagerLogoutEndpoint = '$apiFucManagerHost/logout';

  // Your Token End point in WSO2 Store
  static final apiFucManagerTokenEndpoint = '$apiFucManagerHost/token';

  // Your Authorization End point in WSO2 Store
  static final apiFucManagerAuthorizationEndpoint =
      '$apiFucManagerHost/authorize';

  // WSO2 API Cloud URL domain
  static String apiFucManagerAuthDomain = apiFucManagerHost;
  // Auth token issuer domain
  static String apiFucManagerAuthIssuer = 'https://$apiFucManagerAuthDomain';
  // Your tenant domain
  static String apiFucManagerTenantDomain = 'carbon';

  //

  static final tpvEndpoint = 'http://10.12.30.8:1880/ui';

  static final apiEndpoint = 'api.$enzonaHost';

  static const tokenIntrospect = '/oauth2/introspect';

  static final apiOperationHost = 'http://192.0.134.72:8085';

  static var mediaHost = "https://media.enzona.net/";

  static var nomUrlService = "https://$apiManagerHost/nomenclator/v1/";

  static var qrUrlService = "https://$apiManagerHost/qr/v1/";

  static var warrantyUrlService = "https://$apiManagerHost/warranty/v1/";

  static var orderUrlService = "https://$apiManagerHost/order/v1/";

  static var tpvUrlService = "https://$apiManagerHost/tpv/v1/";

  static var productUrlService = "https://$apiManagerHost/product/v1/";

  static var trdProductUrlService =
      "https://192.0.135.135:9443/services/garantia/";

  static var merchantUrlService = "https://tocplaza.enzona.net/";

  static var smsUrlService = "https://$apiManagerHost/product/v1/";

  //static var prestaShopHost = "10.12.30.12";
  static var prestaShopHost = "tiendatest.enzona.net";

  static var prestaShopKey = "GMP476LBN1L3D4GV89EUJ3S3YIZ7BJTN";
}
