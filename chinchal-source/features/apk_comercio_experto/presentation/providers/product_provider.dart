import 'package:apk_template/features/apk_comercio_experto/data/datasources/product_remote_datasource_impl.dart';
import 'package:apk_template/features/apk_comercio_experto/data/models/product_model.dart';
import 'package:apk_template/features/apk_comercio_experto/data/repositories/product_repository_impl.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/repository/product_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final productDatasourceProvider = Provider<ProductRemoteDataSourceImpl>(
    (ref) => ProductRemoteDataSourceImpl());

final productRemoteRepositoryProvider = Provider<ProductRepositoryImpl>((ref) =>
    ProductRepositoryImpl(
        productDataSource: ref.watch(productDatasourceProvider)));

final productProvider = ChangeNotifierProvider(
  (ref) {
    final productRemoteRepository = ref.watch(productRemoteRepositoryProvider);

    return ProductNotifier(producRemoteRepository: productRemoteRepository);
  },
);

typedef ProductsCallback = Future<List<ProductModel>> Function();

class ProductNotifier extends ChangeNotifier {
  final ProductRepository producRemoteRepository;
  ProductNotifier({required this.producRemoteRepository}) : super() {
    _initialize();
  }
  List<ProductModel> products = [];

  Future<void> _initialize() async {
    try {
      final newProducts = await producRemoteRepository.getListOfProducts();
      products = [...newProducts];
      notifyListeners();
    } catch (e) {
      print('Error al inicializar la lista de productos: $e');
    }
  }
}
