import 'package:apk_template/features/apk_comercio_experto/data/models/product_model.dart';

class SellTicket {
  final List<ProductModel> products;
  final double total;
  final double cashpaid;
  final DateTime date;
  final String shopId;
  final String clientId;

  SellTicket({required this.products, required this.total, required this.cashpaid, required this.date, required this.shopId, required this.clientId});
}
