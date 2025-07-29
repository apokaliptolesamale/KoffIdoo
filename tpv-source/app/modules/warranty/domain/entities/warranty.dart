class Warranty {
  String? warrantyId;
  String? productIdService;
  String? orderIdService;
  String? firstSerialNumber;
  String? secondSerialNumber;
  String? code;
  String? article;
  double? price;
  String? tradeName;
  String? province;
  String? mark;
  String? ci;
  DateTime? time;
  DateTime createdAt;
  String? paymentType;
  String? clientName;
  String? email;
  String? phoneNumber;
  DateTime? updatedAt;
  String? status;
  String? model;
  String? folio;

  String? seller;
  String? qrWarranty;
  String? address;

  Warranty({
    this.warrantyId,
    this.orderIdService,
    this.productIdService,
    this.firstSerialNumber,
    this.secondSerialNumber,
    this.code,
    this.article,
    this.price,
    this.tradeName,
    this.province,
    this.mark,
    this.ci,
    this.time,
    required this.createdAt,
    this.paymentType,
    this.clientName,
    this.email,
    this.phoneNumber,
    this.updatedAt,
    this.status,
    this.model,
    this.folio,
    this.qrWarranty,
    this.seller,
    this.address,
  });
}
