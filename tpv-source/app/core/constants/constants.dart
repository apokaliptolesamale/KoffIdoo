class Constants {
  static const clientId = 'ofr3Wz9nnfZaFd18OewdZYvuTaEa';
  static const scope = ['openid', 'openid apim:subscribe'];
  static const versionApk = '1.9.10.221002';
  static const enzonaHost = "enzona.net";
  static const identityHost = 'identity.$enzonaHost';
  static const authorizationEndpoint = '$identityHost/oauth2/authorize';
  static const tokenEndpoint = '/oauth2/token';
  static const logoutEndpoint = '/oidc/logout';
  static const apiEndpoint = 'api.$enzonaHost';
  static const tokenIntrospect = '/oauth2/introspect';
  static const redirectUri = "https://www.$enzonaHost";
  static const mediaHost = "https://media.enzona.net/";

  static const defaultHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Credentials': 'true',
    'Access-Control-Allow-Methods': 'GET, POST, PATCH, OPTIONS',
    'Access-Control-Allow-Headers':
        'X-Requested-With, Origin, Content-Type, X-Auth-Token'
  };

  static Map<String, String> getHttpDefaulHeader(String? accessToken) {
    final toAdd = {
      'Authorization': 'Bearer $accessToken',
      'accept': 'application/json',
      'Version': Constants.versionApk
    };
    return toAdd;
  }
}
