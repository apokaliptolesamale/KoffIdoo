import '../../../../interfaces/entity_model.dart';

/// Details from making a successful token exchange.
class TokenResponse {
  /// The access token returned by the authorization server.
  final String? accessToken;

  /// The refresh token returned by the authorization server.
  final String? refreshToken;

  /// Indicates when [accessToken] will expire.
  ///
  /// To ensure applications have continue to use valid access tokens, they
  /// will generally use the refresh token to get a new access token
  /// before it expires.
  final DateTime? accessTokenExpirationDateTime;

  /// The id token returned by the authorization server.
  final String? idToken;

  /// The type of token returned by the authorization server.
  final String? tokenType;

  /// Scopes of the access token. If scopes are identical to those originally
  /// requested, then this value is optional.
  final List<String>? scopes;

  /// Contains additional parameters returned by the authorization server from
  /// making the token request.
  final Map<String, dynamic>? tokenAdditionalParameters;

  TokenResponse(
    this.accessToken,
    this.refreshToken,
    this.accessTokenExpirationDateTime,
    this.idToken,
    this.tokenType,
    this.scopes,
    this.tokenAdditionalParameters,
  );

  factory TokenResponse.fromJson(Map<String, dynamic> json) => TokenResponse(
        EntityModel.getValueFromJson<String>(
          "access_token",
          json,
          "",
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key)) {
              return data[key].toString();
            }
            return defaultValue;
          },
        ),
        EntityModel.getValueFromJson(
          "refresh_token",
          json,
          "",
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key)) {
              return data[key].toString();
            }
            return defaultValue;
          },
        ),
        EntityModel.getValueFromJson(
          "expires_in",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key)) {
              return DateTime.now().toUtc().add(Duration(seconds: data[key]));
            }
            return defaultValue;
          },
        ),
        EntityModel.getValueFromJson<String>(
          "id_token",
          json,
          "",
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key)) {
              return data[key].toString();
            }
            return defaultValue;
          },
        ),
        EntityModel.getValueFromJson(
          "token_type",
          json,
          "",
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key)) {
              return data[key].toString();
            }
            return defaultValue;
          },
        ),
        EntityModel.getValueFromJson(
          "scope",
          json,
          List.empty(growable: true),
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key)) {
              List<String> a =
                  List.from(defaultValue.toString().split(" "), growable: true);
              List<String> b = data[key].toString().split(" ");
              List<String> intersect =
                  b.where((element) => !a.contains(element)).toList();
              return a..addAll(intersect);
            }
            return defaultValue;
          },
        ),
        {},
      );
}
