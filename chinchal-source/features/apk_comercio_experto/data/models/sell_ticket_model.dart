import 'dart:convert';
import 'package:apk_template/features/apk_comercio_experto/data/models/product_model.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/entities/sell_ticket.dart';

class SellTicketModel extends SellTicket {
  SellTicketModel({
    required super.products,
    required super.total,
    required super.cashpaid,
    required super.date,
    required super.shopId,
    required super.clientId,
  });

  factory SellTicketModel.fromMap(Map<String, dynamic> map) {
    // Obtenemos el campo 'products' que puede ser un String (JSON) o una lista
    dynamic productsData = map['products'];
    List<dynamic> productsList;

    if (productsData is String) {
      try {
        productsList = jsonDecode(productsData);
      } catch (e) {
        productsList = [];
      }
    } else if (productsData is List) {
      productsList = productsData;
    } else {
      productsList = [];
    }

    return SellTicketModel(
      products: List<ProductModel>.from(
        productsList.map((x) => ProductModel.fromJson(x))
      ),
      total: map['total']?.toDouble() ?? 0.0,
      cashpaid: map['cashpaid']?.toDouble() ?? 0.0,
      date: DateTime.parse(map['date']),
      shopId: map['shopId'] ?? '',
      clientId: map['clientId'] ?? '',
    );
  }

  factory SellTicketModel.fromJson(String source) =>
      SellTicketModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'products': jsonEncode(products.map((p) => p.toJson()).toList()),
      'total': total,
      'cashpaid': cashpaid,
      'date': date.toIso8601String(),
      'shopId': shopId,
      'clientId': clientId,
    };
  }

  String toJson() => json.encode(toMap());
}
