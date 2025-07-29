import '/app/modules/product/domain/entities/any_image.dart';

class Product {
  final String? idProduct;
  final String? idOrder;
  final String? idOrderService;
  final String? name;
  final String? model;
  final String? code;
  final String? price;
  final String? mark;
  final int? productQuantity;
  List<AnyImage> images;

  Product({
    this.idProduct,
    this.idOrder,
    this.idOrderService,
    this.name,
    this.model,
    this.code,
    this.price,
    this.mark,
    this.productQuantity = 0,
    this.images = const [],
  });
}
