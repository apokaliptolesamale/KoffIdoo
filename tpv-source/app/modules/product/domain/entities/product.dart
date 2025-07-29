import '/app/modules/product/domain/entities/any_image.dart';
import '/app/modules/product/domain/entities/category.dart';

class Product {
  String? id;
  String? code;

  String? qrCode;

  String? mark;

  String? model;

  String categoryName;

  String idProduct;

  String idOrder;

  String idOrderService;

  String name;

  String? description;

  String? shortDescription;

  List<AnyImage> images;

  double regularPrice;

  double salePrice;

  double discount;

  bool ifItemAvailable;

  bool ifAddedToCart;

  int stockQuantity;

  int warrantyTime;

  int quantity;

  List<String> size;

  List<Category> categories;

  String idWarranty;

  Product({
    required this.name,
    this.id,
    this.idProduct = "",
    this.code,
    this.qrCode,
    this.mark = "",
    this.model = "",
    this.categoryName = "",
    this.description = "",
    this.idWarranty = "",
    this.idOrder = "-",
    this.idOrderService = "-",
    this.shortDescription = "",
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
    this.warrantyTime = 0,
  });
}
