class ChinchalQrCode {
  final String? qrCode;
  final String? createAt;
  final String? updateAt;
  final String? image;

  ChinchalQrCode({
    this.qrCode,
    this.createAt,
    this.updateAt,
    this.image,
  });
}

class AddChinchalQrCode {
   String? amount;
   String? currency;
   String? description;
   String? returnUrl;
   String? notifyUrl;
   String? terminalId;
   int? permanent;
  String? merchantUuid;
  
  AddChinchalQrCode({
    this.amount,
    this.currency,
    this.description,
    this.returnUrl,
    this.notifyUrl,
    this.terminalId,
    this.permanent,
    this.merchantUuid,
  });
}
