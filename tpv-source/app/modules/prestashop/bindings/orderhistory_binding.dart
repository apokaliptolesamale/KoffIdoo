import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '/app/core/services/logger_service.dart';
import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../../security/data/providers/token_provider.dart';
import '../data/providers/orderhistory_provider.dart';
import '../domain/models/orderhistory_model.dart';
import '../domain/usecases/add_orderhistory_usecase.dart';
import '../domain/usecases/delete_orderhistory_usecase.dart';
import '../domain/usecases/filter_orderhistory_usecase.dart';
import '../domain/usecases/get_orderhistory_usecase.dart';
import '../domain/usecases/getby_orderhistory_usecase.dart';
import '../domain/usecases/list_orderhistory_usecase.dart';
import '../domain/usecases/update_orderhistory_usecase.dart';
import '../orderhistory_exporting.dart';

class OrderHistoryBinding extends Bindings {
  OrderHistoryBinding() : super() {
    log("Registrando instancia de:${toString()} y sus dependencias.");
    dependencies();
  }

  @override
  void dependencies() {
    Get.lazyPut<OrderHistoryBinding>(() => this);
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );
    Get.lazyPut<OrderHistoryController>(
      () => OrderHistoryController(),
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
    Get.lazyPut<OrderHistoryProvider>(
      () => OrderHistoryProvider(),
    );
    Get.lazyPut<RemoteOrderHistoryDataSourceImpl>(
      () => RemoteOrderHistoryDataSourceImpl(),
    );
    Get.lazyPut<LocalOrderHistoryDataSourceImpl>(
      () => LocalOrderHistoryDataSourceImpl(),
    );
    Get.lazyPut<Repository<OrderHistoryModel>>(
      () => OrderHistoryRepositoryImpl<OrderHistoryModel>(),
    );
    Get.lazyPut<OrderHistoryRepository<OrderHistoryModel>>(
      () => OrderHistoryRepositoryImpl<OrderHistoryModel>(),
    );
    Get.lazyPut<UseCase>(
      () => AddOrderHistoryUseCase<OrderHistoryModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteOrderHistoryUseCase<OrderHistoryModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetOrderHistoryUseCase<OrderHistoryModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetOrderHistoryByFieldUseCase<OrderHistoryModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdateOrderHistoryUseCase<OrderHistoryModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ListOrderHistoryUseCase<OrderHistoryModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterOrderHistoryUseCase<OrderHistoryModel>(Get.find()),
    );
  }
}
