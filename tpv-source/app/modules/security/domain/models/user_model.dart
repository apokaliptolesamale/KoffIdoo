import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:xml/xml.dart';

import '/app/modules/security/domain/models/role_model.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../widgets/utils/custom_datetime_converter.dart';
import '../entities/role.dart';
import '../entities/user.dart';

UserList profileListModelFromJson(String str) =>
    UserList.fromJson(json.decode(str));

UserModel profileModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String profileModelToJson(UserModel data) => json.encode(data.toJson());

class UserList<T extends UserModel> implements EntityModelList<T> {
  final List<T> profiles;

  UserList({
    required this.profiles,
  });

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        profiles:
            List<T>.from(json["profiles"].map((x) => UserModel.fromJson(x))),
      );

  factory UserList.fromStringJson(String strJson) =>
      UserList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return UserList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!profiles.contains(element)) profiles.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return UserList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => profiles;

  Map<String, dynamic> toJson() => {
        "profiles": List<dynamic>.from(profiles.map((x) => x.toJson())),
      };

  static Future<T> fromXmlServiceUrl<T>(
      String url,
      String parentTagName,
      Future<T> Function(XmlDocument doc, XmlElement el) process,
      Future<T> Function() onError) async {
    return EntityModelList.fromXmlServiceUrl(
        url, parentTagName, process, onError);
  }

  static Future<T> getJsonFromXMLUrl<T>(
      String url,
      Future<T> Function(XmlDocument result) process,
      Future<T> Function() onError) async {
    return EntityModelList.getJsonFromXMLUrl(url, process, onError);
  }
}

@JsonSerializable()
class UserModel extends User implements EntityModel {
  @override
  String atHash;
  @override
  DateTime? birthday;
  @override
  String sub;
  @override
  String gender;
  @override
  List<String> amr;
  @override
  String iss;
  @override
  String personVerified;
  @override
  String identification;
  @override
  String zone;
  @override
  String azp;
  @override
  String state;
  @override
  int exp;
  @override
  int iat;
  @override
  String email;
  @override
  List<dynamic> address;
  @override
  String tomo;
  @override
  String givenName;
  @override
  String userName;
  @override
  String aud;
  @override
  int nbf;
  @override
  String folio;
  @override
  String phoneNumber;
  @override
  String familyName;
  @override
  List<Role> roles;

