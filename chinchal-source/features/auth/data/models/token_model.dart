import 'dart:convert';
import '../../domain/entities/token_entity.dart';

class TokenModel extends TokenEntity {
  TokenModel({
    required super.accessToken,
    required super.refreshToken,
    required super.scope,
    required super.idToken,
    required super.tokenType,
    required super.expiresIn,
  });

  factory TokenModel.fromJson(String str) =>
      TokenModel.fromMap(json: json.decode(str));

  String toJson() => json.encode(toMap());

  factory TokenModel.fromMap({required Map<String, dynamic> json}) {
    return TokenModel(
      accessToken: json["access_token"] ?? "",
      refreshToken: json["refresh_token"] ?? "",
      scope: json["scope"] ?? "",
      idToken: json["id_token"] ?? "",
      tokenType: json["token_type"] ?? "",
      expiresIn: json["expires_in"] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "access_token": accessToken,
      "refresh_token": refreshToken,
      "scope": scope,
      "id_token": idToken,
      "token_type": tokenType,
      "expires_in": expiresIn,
    };
  }

  bool isValidAccessToken() => accessToken!.isNotEmpty;
}
