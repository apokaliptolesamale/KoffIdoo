
import 'dart:convert';

import '../entities/qr_code_entity.dart';


QrCodeModel qrCodeModelFromJson(String str) => QrCodeModel.fromJson(json.decode(str));

String qrCodeModelToJson(QrCodeModel data) => json.encode(data.toJson());

class QrCodeModel extends QrCodeEntity {
    @override
  final String? qrCode;
    @override
  final String? createAt;
    @override
  final String? updateAt;
    @override
  final String? image;

    QrCodeModel({
        this.qrCode,
        this.createAt,
        this.updateAt,
        this.image,
    });

    factory QrCodeModel.fromJson(Map<String, dynamic> json) => QrCodeModel(
        qrCode: json.containsKey("qr_code") &&
              json["qr_code"] != null
          ? json["qr_code"]
          : "",
        createAt: json.containsKey("create_at") &&
              json["create_at"] != null
          ? json["create_at"]
          : "",
        updateAt: json.containsKey("update_at") &&
              json["update_at"] != null
          ? json["update_at"]
          : "",
        image: json.containsKey("image") &&
              json["image"] != null
          ? json["image"]
          : "",
    );

    Map<String, dynamic> toJson() => {
        "qr_code": qrCode,
        "create_at": createAt,
        "update_at": updateAt,
        "image": image,
    };
    
     
}

class AddQrCodeModel extends AddQrCodeEntity{
    
      @override
  String? amount;
  
     @override
  String? currency;
  
     @override
  String? description;
   
     @override
  String? returnUrl;
 
  @override
  String? notifyUrl;
  
  @override
  String? terminalId;
   
  @override
  int? permanent;
  @override
  String? merchantUuid;

    AddQrCodeModel({
     this.amount,
     this.currency,
     this.description,
     this.returnUrl,
     this.notifyUrl,
     this.terminalId,
     this.permanent,
     this.merchantUuid,
  }) : super(
            amount: amount,
            currency: currency,
            description: description,
            returnUrl: returnUrl,
            notifyUrl: notifyUrl,
            terminalId: terminalId,
            permanent: permanent,
            merchantUuid:merchantUuid
            );

    factory AddQrCodeModel.fromJson(Map<String, dynamic> json) => AddQrCodeModel(
       amount: json.containsKey("amount") &&
              json["amount"] != null
          ? json["amount"]
          : "", 
       currency: json.containsKey("currency") &&
              json["currency"] != null
          ? json["currency"]
          : "", 
       description: json.containsKey("description") &&
              json["description"] != null
          ? json["description"]
          : "", 
       returnUrl: json.containsKey("return_url") &&
              json["return_url"] != null
          ? json["return_url"]
          : "", 
       notifyUrl: json.containsKey("notify_url") &&
              json["notify_url"] != null
          ? json["notify_url"]
          : "", 
       terminalId: json.containsKey("terminal_id") &&
              json["terminal_id"] != null
          ? json["terminal_id"]
          : "", 
       permanent: json.containsKey("permanent") &&
              json["permanent"] != null
          ? json["permanent"]
          : 0, 
       merchantUuid: json.containsKey("merchant_uuid") &&
              json["merchant_uuid"] != null
          ? json["merchant_uuid"]
          : "", 
    );

    Map<String, dynamic> toJson() => {
        "amount": amount ?? "",
        "currency": currency?? "",
        "description": description?? "",
        "return_url": returnUrl?? "",
        "notify_url": notifyUrl?? "",
        "terminal_id": terminalId?? "",
        "permanent": permanent?? 1,
        "merchant_uuid": merchantUuid?? ""
        };
}
