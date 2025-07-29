import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static String clientId = dotenv.env['CLIENT_ID'] ?? 'Not ClientId configure';
  static String scope = dotenv.env['SCOPE'] ?? 'Not scope configure';
  static String versionApk = dotenv.env['VERSION'] ?? '1.9.10.221002';

  static String enzonaHost =
      dotenv.env['ENZONA_HOST'] ?? 'https://www.enzona.net';
  static String identityHost =
      dotenv.env['IDENTITY_HOST'] ?? 'https://identity.enzona.net';
  static String mediaHost =
      dotenv.env['MEDIA_HOST'] ?? 'https://media.enzona.net';
  static String apiEndpoint =
      dotenv.env['API_HOST'] ?? 'https://api.enzona.net';

  static String authorizationEndpoint =
      dotenv.env['AUTHORIZATION_ENDPOINT'] ?? '/oauth2/authorize';
  static String tokenEndpoint = dotenv.env['TOKEN_ENDPOINT'] ?? '/oauth2/token';
  static String logoutEndpoint =
      dotenv.env['LOGOUT_ENDPOINT'] ?? '/oidc/logout';
  static String tokenIntrospect =
      dotenv.env['INTROSPECT_ENDPOINT'] ?? '/oauth2/introspect';
  static String redirectUri =
      dotenv.env['ENZONA_HOST'] ?? 'https://www.enzona.net';

  static var notifyUrlService =
      dotenv.env['NOTIFY_URL'] ?? "wss://ntfyenzona.platel.cu";

  static Map<String, String> defaultHeaders = {
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
      'Version': versionApk
    };
    return toAdd;
  }
}