  @override
  String? secondFactor;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  UserModel({
    required this.atHash,
    required this.birthday,
    required this.sub,
    required this.gender,
    required this.amr,
    required this.iss,
    required this.personVerified,
    required this.identification,
    required this.zone,
    required this.azp,
    required this.state,
    required this.exp,
    required this.iat,
    required this.email,
    required this.address,
    required this.tomo,
    required this.givenName,
    required this.userName,
    required this.aud,
    required this.nbf,
    required this.folio,
    required this.phoneNumber,
    required this.familyName,
    required this.roles,
    this.secondFactor,
  }) : super(
          atHash: atHash,
          birthday: birthday,
          sub: sub,
          gender: gender,
          address: address,
          amr: amr,
          iss: iss,
          personVerified: personVerified,
          identification: identification,
          zone: zone,
          azp: azp,
          state: state,
          exp: exp,
          iat: iat,
          email: email,
          secondFactor: secondFactor,
          tomo: tomo,
          givenName: givenName,
          userName: userName,
          aud: aud,
          nbf: nbf,
          folio: folio,
          phoneNumber: phoneNumber,
          familyName: familyName,
          roles: roles,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        atHash: EntityModel.getValueFromJson("at_hash", json, ""),
        birthday: EntityModel.getValueFromJson<DateTime?>(
          "birthday",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return CustomDateTimeConverter().fromJson(json[key]);
            }
            return defaultValue;
          },
        ),
        sub: EntityModel.getValueFromJson("sub", json, ""),
        gender: EntityModel.getValueFromJson("gender", json, ""),
        //secretkey: json["secretkey"],
        amr: EntityModel.getValueFromJson<List<String>>(
          "amr",
          json,
          [],
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return List<String>.from(json[key].map((x) => x));
            }
            return defaultValue;
          },
        ),
        iss: EntityModel.getValueFromJson("iss", json, ""),
        address: EntityModel.getValueFromJson<List<String>>(
          "address",
          json,
          [],
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              if (json[key] is Map) {
                final tmp = (json[key] as Map<String, dynamic>).map(
                    (key, value) =>
                        MapEntry<String, String>(key, value.toString()));
                return List<String>.from(tmp.values);
              } else if (json[key] is String) {
                return [json[key]];
              }
            }
            return defaultValue;
          },
        ),
        personVerified:
            EntityModel.getValueFromJson("person_verified", json, ""),
        identification:
            EntityModel.getValueFromJson("identification", json, ""),
        zone: EntityModel.getValueFromJson("zone", json, ""),
        azp: EntityModel.getValueFromJson("azp", json, ""),
        state: EntityModel.getValueFromJson("state", json, ""),
        exp: EntityModel.getValueFromJson("exp", json, -1),
        iat: EntityModel.getValueFromJson("iat", json, -1),
        email: EntityModel.getValueFromJson("email", json, ""),
        secondFactor: EntityModel.getValueFromJson("secondFactor", json, ""),
        tomo: EntityModel.getValueFromJson("tomo", json, ""),
        givenName: EntityModel.getValueFromJson("given_name", json, ""),
        userName: EntityModel.getValueFromJson(
          "userName",
          json,
          json['sub'],
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) return json[key];
            return defaultValue;
          },
        ),
        aud: EntityModel.getValueFromJson(
          "aud",
          json,
          "",
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              if (json[key] is List) {
                return (json[key] as List).toString();
              }
              if (json[key] is String) {
                return json[key].toString();
              }
            }
            return defaultValue;
          },
        ),
        nbf: EntityModel.getValueFromJson("nbf", json, -1),
        folio: EntityModel.getValueFromJson("folio", json, ""),
        phoneNumber: EntityModel.getValueFromJson("phone_number", json, ""),
        familyName: EntityModel.getValueFromJson("family_name", json, ""),
        roles: EntityModel.getValueFromJson<List<Role>>(
          "roles",
          json,
          [],
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              if (json[key] is List) {
                var data = json[key] as List;
                final roles = CustomRoleSingleList.instance
                    .getRolesByIds(data.map((e) => e.toString()).toList());
                return roles;
              }
            }
            return defaultValue;
          },
        ),
      );

  @override
  // TODO: implement getMetaModel
  Map<String, ColumnMetaModel>? get getMetaModel => throw UnimplementedError();

  List<Object?> get props => [];

  @override
  set setMetaModel(Map<String, ColumnMetaModel> metaModel) {
    // TODO: implement setMetaModel
  }

  bool? get stringify => true;

  //method generated by wizard

  T cloneWith<T extends EntityModel>(T other) {
    return UserModel.fromJson(other.toJson()) as T;
  }

  @override
  EntityModelList createModelListFrom(data) {
    // TODO: implement createModelListFrom
    throw UnimplementedError();
  }

  T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
    return UserModel.fromJson(params) as T;
  }

  String getAllAddress() {
    String add = "";
    if (address.isNotEmpty) {
      for (var element in address) {
        element = element
            .replaceAll("\n", "")
            .replaceAll('{"address":"', "")
            .replaceAll('"', "")
            .replaceAll("}", "");
        add += "$element \n";
      }
    }
    return add;
  }

  @override
  Map<String, ColumnMetaModel> getColumnMetaModel() {
    // TODO: implement getColumnMetaModel
    throw UnimplementedError();
  }

  @override
  Map<String, String> getColumnNames() {
    // TODO: implement getColumnNames
    throw UnimplementedError();
  }

  @override
  List<String> getColumnNamesList() {
    // TODO: implement getColumnNamesList
    throw UnimplementedError();
  }

  @override
  Map<K1, V1> getMeta<K1, V1>(String searchKey, searchValue) {
    // TODO: implement getMeta
    throw UnimplementedError();
  }

  @override
  Map<String, String> getVisibleColumnNames() {
    // TODO: implement getVisibleColumnNames
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() => {
        "at_hash": atHash,
        "birthday": birthday != null ? birthday!.toIso8601String() : null,
        "sub": sub,
        "gender": gender,
        "amr": List<String>.from(amr.map((x) => x)),
        "iss": iss,
        "address": address,
        "person_verified": personVerified,
        "identification": identification,
        "zone": zone,
        "azp": azp,
        "state": state,
        "exp": exp,
        "iat": iat,
        "email": email,
        "secondFactor": secondFactor,
        "tomo": tomo,
        "given_name": givenName,
        "userName": userName,
        "aud": aud,
        "nbf": nbf,
        "folio": folio,
        "phone_number": phoneNumber,
        "family_name": familyName,
        "roles": roles.map((role) => (role as RoleModel).toJson()).toList(),
      };

  @override
  toString() => toJson().toString();

  @override
  Map<String, ColumnMetaModel> updateColumnMetaModel(
      String keySearch, valueSearch, newValue) {
    // TODO: implement updateColumnMetaModel
    throw UnimplementedError();
  }
}
