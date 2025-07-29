class Account {
  String accountId;
  String uuid;
  String type;
  String username;
  String email;
  String name;
  String lastname;
  String phone;
  String gender;
  String? createAt;
  String updateAt;
  String identification;
  String offlinePayment;
  String paymentPassword;
  String oldPaymentPassword;
  String contactCode;
  String receiveCode;
  String avatar;
  String address;
  String birthday;
  String verifiedPhone;
  String publicPhone;
  String publicEmail;
  String merchantAccount;
  String profileLevel;
  String ocupationDenom;
  String ocupationCode;
  String primaryCurrency;
  String fingerPrint;
  String verified;
  String? totpCode;
  String? disableTotpCode;
  String? verifyTotpCode;
  // List<dynamic>? merchants;

  Account(
      {required this.accountId,
      required this.uuid,
      required this.type,
      required this.username,
      required this.birthday,
      required this.email,
      required this.name,
      required this.lastname,
      required this.phone,
      required this.gender,
      this.createAt,
      required this.updateAt,
      required this.identification,
      required this.offlinePayment,
      required this.paymentPassword,
      required this.oldPaymentPassword,
      required this.contactCode,
      required this.receiveCode,
      required this.avatar,
      required this.verifiedPhone,
      required this.address,
      required this.fingerPrint,
      required this.merchantAccount,
      // this.merchants,
      required this.ocupationCode,
      required this.ocupationDenom,
      required this.primaryCurrency,
      required this.profileLevel,
      required this.publicEmail,
      required this.publicPhone,
      required this.verified,
      this.totpCode,
      this.disableTotpCode,
      this.verifyTotpCode});
}
