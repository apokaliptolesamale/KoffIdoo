// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/profile.dart';




ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel  extends ProfileEntity{
    @override
  String? atHash;
    @override
  DateTime? birthday;
    @override
  String? sub;
    @override
  dynamic address;
    @override
  String? gender;
    @override
  List<String>? amr;
    @override
  String? secondFactor;
    @override
  String? iss;
    @override
  String? tomo;
    @override
  String? givenName;
    @override
  String? personVerified;
    @override
  String? aud;
    @override
  String? cHash;
    @override
  String? nbf;
    @override
  String? identification;
    @override
  String? zone;
    @override
  String? azp;
    @override
  String? folio;
    @override
  String? phoneNumber;
    @override
  String? state;
    @override
  String? exp;
    @override
  String? iat;
    @override
  String? familyName;
    @override
  String? email;

    ProfileModel({
       this.atHash,
       this.birthday,
       this.sub,
       this.address,
       this.gender,
       this.amr,
       this.secondFactor,
       this.iss,
       this.tomo,
       this.givenName,
       this.personVerified,
       this.aud,
       this.cHash,
       this.nbf,
       this.identification,
       this.zone,
       this.azp,
       this.folio,
       this.phoneNumber,
       this.state,
       this.exp,
       this.iat,
       this.familyName,
       this.email,
    }) : super(
        atHash: atHash,
          birthday: birthday,
          sub: sub,
          gender: gender,
          //secretkey,
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
          
          aud: aud,
          cHash: cHash,
          nbf: nbf,
          folio: folio,
          phoneNumber: phoneNumber,
          familyName: familyName,
     
    );

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        atHash: json.containsKey("at_hash") && json["at_hash"] != null
            ? json["at_hash"].toString()
            : null,
        //json["at_hash"],
        birthday: json.containsKey("birthday") && json["birthday"] != null
            ? DateTime.parse(json["birthday"])
            : null,
        //DateTime.parse(json["birthday"]),
        sub: json.containsKey("sub") && json["sub"] != null
            ? json["sub"].toString()
            : null,
        //json["sub"],
        address: json.containsKey("address") && json["address"] != null && json['address'] is List
            ? List<String>.from(json["address"].map((x) => x)).toList()
            : json.containsKey("address") && json["address"] != null && json['address'] is Map
            ? json['address']
            :null,
        //List<String>.from(json["address"].map((x) => x)),
        gender: json.containsKey("gender") && json["gender"] != null
            ? json["gender"].toString()
            : null,
        //json["gender"],
        amr: json.containsKey("amr") && json["amr"] != null
            ? List<String>.from(json["amr"].map((x) => x))
            : null,
        //List<String>.from(json["amr"].map((x) => x)),
        secondFactor: json.containsKey("secondFactor") && json["secondFactor"] != null
            ? json["secondFactor"].toString()
            : null,
        //json["secondFactor"],
        iss:  json.containsKey("iss") && json["iss"] != null
            ? json["iss"].toString()
            : null,
        //json["iss"],
        tomo: json.containsKey("tomo") && json["tomo"] != null
            ? json["tomo"].toString()
            : null,
        //json["tomo"],
        givenName: json.containsKey("given_name") && json["given_name"] != null
            ? json["given_name"].toString()
            : null,
        //json["given_name"],
        personVerified: json.containsKey("person_verified") && json["person_verified"] != null
            ? json["person_verified"].toString()
            : null,
        //json["person_verified"],
        aud:  json.containsKey("aud") && json["aud"] != null
            ? json["aud"].toString()
            : null,
        //json["aud"],
        cHash: json.containsKey("c_hash") && json["c_hash"] != null
            ? json["c_hash"].toString()
            : null,
        //json["c_hash"],
        nbf: json.containsKey("nbf") && json["nbf"] != null
            ? json["nbf"].toString()
            : null,
        //json["nbf"],
        identification: json.containsKey("identification") && json["identification"] != null
            ? json["identification"].toString()
            : null,
        //json["identification"],
        zone: json.containsKey("zone") && json["zone"] != null
            ? json["zone"].toString()
            : null,
        //json["zone"],
        azp:  json.containsKey("azp") && json["azp"] != null
            ? json["azp"].toString()
            : null,
        //json["azp"],
        folio: json.containsKey("folio") && json["folio"] != null
            ? json["folio"].toString()
            : null,
        //json["folio"],
        phoneNumber: json.containsKey("phone_number") && json["phone_number"] != null
            ? json["phone_number"].toString()
            : null,
        //json["phone_number"],
        state:json.containsKey("state") && json["state"] != null
            ? json["state"].toString()
            : null,
        // json["state"],
        exp: json.containsKey("exp") && json["exp"] != null
            ? json["exp"].toString()
            : null,
        //json["exp"],
        iat: json.containsKey("iat") && json["iat"] != null
            ? json["iat"].toString()
            : null,
        //json["iat"],
        familyName: json.containsKey("family_name") && json["family_name"] != null
            ? json["family_name"].toString()
            : null,
        //json["family_name"],
        email: json.containsKey("email") && json["email"] != null
            ? json["email"].toString()
            : null,
        //json["email"],
    );

    Map<String, dynamic> toJson() => {
        "at_hash": atHash,
        "birthday": "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
        "sub": sub,
        "address": address is Map 
         ?address as Map<String,dynamic> 
         :List<dynamic>.from(address!.map((x) => x)),
        "gender": gender,
        "amr": List<dynamic>.from(amr!.map((x) => x)),
        "secondFactor": secondFactor,
        "iss": iss,
        "tomo": tomo,
        "given_name": givenName,
        "person_verified": personVerified,
        "aud": aud,
        "c_hash": cHash,
        "nbf": nbf,
        "identification": identification,
        "zone": zone,
        "azp": azp,
        "folio": folio,
        "phone_number": phoneNumber,
        "state": state,
        "exp": exp,
        "iat": iat,
        "family_name": familyName,
        "email": email,
    };
}
