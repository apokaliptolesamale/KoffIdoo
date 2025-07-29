import '/app/modules/order/domain/entities/product.dart';

class OrderDetail {
  final dynamic idOrderDetail;
  final Product product;

  OrderDetail({
    required this.idOrderDetail,
    required this.product,
  });
}
