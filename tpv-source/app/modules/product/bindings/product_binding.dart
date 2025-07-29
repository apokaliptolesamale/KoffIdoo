import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '/app/modules/product/services/product_registry.dart';
import '/app/modules/product/views/pages/product_page.dart';
import '/app/modules/product/views/pages/product_scan_page.dart';
import '/app/routes/app_pages.dart';
import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../../product/domain/models/product_model.dart';
import '../../product/domain/usecases/add_product_usecase.dart';
import '../../product/domain/usecases/delete_product_usecase.dart';
import '../../product/domain/usecases/filter_product_usecase.dart';
import '../../product/domain/usecases/get_product_usecase.dart';
import '../../product/domain/usecases/getby_product_usecase.dart';
import '../../product/domain/usecases/list_product_usecase.dart';
import '../../product/domain/usecases/update_product_usecase.dart';
import '../../product/product_exporting.dart';
import '../../security/data/providers/token_provider.dart';
import '../data/providers/product_provider.dart';

class ProductBinding extends Bindings {
  ProductBinding() : super() {
    if (!Get.isRegistered<ProductBinding>()) {
      Get.lazyPut<ProductBinding>(
        () => this,
      );
      loadPages();
      dependencies();
    }
  }

  @override
  void dependencies() {
    Get.lazyPut(() => <dynamic, dynamic>{});
    Get.lazyPut<ProductRegistry>(() => ProductRegistry.instance);
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

  loadPages() {
    AppPages.addAllRouteIfAbsent([
      ProductHomeImpl.builder(),
      ProductScannerImpl.builder(),
    ]);
  }
}
