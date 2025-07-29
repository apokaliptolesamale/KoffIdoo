

import '../../data/models/account_model.dart';

class Account {
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


  Account(
    {
        this.accountId ,
      this.uuid ,
      this.type ,
      this.username ,
      this.birthday ,
      this.email ,
      this.name ,
      this.lastname ,
      this.phone ,
      this.gender ,
      this.createAt ,
      this.updateAt ,
      this.identification ,
      this.offlinePayment ,
      this.paymentPassword ,
      this.oldPaymentPassword ,
      this.contactCode ,
      this.receiveCode ,
      this.avatar ,
      this.verifiedPhone ,
      this.address ,
      this.fingerPrint ,
      this.merchantAccount ,
      this.merchants,
      this.ocupationCode ,
      this.ocupationDenom ,
      this.primaryCurrency ,
      this.profileLevel ,
      this.publicEmail ,
      this.publicPhone ,
      this.verified ,
      this.totpCode,
      this.disableTotpCode,
      this.verifyTotpCode}
  );
}