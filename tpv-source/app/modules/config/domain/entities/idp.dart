// ignore_for_file: public_member_api_docs, sort_constructors_first
class Idp {
  final String key;
  final String consumerKey;
  final String? consumerSecret;
  final bool ignoreOnError, active;
  String? domain;
  String? redirectUri;
  String? authDomain;
  String? authIssuer;
  String? authorizationEndpoint;
  String? tokenEndpoint;
  String? endSessionEndpoint;
  String? userinfoEndpoint;
  final List<String> scopes;
  final bool withPkce;
  Idp({
    required this.key,
    required this.consumerKey,
    this.consumerSecret,
    required this.ignoreOnError,
    required this.active,
    required this.domain,
    required this.redirectUri,
    required this.authDomain,
    required this.authIssuer,
    required this.authorizationEndpoint,
    required this.tokenEndpoint,
    required this.endSessionEndpoint,
    required this.userinfoEndpoint,
    required this.scopes,
    required this.withPkce,
  });
}
