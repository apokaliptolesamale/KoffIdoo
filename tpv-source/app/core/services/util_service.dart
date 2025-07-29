import 'dart:convert';

class UtilService {
  static String decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }
    return utf8.decode(base64Url.decode(output));
  }

  static Map<String, dynamic> getFromQueryString(String query) {
    return Uri.parse(query).queryParameters;
  }

  static Map<String, String> getParamsFromQueryString(String query) {
    return Uri.splitQueryString(query);
  }

  static String queryStringFromMap(Map<String, dynamic> filters) {
    return Uri(
        queryParameters: filters
            .map((key, value) => MapEntry(key, value?.toString()))).query;
  }
}
