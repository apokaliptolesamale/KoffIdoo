// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';

import '/app/modules/product/controllers/product_controller.dart';
import '/app/modules/product/domain/models/product_model.dart';
import '/app/modules/product/views/product_detail_view.dart';
import '/app/widgets/field/custom_get_view.dart';

class ProductInfoPage extends CustomView<ProductController> {
  final ProductModel product;

  ProductInfoPage({
    Key? key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return ProductDetailView(
      products: [product],
      defaultIndex: 0,
    );
  }
}
