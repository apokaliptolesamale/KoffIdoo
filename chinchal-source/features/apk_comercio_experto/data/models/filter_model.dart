import 'dart:convert';

FilterModel FilterModelFromJson(String str) =>
    FilterModel.fromJson(json.decode(str));

String FilterModelToJson(FilterModel data) => json.encode(data.toJson());

class FilterModel {
  FilterModel({
    this.page,
    this.count,
    this.productName,
    this.serialNumbre1,
    this.code,
    this.mark,
    this.model,
    this.idProduct,
    this.idOrder,
    this.idWarranty,
    this.idOrderService,
  });

  int? page;
  int? count;
  String? productName;
  String? serialNumbre1;
  String? code;
  String? mark;
  String? model;
  String? idProduct;
  String? idOrder;
  String? idWarranty;
  String? idOrderService;

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
        page: json.containsKey("page") && json["page"] != null
            ? json["page"]
            : null,
        count: json.containsKey("count") && json["count"] != null
            ? json["count"]
            : null,
        productName:
            json.containsKey("productName") && json["productName"] != null
                ? json["productName"]
                : null,
        serialNumbre1:
            json.containsKey("SerialNumbre1") && json["SerialNumbre1"] != null
                ? json["SerialNumbre1"]
                : null,
        code: json.containsKey("code") && json["code"] != null
            ? json["code"]
            : null,
        mark: json.containsKey("mark") && json["mark"] != null
            ? json["mark"]
            : null,
        model: json.containsKey("model") && json["model"] != null
            ? json["model"]
            : null,
        idProduct: json.containsKey("idProduct") && json["idProduct"] != null
            ? json["idProduct"]
            : null,
        idOrder: json.containsKey("idOrder") && json["idOrder"] != null
            ? json["idOrder"]
            : null,
        idWarranty: json.containsKey("idWarranty") && json["idWarranty"] != null
            ? json["idWarranty"]
            : null,
        idOrderService:
            json.containsKey("idOrderService") && json["idOrderService"] != null
                ? json["idOrderService"]
                : null,
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "count": count,
        "productName": productName,
        "SerialNumbre1": serialNumbre1,
        "code": code,
        "mark": mark,
        "model": model,
        "idProduct": idProduct,
        "idOrder": idOrder,
        "idWarranty": idWarranty,
        "idOrderService": idOrderService,
      };
}
