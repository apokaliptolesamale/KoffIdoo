/*import 'dart:convert';

import '../../../../../app/modules/security/domain/models/profile_model.dart';
import '../../../../widgets/utils/custom_datetime_converter.dart';*/
import 'role.dart';

class User {
  String atHash;
  DateTime? birthday;
  String sub;
  String gender;
  List<String> amr;
  String iss;
  String personVerified;
  String identification;
  String zone;
  String azp;
  String state;
  int exp;
  int iat;
  String email;
  List<dynamic> address;
  String tomo;
  String givenName;
  String userName;
  String aud;
  int nbf;
  String folio;
  String phoneNumber;
  String familyName;

  List<Role> roles;

  String? secondFactor;

  User({
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
  });

  /*factory User.fromJson(String str) => User.fromMap(json.decode(str));

  factory User.fromMap(Map<String, dynamic> json) => User(
        atHash: json["at_hash"],
        birthday:
            CustomDateTimeConverter().fromJson(json["birthday"] as String),
        sub: json["sub"],
        gender: json["gender"],
        amr: json["amr"],
        iss: json["iss"],
        personVerified: json["person_verified"],
        identification: json["identification"],
        zone: json["zone"],
        azp: json["azp"],
        state: json["state"],
        exp: json["exp"],
        iat: json["iat"],
        email: json["email"],
        address: json["address"],
        tomo: json["tomo"],
        givenName: json["given_name"],
        userName: json["userName"],
        aud: json["aud"],
        nbf: json["nbf"],
        folio: json["folio"],
        phoneNumber: json["phone_number"],
        familyName: json["family_name"],
        roles:[],
      );

  factory User.fromPayLoad(ProfileModel profile) =>
      User.fromMap(profile.toJson());

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "at_hash": atHash,
        "birthday":
            "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "sub": sub,
        "gender": gender,
        "amr": amr,
        "iss": iss,
        "person_verified": personVerified,
        "identification": identification,
        "zone": zone,
        "azp": azp,
        "state": state,
        "exp": exp,
        "iat": iat,
        "email": email,
        "address": address,
        "tomo": tomo,
        "given_name": givenName,
        "userName": userName,
        "aud": aud,
        "nbf": nbf,
        "folio": folio,
        "phone_number": phoneNumber,
        "family_name": familyName,
      };*/
}
