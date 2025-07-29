import '/app/modules/prestashop/domain/entities/any_image.dart';
import '/app/modules/prestashop/domain/entities/category.dart';

class Product {
  String code;

  String idProduct;

  String idOrder;

  String name;

  String description;

  String shortDescription;

  List<AnyImage> images;

  double regularPrice;

  double salePrice;

  double discount;

  bool ifItemAvailable;

  bool ifAddedToCart;

  int stockQuantity;

  int quantity;

  List<String> size;

  List<Category> categories;

  String idWarranty;

  Product({
    this.idProduct = "",
    required this.name,
    this.idWarranty = "",
    this.code = "",
    this.description = "Sin descripción",
    this.idOrder = "-",
    this.shortDescription = "Sin descripción",
    this.images = const [],
    this.size = const [],
    this.categories = const [],
    this.regularPrice = 0.00,
    this.salePrice = 0.00,
    this.ifAddedToCart = false,
    this.stockQuantity = 0,
    this.ifItemAvailable = false,
    this.discount = 0.0,
    this.quantity = 0,
  });
}
