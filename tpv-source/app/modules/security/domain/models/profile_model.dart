// To parse this JSON data, do
//
//     final Profile = ProfileFromJson(jsonString);

// ignore_for_file: overridden_fields

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:xml/xml.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../../app/core/services/logger_service.dart';
import '../../../../../app/modules/security/domain/entities/profile.dart';
import '../../../../widgets/utils/custom_datetime_converter.dart';

ProfileList profileListModelFromJson(String str) =>
    ProfileList.fromJson(json.decode(str));

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileList<T extends ProfileModel> implements EntityModelList<T> {
  final List<T> profiles;

  ProfileList({
    required this.profiles,
  });

  factory ProfileList.fromJson(Map<String, dynamic> json) => ProfileList(
        profiles:
            List<T>.from(json["profiles"].map((x) => ProfileModel.fromJson(x))),
      );

  factory ProfileList.fromStringJson(String strJson) =>
      ProfileList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return ProfileList.fromJson(json);
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
    return ProfileList.fromStringJson(strJson);
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
class ProfileModel extends Profile implements EntityModel {
  @override
  final String atHash;

  @override
  final DateTime? birthday;

  @override
  final String sub;

  @override
  final String gender;
  //final String secretkey;
  @override
  final List<String> amr;
  @override
  final String iss;
  @override
  final String sid;
  @override
  final String personVerified;
  @override
  final String identification;
  @override
  final String zone;
  @override
  final String azp;
  @override
  final String state;
  @override
  final int exp;
  @override
  final int iat;
  @override
  final String email;
  @override
  final List<String> address;
  @override
  String? secondFactor;
  @override
  final String tomo;
  @override
  final String givenName;
  @override
  final String userName;
  @override
  final List<dynamic> aud;
  @override
  final String cHash;
  @override
  final int nbf;
  @override
  final String folio;
  @override
  final String phoneNumber;
  @override
  final String familyName;
  @override
  Map<String, ColumnMetaModel>? metaModel;
  DateTime? _lastAuthenticated;
  DateTime? _authenticationExpireIn;
  ProfileModel({
    required this.atHash,
    required this.birthday,
    required this.sub,
    required this.gender,
    //required this.secretkey,
    required this.address,
    required this.amr,
    required this.iss,
    required this.sid,
    required this.personVerified,
    required this.identification,
    required this.zone,
    required this.azp,
    required this.state,
    required this.exp,
    required this.iat,
    required this.email,
    this.secondFactor,
    required this.tomo,
    required this.givenName,
    required this.userName,
    required this.aud,
    required this.cHash,
    required this.nbf,
    required this.folio,
    required this.phoneNumber,
    required this.familyName,
    DateTime? lastAuthenticated,
    DateTime? authenticationExpireIn,
  }) : super(
          atHash: atHash,
          birthday: birthday,
          sub: sub,
          gender: gender,
          //secretkey,
          address: address,
          amr: amr,
          iss: iss,
          sid: sid,
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
          cHash: cHash,
          nbf: nbf,
          folio: folio,
          phoneNumber: phoneNumber,
          familyName: familyName,
        ) {
    _lastAuthenticated = lastAuthenticated;
    _authenticationExpireIn = authenticationExpireIn;
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
        ), //CustomDateTimeConverter().fromJson(json["birthday"] as String)
        lastAuthenticated: EntityModel.getValueFromJson<DateTime?>(
          "lastAuthenticated",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return CustomDateTimeConverter().fromJson(json[key]);
            }
            return defaultValue;
          },
        ),
        authenticationExpireIn: EntityModel.getValueFromJson<DateTime?>(
          "authenticationExpireIn",
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
        sid: EntityModel.getValueFromJson("sid", json, ""),
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
          [],
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              if (json[key] is List) {
                return List<String>.from(json[key]);
              }
            }
            return defaultValue;
          },
        ),
        cHash: EntityModel.getValueFromJson("cHash", json, ""),
        nbf: EntityModel.getValueFromJson("nbf", json, -1),
        folio: EntityModel.getValueFromJson("folio", json, ""),
        phoneNumber: EntityModel.getValueFromJson("phone_number", json, ""),
        familyName: EntityModel.getValueFromJson("family_name", json, ""),
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
    return ProfileModel.fromJson(other.toJson()) as T;
  }

  @override
  EntityModelList createModelListFrom(data) {
    // TODO: implement createModelListFrom
    throw UnimplementedError();
  }

  T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
    return ProfileModel.fromJson(params) as T;
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
        log(element);
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

  bool hasValidProfile() {
    return _authenticationExpireIn != null &&
        _authenticationExpireIn!.isBefore(DateTime.now());
  }

  void setAuthenticationExpireIn(DateTime? expiredIn) {
    _authenticationExpireIn = expiredIn;
  }

  void setLastAuthenticated(DateTime? last) {
    _lastAuthenticated = last;
  }

  @override
  Map<String, dynamic> toJson() => {
        "at_hash": atHash,
        "birthday": birthday != null ? birthday!.toIso8601String() : null,
        "sub": sub,
        "gender": gender,
        // "secretkey": secretkey,
        "amr": List<String>.from(amr.map((x) => x)),
        "iss": iss,
        "sid": sid,
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
        "c_hash": cHash,
        "nbf": nbf,
        "folio": folio,
        "phone_number": phoneNumber,
        "family_name": familyName,
        "authenticationExpireIn": _authenticationExpireIn != null
            ? _authenticationExpireIn!.toIso8601String()
            : null,
        "lastAuthenticated": _lastAuthenticated != null
            ? _lastAuthenticated!.toIso8601String()
            : null
      };

  @override
  toString() => toJson().toString();

  @override
  Map<String, ColumnMetaModel> updateColumnMetaModel(
      String keySearch, valueSearch, newValue) {
    // TODO: implement updateColumnMetaModel
    throw UnimplementedError();
  }

  //
  static ProfileModel converter(data, key) {
    return ProfileModel.fromJson(json.decode(data[key]));
  }
}
