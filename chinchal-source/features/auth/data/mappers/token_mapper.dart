import 'dart:convert';

import 'package:apk_template/features/auth/domain/domain.dart';

class TokenMapper {
  static tokenJsonToEntity(Map<String, dynamic> json) => TokenEntity(
        accessToken:
            json.containsKey("access_token") && json["access_token"] != null
                ? json["access_token"]
                : null,
        /*json["access_token"],*/
        refreshToken:
            json.containsKey("refresh_token") && json["refresh_token"] != null
                ? json["refresh_token"]
                : null,
        // json["refresh_token"],
        scope: json.containsKey("scope") && json["scope"] != null
            ? json["scope"]
            : null,
        //  json["scope"],
        idToken: json.containsKey("id_token") && json["id_token"] != null
            ? json["id_token"]
            : null,
        //json["id_token"],
        tokenType: json.containsKey("token_type") && json["token_type"] != null
            ? json["token_type"]
            : null,
        //json["token_type"],
        expiresIn: json.containsKey("expires_in") && json["expires_in"] != null
            ? json["expires_in"]
            : null,
        expTime: json.containsKey("expTime") && json["expTime"] != null
            ? json["expTime"]
            : null,
      );

  static tokenEntityToJson(TokenEntity tokenEntity) => json.encode({
        "access_token": tokenEntity.accessToken,
        "refresh_token": tokenEntity.refreshToken,
        "scope": tokenEntity.scope,
        "id_token": tokenEntity.idToken,
        "token_type": tokenEntity.tokenType,
        "expires_in": tokenEntity.expiresIn,
        "expTime":tokenEntity.expTime
      });
}
