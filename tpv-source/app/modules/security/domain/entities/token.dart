class Token {
  String? accessToken;

  String? refreshToken;
  List<String> scope;
  String? idToken;
  String? tokenType;
  DateTime? expiresIn;
  bool isValid;
  Token({
    this.accessToken,
    this.refreshToken,
    this.scope = const [],
    this.idToken,
    this.tokenType,
    this.expiresIn,
    this.isValid = false,
  });
}
