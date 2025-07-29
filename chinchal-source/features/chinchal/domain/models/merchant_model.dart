import 'dart:convert';

import '../entities/merchant_entity.dart';




ListMerchantModel mrchantModelFromJson(String str) => ListMerchantModel.fromJson(json.decode(str));

String merchantModelToJson(ListMerchantModel data) => json.encode(data.toJson());

class ListMerchantModel extends MerchantModel {
  
final List<MerchantModel>? content;
    

    ListMerchantModel({
        this.content,
        
    });

    factory ListMerchantModel.fromJson(Map<String, dynamic> json) => ListMerchantModel(
        content: List<MerchantModel>.from(json["content"].map((x) => MerchantModel.fromJson(x))),
        
    );
    factory ListMerchantModel.fromStringJson(String strJson) =>
      ListMerchantModel.fromJson(json.decode(strJson));
    
    @override
  Map<String, dynamic> toJson() => {
        "content": content == null ? [] : List<dynamic>.from(content!.map((x) => x.toJson())),
        
    };
}
   
class MerchantModel extends MerchantEntity{
    @override
  final String? address;
    @override
  final String? banco;
    @override
  final String? categoriaComercial;
    @override
  final String? code;
    @override
  final String? createdAt;
    @override
  final String? email;
    @override
  final String? firstNumber;
    @override
  final String? last4Number;
    @override
  final String? latitude;
    @override
  final String? longitude;
    @override
  final String? moneda;
    @override
  final String? name;
    @override
  final String? phone;
    @override
  final String? provincia;
    @override
  final String? receiveCode;
    @override
  final String? role;
    @override
  final String? typoAccount;
    @override
  final Map<String,dynamic>? typoMerchant;
    @override
  final String? username;
    @override
  final String? uuid;
    @override
  final bool? isSelect;     
    
    MerchantModel({
        this.address,
        this.banco,
        this.categoriaComercial,
        this.code,
        this.createdAt,
        this.email,
        this.firstNumber,
        this.last4Number,
        this.latitude,
        this.longitude,
        this.moneda,
        this.name,
        this.phone,
        this.provincia,
        this.receiveCode,
        this.role,
        this.typoAccount,
        this.typoMerchant,
        this.username,
        this.uuid,
        this.isSelect
    });

    factory MerchantModel.fromJson(Map<String, dynamic> json) => MerchantModel(
        address: json.containsKey("address") &&
              json["address"] != null
          ? json["address"]
          : "",
        banco:json.containsKey("banco") &&
              json["banco"] != null
          ? json["banco"]
          : "",
        categoriaComercial: json.containsKey("categoriaComercial") &&
              json["categoriaComercial"] != null
          ? json["categoriaComercial"]
          : "",
        code: json.containsKey("code") &&
              json["code"] != null
          ? json["code"]
          : "",
        createdAt: json.containsKey("createdAt") &&
              json["createdAt"] != null
          ? json["createdAt"]
          : "",
        email: json.containsKey("email") &&
              json["email"] != null
          ? json["email"]
          : "",
        firstNumber: json.containsKey("firstNumber") &&
              json["firstNumber"] != null
          ? json["firstNumber"]
          : "",
        last4Number: json.containsKey("last4Number") &&
              json["last4Number"] != null
          ? json["last4Number"]
          : "",
        latitude: json.containsKey("latitude") &&
              json["latitude"] != null
          ? json["latitude"]
          : "",
        longitude: json.containsKey("longitude") &&
              json["longitude"] != null
          ? json["longitude"]
          : "",
        moneda: json.containsKey("moneda") &&
              json["moneda"] != null
          ? json["moneda"]
          : "",
        name: json.containsKey("name") &&
              json["name"] != null
          ? json["name"]
          : "",
        phone: json.containsKey("phone") &&
              json["phone"] != null
          ? json["phone"]
          : "",
        provincia: json.containsKey("provincia") &&
              json["provincia"] != null
          ? json["provincia"]
          : "",
        receiveCode: json.containsKey("receiveCode") &&
              json["receiveCode"] != null
          ? json["receiveCode"]
          : "",
        role: json.containsKey("role") &&
              json["role"] != null
          ? json["role"]
          : "",
        typoAccount: json.containsKey("typoAccount") &&
              json["typoAccount"] != null
          ? json["typoAccount"]
          : "",
        typoMerchant: json.containsKey("typoMerchant") &&
              json["typoMerchant"] != null
          ? json["typoMerchant"]
          : {},
        username: json.containsKey("username") &&
              json["username"] != null
          ? json["username"]
          : "",
        uuid: json.containsKey("uuid") &&
              json["uuid"] != null
          ? json["uuid"]
          : "",
    );

    factory MerchantModel.fromStringJson(String strjson)=>MerchantModel.fromJson(json.decode(strjson));

    Map<String, dynamic> toJson() => {
        "address": address,
        "banco": banco,
        "categoriaComercial": categoriaComercial,
        "code": code,
        "createdAt": createdAt,
        "email": email,
        "firstNumber": firstNumber,
        "last4Number": last4Number,
        "latitude": latitude,
        "longitude": longitude,
        "moneda": moneda,
        "name": name,
        "phone": phone,
        "provincia": provincia,
        "receiveCode": receiveCode,
        "role": role,
        "typoAccount": typoAccount,
        "typoMerchant": typoMerchant,
        "username": username,
        "uuid": uuid,
    };
    
    
}


