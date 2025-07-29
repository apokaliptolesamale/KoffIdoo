class AuthorizationServiceConfiguration {
  final String authorizationEndpoint;

  final String tokenEndpoint;

  final String endSessionEndpoint;

  final String userinfoEndpoint;

  const AuthorizationServiceConfiguration({
    required this.authorizationEndpoint,
    required this.tokenEndpoint,
    required this.endSessionEndpoint,
    required this.userinfoEndpoint,
  });
}
