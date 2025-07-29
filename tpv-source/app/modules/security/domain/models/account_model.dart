// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:xml/xml.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/account.dart';

AccountList accountListModelFromJson(String str) =>
    AccountList.fromJson(json.decode(str));

AccountModel accountModelFromJson(String str) =>
    AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountList<T extends AccountModel> implements EntityModelList<T> {
  final List<T> accounts;

  AccountList({
    required this.accounts,
  });

  factory AccountList.fromJson(Map<String, dynamic> json) => AccountList(
        accounts:
            List<T>.from(json["accounts"].map((x) => AccountModel.fromJson(x))),
      );

  factory AccountList.fromStringJson(String strJson) =>
      AccountList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return AccountList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!accounts.contains(element)) accounts.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return AccountList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => accounts;

  Map<String, dynamic> toJson() => {
        "accounts": List<dynamic>.from(accounts.map((x) => x.toJson())),
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

class AccountModel extends Account implements EntityModel {
  @override
  String accountId;

  @override
  String uuid;

  @override
  String type;

  @override
  String username;
  @override
  String email;
  @override
  String name;
  @override
  String lastname;
  @override
  String phone;
  @override
  String gender;
  @override
  String? createAt;
  @override
  String updateAt;
  @override
  String identification;
  @override
  String offlinePayment;
  @override
  String paymentPassword;
  @override
  String oldPaymentPassword;
  @override
  String contactCode;
  @override
  String receiveCode;
  @override
  String avatar;
  @override
  String address;
  @override
  String birthday;
  @override
  String verifiedPhone;
  @override
  String publicPhone;
  @override
  String publicEmail;
  @override
  String merchantAccount;
  @override
  String profileLevel;
  @override
  String ocupationDenom;
  @override
  String ocupationCode;
  @override
  String primaryCurrency;
  @override
  String fingerPrint;
  @override
  String verified;
  @override
  String? totpCode;
  @override
  String? disableTotpCode;
  @override
  String? verifyTotpCode;
  // @override
  // List<dynamic>? merchants;

  @override
  Map<String, ColumnMetaModel>? metaModel;
  AccountModel(
      {this.accountId = "",
      this.uuid = "",
      this.type = "",
      this.username = "",
      this.birthday = "",
      this.email = "",
      this.name = "",
      this.lastname = "",
      this.phone = "",
      this.gender = "",
      this.createAt = "",
      this.updateAt = "",
      this.identification = "",
      this.offlinePayment = "",
      this.paymentPassword = "",
      this.oldPaymentPassword = "",
      this.contactCode = "",
      this.receiveCode = "",
      this.avatar = "",
      this.verifiedPhone = "",
      this.address = "",
      this.fingerPrint = "",
      this.merchantAccount = "",
      // this.merchants,
      this.ocupationCode = "",
      this.ocupationDenom = "",
      this.primaryCurrency = "",
      this.profileLevel = "",
      this.publicEmail = "",
      this.publicPhone = "",
      this.verified = "",
      this.totpCode,
      this.disableTotpCode,
      this.verifyTotpCode})
      : super(
            accountId: accountId,
            avatar: avatar,
            contactCode: contactCode,
            createAt: createAt,
            email: email,
            gender: gender,
            identification: identification,
            lastname: lastname,
            name: name,
            birthday: birthday,
            offlinePayment: offlinePayment,
            paymentPassword: paymentPassword,
            phone: phone,
            receiveCode: receiveCode,
            type: type,
            updateAt: updateAt,
            username: username,
            oldPaymentPassword: oldPaymentPassword,
            uuid: uuid,
            verifiedPhone: verifiedPhone,
            address: address,
            fingerPrint: fingerPrint,
            merchantAccount: merchantAccount,
            ocupationCode: ocupationCode,
            ocupationDenom: ocupationDenom,
            primaryCurrency: primaryCurrency,
            profileLevel: profileLevel,
            publicEmail: publicEmail,
            publicPhone: publicPhone,
            verified: verified,
            totpCode: totpCode,
            disableTotpCode: disableTotpCode,
            verifyTotpCode: verifyTotpCode
            // merchants: merchants
            );
  //factory AccountModel.fromLocalSecureStorage(String key)=>AccountModel.fromJson(LocalSecureStorage.storage.read("account"));
  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        createAt: getValueFrom(
          "create_at",
          json,
          null,
        ),
        updateAt: json.containsKey("update_at") && json["update_at"] != null
            ? json["update_at"]
            : "",
        accountId: json.containsKey("account_id") && json["account_id"] != null
            ? json["account_id"].toString()
            : "",
        uuid: json.containsKey("uuid") && json["uuid"] != null
            ? json["uuid"]
            : "",
        type: json.containsKey("type") && json["type"] != null
            ? json["type"]
            : "",
        username: json.containsKey("username") && json["username"] != null
            ? json["username"]
            : "",
        email: json.containsKey("email") && json["email"] != null
            ? json["email"]
            : "",
        name: json.containsKey("name") && json["name"] != null
            ? json["name"]
            : "",
        lastname: json.containsKey("lastname") && json["lastname"] != null
            ? json["lastname"]
            : "",
        birthday: json.containsKey("birthday") && json["birthday"] != null
            ? json["birthday"]
            : "",
        phone: json.containsKey("phone") && json["phone"] != null
            ? json["phone"].toString()
            : "",
        gender: json.containsKey("gender") && json["gender"] != null
            ? json["gender"]
            : "",
        identification:
            json.containsKey("identification") && json["identification"] != null
                ? json["identification"].toString()
                : "",
        offlinePayment: json.containsKey("offline_payment") &&
                json["offline_payment"] != null
            ? json["offline_payment"].toString()
            : "",
        paymentPassword: json.containsKey("payment_password") &&
                json["payment_password"] != null
            ? json["payment_password"].toString()
            : "",
        oldPaymentPassword: json.containsKey("old_payment_password") &&
                json["old_payment_password"] != null
            ? json["old_payment_password"].toString()
            : "",
        contactCode:
            json.containsKey("contact_code") && json["contact_code"] != null
                ? json["contact_code"]
                : "",
        receiveCode:
            json.containsKey("receive_code") && json["receive_code"] != null
                ? json["receive_code"]
                : "",
        avatar: json.containsKey("avatar") && json["avatar"] != null
            ? json["avatar"]
            : "",
        address: json.containsKey("address") && json["address"] != null
            ? json["address"]
            : "",
        verifiedPhone:
            json.containsKey("verified_phone") && json["verified_phone"] != null
                ? json["verified_phone"].toString()
                : "",
        // merchants: EntityModel.getValueFromJson<List<dynamic>>(
        //   "merchants",
        //   json,
        //   [{}],
        //   reader: (key, data, defaultValue) {
        //     if (data.containsKey(key)) {
        //       return List<dynamic>.from(json[key].map((x) => x));
        //     }
        //     return defaultValue;
        //   },
        // ),
        publicPhone:
            json.containsKey("public_phone") && json["public_phone"] != null
                ? json["public_phone"].toString()
                : "",
        publicEmail:
            json.containsKey("public_email") && json["public_email"] != null
                ? json["public_email"].toString()
                : "",
        merchantAccount: json.containsKey("merchant_account") &&
                json["merchant_account"] != null
            ? json["merchant_account"].toString()
            : "",
        profileLevel:
            json.containsKey("profile_level") && json["profile_level"] != null
                ? json["profile_level"].toString()
                : "",
        ocupationDenom: json.containsKey("ocupation_denom") &&
                json["ocupation_denom"] != null
            ? json["ocupation_denom"].toString()
            : "",
        ocupationCode:
            json.containsKey("ocupation_code") && json["ocupation_code"] != null
                ? json["ocupation_code"].toString()
                : "",
        primaryCurrency: json.containsKey("primary_currency") &&
                json["primary_currency"] != null
            ? json["primary_currency"].toString()
            : "",
        fingerPrint:
            json.containsKey("fingerprint") && json["fingerprint"] != null
                ? json["fingerprint"].toString()
                : "",
        verified: json.containsKey("verified") && json["verified"] != null
            ? json["verified"].toString()
            : "",
        /*address: EntityModel.getValueFromJson<List<String>>(
          "address",
          json,
          [],
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              if(json[key] is Map){
                final tmp = (json[key] as Map<String,dynamic>).map((key,value) => MapEntry<String,String>(key, value.toString()));
                return List<String>.from(tmp.values);
                }
             else if(json[key] is String){return [json[key]];}
              
            }
            return defaultValue;
          } */
        totpCode: json.containsKey("response") && json["response"] != null
            ? json["response"].toString()
            : null,
        disableTotpCode: json.containsKey("reseted") && json["reseted"] != null
            ? json["reseted"].toString()
            : null,
        verifyTotpCode: json.containsKey("response") && json["response"] != null
            ? json["response"].toString()
            : null,
        // totpCode: EntityModel.getValueFromJson<Map<String, dynamic>>(
        //     "response", json, {}, reader: (key, data, defaultValue) {
        //   if (data.containsKey(key)) {
        //     if (json[key] is Map) {
        //       final tmp = (json[key] as Map<String, dynamic>).map(
        //           (key, value) =>
        //               MapEntry<String, String>(key, value.toString()));
        //       return Map<String, dynamic>.from(tmp);
        //     } else if (json[key] is String) {
        //       return json[key];
        //     }
        //   }
        //   return defaultValue;
        // }),
      );
  factory AccountModel.fromXml(
          XmlElement element, AccountModel Function(XmlElement el) process) =>
      process(element);
  @override
  Map<String, ColumnMetaModel>? get getMetaModel => getColumnMetaModel();

  List<Object?> get props => [];

  @override
  set setMetaModel(Map<String, ColumnMetaModel> newMetaModel) {
    metaModel = newMetaModel;
  }

  bool? get stringify => true;

  //method generated by wizard
  @override
  T cloneWith<T extends EntityModel>(T other) {
    return AccountModel.fromJson(other.toJson()) as T;
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return AccountList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return AccountList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return AccountList.fromJson({});
  }

  @override
  T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
    return AccountModel.fromJson(params) as T;
  }

  @override
  Map<String, ColumnMetaModel> getColumnMetaModel() {
    //Map<String, String> colNames = getColumnNames();
    metaModel = metaModel ??
        {
          //TODO Declare here all ColumnMetaModel. you can use class implementation of class "DefaultColumnMetaModel".
        };
    int index = 0;
    metaModel!.forEach((key, value) {
      value.setColumnIndex(index++);
    });
    return metaModel!;
  }

  @override
  Map<String, String> getColumnNames() {
    return {"id_account": "ID"};
  }

  @override
  List<String> getColumnNamesList() {
    return getColumnNames().values.toList();
  }

  StreamController<EntityModel> getController({
    void Function()? onListen,
    void Function()? onPause,
    void Function()? onResume,
    FutureOr<void> Function()? onCancel,
  }) {
    return EntityModel.getController(
        entity: this,
        onListen: onListen,
        onPause: onPause,
        onResume: onResume,
        onCancel: onCancel);
  }

  @override
  Map<K1, V1> getMeta<K1, V1>(String searchKey, dynamic searchValue) {
    final Map<K1, V1> result = {};
    getColumnMetaModel().map<K1, V1>((key, value) {
      MapEntry<K1, V1> el = MapEntry(value.getDataIndex() as K1, value as V1);
      if (value[searchKey] == searchValue) {
        result.putIfAbsent(value.getDataIndex() as K1, () {
          return value as V1;
        });
      }
      return el;
    });
    return result;
  }

  @override
  Map<String, String> getVisibleColumnNames() {
    Map<String, String> names = {};
    getMeta<String, ColumnMetaModel>("visible", true)
        .map<String, String>((key, value) {
      names.putIfAbsent(key, () => value.getColumnName());
      return MapEntry(key, value.getColumnName());
    });
    return names;
    // throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> tmp = {
      "account_id": accountId,
      "uuid": uuid,
      "type": type,
      "username": username,
      "email": email,
      "name": name,
      "lastname": lastname,
      "phone": phone,
      "gender": gender,
      "create_at": createAt,
      "update_at": updateAt,
      "identification": identification,
      "offline_payment": offlinePayment,
      "payment_password": paymentPassword,
      "contact_code": contactCode,
      "receive_code": receiveCode,
      "avatar": avatar,
      "birthday": birthday,
      "old_payment_password": oldPaymentPassword,
      "address": address,
      "verified_phone": verifiedPhone,
      "public_phone": publicPhone,
      "public_email": publicEmail,
      "merchant_account": merchantAccount,
      "profile_level": profileLevel,
      "ocupation_denom": ocupationDenom,
      "ocupation_code": ocupationCode,
      "primary_currency": primaryCurrency,
      // "merchants": merchants,
      "fingerprint": fingerPrint,
      "verified": verified,
    };
    tmp.removeWhere((key, value) => value == null);
    return tmp;
  }

  @override
  Map<String, ColumnMetaModel> updateColumnMetaModel(
      String keySearch, dynamic valueSearch, dynamic newValue) {
    Map<String, ColumnMetaModel> tmp = getColumnMetaModel();
    getMeta<String, ColumnMetaModel>(keySearch, valueSearch)
        .map<String, ColumnMetaModel>((key, value) {
      tmp.putIfAbsent(key, () => value);
      return MapEntry(key, value);
    });
    return metaModel = tmp;
  }

  @override
  static T getValueFrom<T>(
      String key, Map<dynamic, dynamic> json, T defaultValue,
      {JsonReader<T>? reader}) {
    return EntityModel.getValueFromJson<T>(key, json, defaultValue,
        reader: reader);
  }
}
