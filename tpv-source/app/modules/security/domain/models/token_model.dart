// ignore_for_file: overridden_fields

import 'dart:convert';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../../app/modules/security/domain/entities/token.dart';
import '../../../../../app/widgets/utils/custom_datetime_converter.dart';

class TokenModel extends Token {
  @override
  String? accessToken;

  @override
  String? refreshToken;
  @override
  List<String> scope;
  @override
  String? idToken;
  @override
  String? tokenType;
  @override
  DateTime? expiresIn;
  @override
  bool isValid;

  TokenModel({
    this.accessToken,
    this.refreshToken,
    this.scope = const [],
    this.idToken,
    this.tokenType,
    this.expiresIn,
    this.isValid = false,
  }) : super(
          accessToken: accessToken,
          expiresIn: expiresIn,
          idToken: idToken,
          refreshToken: refreshToken,
          tokenType: tokenType,
          scope: scope,
          isValid: isValid,
        );

  factory TokenModel.fromJson(String str) =>
      TokenModel.fromMap(json.decode(str));

  factory TokenModel.fromMap(Map<String, dynamic> json) => TokenModel(
        accessToken: EntityModel.getValueFromJson("accessToken", json, null),
        refreshToken: EntityModel.getValueFromJson("refreshToken", json, null),
        scope: EntityModel.getValueFromJson(
          "scope",
          json,
          [],
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return List<String>.from(data[key].map((x) => x));
            }
            return defaultValue;
          },
        ), //List<String>.from(json["scope"])
        idToken: EntityModel.getValueFromJson("idToken", json, null),
        tokenType: EntityModel.getValueFromJson("tokenType", json, null),
        expiresIn: EntityModel.getValueFromJson(
          "expiresIn",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return CustomDateTimeConverter.from(data[key]);
            }
            return defaultValue;
          },
        ),
        isValid: EntityModel.getValueFromJson("isValid", json, false),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "scope": json.encode(scope),
        "id_token": idToken,
        "token_type": tokenType,
        "expires_in": expiresIn != null ? expiresIn!.toIso8601String() : "",
      };
}
