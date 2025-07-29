import 'dart:convert';

import '../../domain/entities/account.dart';

class AccountModel extends Account {
  @override
  String? username;

  @override
  String? email;
  @override
  String? name;
  @override
  String? lastname;
  @override
  String? phone;
  @override
  String? gender;
  @override
  String? createAt;
  @override
  String? updateAt;
  @override
  String? identification;
  @override
  String? offlinePayment;
  @override
  String? paymentPassword;
  @override
  String? oldPaymentPassword;
  @override
  String? contactCode;
  @override
  String? receiveCode;
  @override
  String? avatar;
  @override
  String? address;
  @override
  String? birthday;
  @override
  String? verifiedPhone;
  @override
  String? publicPhone;
  @override
  String? publicEmail;
  @override
  String? merchantAccount;
  @override
  String? profileLevel;
  @override
  String? ocupationDenom;
  @override
  String? ocupationCode;
  @override
  String? primaryCurrency;
  @override
  String? fingerPrint;
  @override
  String? verified;
  @override
  String? totpCode;
  @override
  String? disableTotpCode;
  @override
  String? verifyTotpCode;
  @override
  String? accountId;
  @override
  String? uuid;

  @override
  String? type;
  @override
  List<Merchant>? merchants;

  AccountModel(
      {this.accountId,
      this.uuid,
      this.type,
      this.username,
      this.birthday,
      this.email,
      this.name,
      this.lastname,
      this.phone,
      this.gender,
      this.createAt,
      this.updateAt,
      this.identification,
      this.offlinePayment,
      this.paymentPassword,
      this.oldPaymentPassword,
      this.contactCode,
      this.receiveCode,
      this.avatar,
      this.verifiedPhone,
      this.address,
      this.fingerPrint,
      this.merchantAccount,
      this.merchants,
      this.ocupationCode,
      this.ocupationDenom,
      this.primaryCurrency,
      this.profileLevel,
      this.publicEmail,
      this.publicPhone,
      this.verified,
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
            verifyTotpCode: verifyTotpCode,
            merchants: merchants);

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        createAt: json.containsKey("create_at") && json["create_at"] != null
            ? json["create_at"]
            : null,
        updateAt: json.containsKey("update_at") && json["update_at"] != null
            ? json["update_at"]
            : null,
        accountId: json.containsKey("account_id") && json["account_id"] != null
            ? json["account_id"].toString()
            : null,
        uuid: json.containsKey("uuid") && json["uuid"] != null
            ? json["uuid"]
            : null,
        type: json.containsKey("type") && json["type"] != null
            ? json["type"]
            : null,
        username: json.containsKey("username") && json["username"] != null
            ? json["username"]
            : null,
        email: json.containsKey("email") && json["email"] != null
            ? json["email"]
            : null,
        name: json.containsKey("name") && json["name"] != null
            ? json["name"]
            : null,
        lastname: json.containsKey("lastname") && json["lastname"] != null
            ? json["lastname"]
            : null,
        birthday: json.containsKey("birthday") && json["birthday"] != null
            ? json["birthday"]
            : null,
        phone: json.containsKey("phone") && json["phone"] != null
            ? json["phone"].toString()
            : null,
        gender: json.containsKey("gender") && json["gender"] != null
            ? json["gender"]
            : null,
        identification:
            json.containsKey("identification") && json["identification"] != null
                ? json["identification"].toString()
                : null,
        offlinePayment: json.containsKey("offline_payment") &&
                json["offline_payment"] != null
            ? json["offline_payment"].toString()
            : null,
        paymentPassword: json.containsKey("payment_password") &&
                json["payment_password"] != null
            ? json["payment_password"].toString()
            : null,
        oldPaymentPassword: json.containsKey("old_payment_password") &&
                json["old_payment_password"] != null
            ? json["old_payment_password"].toString()
            : null,
        contactCode:
            json.containsKey("contact_code") && json["contact_code"] != null
                ? json["contact_code"]
                : null,
        receiveCode:
            json.containsKey("receive_code") && json["receive_code"] != null
                ? json["receive_code"]
                : null,
        avatar: json.containsKey("avatar") && json["avatar"] != null
            ? json["avatar"]
            : null,
        address: json.containsKey("address") && json["address"] != null
            ? json["address"]
            : null,
        verifiedPhone:
            json.containsKey("verified_phone") && json["verified_phone"] != null
                ? json["verified_phone"].toString()
                : null,
        publicPhone:
            json.containsKey("public_phone") && json["public_phone"] != null
                ? json["public_phone"].toString()
                : null,
        publicEmail:
            json.containsKey("public_email") && json["public_email"] != null
                ? json["public_email"].toString()
                : null,
        merchantAccount: json.containsKey("merchant_account") &&
                json["merchant_account"] != null
            ? json["merchant_account"].toString()
            : null,
        merchants: json.containsKey("merchants") && json["merchants"] != null
            ? List<Merchant>.from(
                json["merchants"].map((x) => Merchant.fromJson(x)))
            : null,
        profileLevel:
            json.containsKey("profile_level") && json["profile_level"] != null
                ? json["profile_level"].toString()
                : null,
        ocupationDenom: json.containsKey("ocupation_denom") &&
                json["ocupation_denom"] != null
            ? json["ocupation_denom"].toString()
            : null,
        ocupationCode:
            json.containsKey("ocupation_code") && json["ocupation_code"] != null
                ? json["ocupation_code"].toString()
                : null,
        primaryCurrency: json.containsKey("primary_currency") &&
                json["primary_currency"] != null
            ? json["primary_currency"].toString()
            : null,
        fingerPrint:
            json.containsKey("fingerprint") && json["fingerprint"] != null
                ? json["fingerprint"].toString()
                : null,
        verified: json.containsKey("verified") && json["verified"] != null
            ? json["verified"].toString()
            : null,
        totpCode: json.containsKey("response") && json["response"] != null
            ? json["response"].toString()
            : null,
        disableTotpCode: json.containsKey("reseted") && json["reseted"] != null
            ? json["reseted"].toString()
            : null,
        verifyTotpCode: json.containsKey("response") && json["response"] != null
            ? json["response"].toString()
            : null,
      );

  factory AccountModel.fromStringJson(String strjson) =>
      AccountModel.fromJson(json.decode(strjson));

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
      "merchants": merchants,
      "fingerprint": fingerPrint,
      "verified": verified,
    };
    tmp.removeWhere((key, value) => value == null);
    return tmp;
  }
}

class Merchant {
  String? merchantUuid;

  Merchant({
    this.merchantUuid,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
        merchantUuid:
            json.containsKey("merchant_uuid") && json["merchant_uuid"] != null
                ? json["merchant_uuid"].toString()
                : null,
        //json["merchant_uuid"],
      );

  Map<String, dynamic> toJson() => {
        "merchant_uuid": merchantUuid,
      };
}
