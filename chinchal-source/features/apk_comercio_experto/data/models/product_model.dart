// // To parse this JSON data, do
// //
// //     final userModel = userModelFromJson(jsonString);
// // ignore_for_file: overridden_fields, empty_catches
import 'dart:convert';
import '../../domain/entities/entities.dart';
import 'category_model.dart';


class ProductModel extends Product {
  ProductModel({
    required super.name,
    super.id,
    super.idProduct,
    super.code,
    super.qrCode,
    String super.mark,
    String super.model,
    super.categoryName,
    super.description,
    super.idWarranty,
    super.idOrder,
    super.idOrderService,
    super.shortDescription,
    super.images,
    super.size,
    super.categories,
    super.regularPrice,
    super.salePrice,
    super.ifAddedToCart,
    super.stockQuantity,
    super.ifItemAvailable,
    super.discount,
    super.quantity,
    super.warrantyTime,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        name: json['name'] ?? "",
        id: json['id'],
        idProduct: json['idProduct'] ?? "",
        code: json['code'],
        qrCode: json['qrCode'],
        mark: json['mark'] ?? "",
        model: json['model'] ?? "",
        categoryName: json['categoryName'] ?? "",
        description: json['description'],
        idWarranty: json['idWarranty'] ?? "",
        idOrder: json['idOrder'] ?? "-",
        idOrderService: json['idOrderService'] ?? "-",
        shortDescription: json['shortDescription'],
        images: List<String>.from(json['images'] ?? []),
        size: List<String>.from(json['size'] ?? []),
        categories: List<String>.from(json["categories"].map((x) => x)),
        regularPrice: (json['regularPrice'] ?? 0.00).toDouble(),
        salePrice: (json['salePrice'] ?? 0.00).toDouble(),
        ifAddedToCart: json['ifAddedToCart'] ?? false,
        stockQuantity: json['stockQuantity'] ?? 0,
        ifItemAvailable: json['ifItemAvailable'] ?? false,
        discount: (json['discount'] ?? 0.0).toDouble(),
        quantity: json['quantity'] ?? 0,
        warrantyTime: json['warrantyTime'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'idProduct': idProduct,
        'code': code,
        'qrCode': qrCode,
        'mark': mark,
        'model': model,
        'categoryName': categoryName,
        'description': description,
        'idWarranty': idWarranty,
        'idOrder': idOrder,
        'idOrderService': idOrderService,
        'shortDescription': shortDescription,
        'images': images.map((img) => jsonEncode(img)).toList(),
        'size': size,
        'categories': categories.map((cat) => jsonEncode(cat)).toList(),
        'regularPrice': regularPrice,
        'salePrice': salePrice,
        'ifAddedToCart': ifAddedToCart,
        'stockQuantity': stockQuantity,
        'ifItemAvailable': ifItemAvailable,
        'discount': discount,
        'quantity': quantity,
        'warrantyTime': warrantyTime,
      };
}

class ListProducts {
  ListProducts({
    required this.results,
  });
  List<ProductModel> results;
  
  factory ListProducts.fromJson(String str){
    if (str !="Error" &&  str!="{}") {
      return ListProducts.fromMap(json.decode(str));
    }
      else {
        const str2="{"
            "results: []"
            "}";
        return ListProducts.fromMap(json.decode(str2));
      }

  }
    Map<String, dynamic> toJson() {
    return {
      'results': results.map((product) => product.toJson()).toList(),
    };
  }


  factory ListProducts.fromMap(List< dynamic> json){
    return  ListProducts(
        results: List<ProductModel>.from(json.map((x) => ProductModel.fromJson(x))),
      );
  }

}

