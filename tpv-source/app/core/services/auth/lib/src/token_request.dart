import 'authorization_service_configuration.dart';
import 'common_request_details.dart';

/// Details for a token exchange request.
class TokenRequest extends CommonRequestDetails {
  /// The client secret.
  String? sessionState;

  /// The client secret.
  final String? clientSecret;

  /// The refresh token.
  final String? refreshToken;

  /// The grant type.
  ///
  /// If this is not specified then it will be inferred based on if
  /// [refreshToken] or [authorizationCode] has been specified.
  final String? grantType;

  /// The authorization code.
  final String? authorizationCode;

  /// The code verifier to be sent with the authorization code. This should
  /// match the code verifier used when performing the authorization request
  final String? codeVerifier;

  TokenRequest(
    String clientId,
    String redirectUrl, {
    this.clientSecret,
    List<String>? scopes,
    String? issuer,
    String? discoveryUrl,
    AuthorizationServiceConfiguration? serviceConfiguration,
    Map<String, String>? additionalParameters,
    String? nonce,
    this.refreshToken,
    this.grantType,
    String? session,
    this.authorizationCode,
    this.codeVerifier,
    bool allowInsecureConnections = false,
  }) {
    sessionState = session;
    this.clientId = clientId;
    this.redirectUrl = redirectUrl;
    this.scopes = scopes;
    this.serviceConfiguration = serviceConfiguration;
    this.additionalParameters = additionalParameters;
    this.nonce = nonce;
    this.issuer = issuer;
    this.discoveryUrl = discoveryUrl;
    this.allowInsecureConnections = allowInsecureConnections;
    assertConfigurationInfo();
  }
}
