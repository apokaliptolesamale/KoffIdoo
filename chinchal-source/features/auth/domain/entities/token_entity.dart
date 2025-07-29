class TokenEntity {
  String? accessToken;
  String? refreshToken;
  String? scope;
  String? idToken;
  String? tokenType;
  int? expiresIn;
  String? expTime;

  TokenEntity({
    this.accessToken,
    this.refreshToken,
    this.scope,
    this.idToken,
    this.tokenType,
    this.expiresIn,
    this.expTime
  }); /* : expTime = DateTime.now().add(Duration(seconds: expiresIn!)
  ); */
 TokenEntity copyWith(
  {
  String? accessToken,
  String? refreshToken,
  String? scope,
  String? idToken,
  String? tokenType,
  int? expiresIn,
  String? expTime,  
  }
 ){
  return TokenEntity(
    accessToken: accessToken??this.accessToken,
    expiresIn: expiresIn??this.expiresIn,
    idToken: idToken??this.idToken,
    refreshToken: refreshToken??this.refreshToken,
    scope: scope??this.scope,
    tokenType: tokenType??this.tokenType,
    expTime: expTime??this.expTime
  );
 }

}
