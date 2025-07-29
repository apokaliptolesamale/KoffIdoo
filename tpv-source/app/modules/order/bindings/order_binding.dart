import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '/app/core/interfaces/repository.dart';
import '/app/modules/order/bindings/order_detail_binding.dart';
import '/app/modules/order/data/repositories/product_repository_impl.dart';
import '/app/modules/order/domain/models/product_model.dart';
import '/app/modules/order/views/pages/order_info_page.dart';
import '/app/modules/order/views/pages/order_page.dart';
import '/app/modules/prestashop/bindings/prestashop_binding.dart';
import '/app/modules/product/bindings/product_binding.dart';
import '/app/modules/qrcode/bindings/qrcode_binding.dart';
import '/app/routes/app_pages.dart';
import '../../../core/interfaces/use_case.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../../order/data/providers/order_provider.dart';
import '../../order/domain/usecases/add_order_usecase.dart';
import '../../order/domain/usecases/delete_order_usecase.dart';
import '../../order/domain/usecases/filter_order_usecase.dart';
import '../../order/domain/usecases/get_order_usecase.dart';
import '../../order/domain/usecases/getby_order_usecase.dart';
import '../../order/domain/usecases/list_order_usecase.dart';
import '../../order/domain/usecases/update_order_usecase.dart';
import '../../security/data/providers/token_provider.dart';
import '../domain/models/order_model.dart';
import '../order_exporting.dart';

class OrderBinding extends Bindings {
  OrderBinding() : super() {
    if (!Get.isRegistered<OrderBinding>()) {
      Get.lazyPut<OrderBinding>(
        () => this,
      );
      loadPages();
      dependencies();
      QrCodeBinding();
      OrderDetailBinding();
      ProductBinding();
      PrestaShopBinding();
    }
  }

  @override
  void dependencies() {
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );
    Get.lazyPut<OrderController>(
      () => OrderController(),
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
    Get.lazyPut<OrderProvider>(
      () => OrderProvider(),
    );
    Get.lazyPut<RemoteOrderDataSourceImpl>(
      () => RemoteOrderDataSourceImpl(),
    );
    Get.lazyPut<LocalOrderDataSourceImpl>(
      () => LocalOrderDataSourceImpl(),
    );
    Get.lazyPut<Repository<OrderModel>>(
      () => OrderRepositoryImpl<OrderModel>(),
    );
    Get.lazyPut<OrderRepository<OrderModel>>(
      () => OrderRepositoryImpl<OrderModel>(),
    );
    Get.lazyPut<Repository<ProductModel>>(
      () => ProductRepositoryImpl<ProductModel>(),
    );
    Get.lazyPut<ProductRepositoryImpl<ProductModel>>(
      () => ProductRepositoryImpl<ProductModel>(),
    );
    Get.lazyPut<UseCase>(
      () => AddOrderUseCase<OrderModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteOrderUseCase<OrderModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetOrderUseCase<OrderModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetOrderByFieldUseCase<OrderModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdateOrderUseCase<OrderModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ListOrderUseCase<OrderModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterOrderUseCase<OrderModel>(Get.find()),
    );
  }

  loadPages() {
    AppPages.addAllRouteIfAbsent([
      OrderHomePageImpl.builder(),
      OrderInfoPageImpl.builder(),
    ]);
  }
}
