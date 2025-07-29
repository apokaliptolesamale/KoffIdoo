import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../security/data/providers/token_provider.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../domain/models/product_model.dart';
import '../domain/usecases/add_product_usecase.dart';
import '../domain/usecases/delete_product_usecase.dart';
import '../domain/usecases/get_product_usecase.dart';
import '../domain/usecases/getby_product_usecase.dart';
import '../domain/usecases/update_product_usecase.dart';
import '../domain/usecases/list_product_usecase.dart';
import '../domain/usecases/filter_product_usecase.dart';
import '../product_exporting.dart';
import '../data/providers/product_provider.dart';

class ProductBinding extends Bindings {
  ProductBinding() : super() {
    log("Registrando instancia de:${toString()} y sus dependencias.");
    dependencies();
  }

  @override
  void dependencies() {
    Get.lazyPut<ProductBinding>(() => this);
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );
    Get.lazyPut<ProductController>(
      () => ProductController(),
    );
    Get.lazyPut<home_app.HomeController>(
      () => home_app.HomeController(),
    );
    Get.lazyPut<http.Client>(
      () => http.Client(),
    );
    Get.lazyPut<rest_client.Client>(
      () => rest_client.Client(),
    );
    Get.lazyPut<ProductProvider>(
      () => ProductProvider(),
    );
    Get.lazyPut<RemoteProductDataSourceImpl>(
      () => RemoteProductDataSourceImpl(),
    );
    Get.lazyPut<LocalProductDataSourceImpl>(
      () => LocalProductDataSourceImpl(),
    );
    Get.lazyPut<Repository<ProductModel>>(
      () => ProductRepositoryImpl<ProductModel>(),
    );
    Get.lazyPut<ProductRepository<ProductModel>>(
      () => ProductRepositoryImpl<ProductModel>(),
    );
    Get.lazyPut<UseCase>(
      () => AddProductUseCase<ProductModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteProductUseCase<ProductModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetProductUseCase<ProductModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetProductByFieldUseCase<ProductModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdateProductUseCase<ProductModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ListProductUseCase<ProductModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterProductUseCase<ProductModel>(Get.find()),
    );
  }
}
