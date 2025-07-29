import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../security/data/providers/token_provider.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../domain/models/order_detail_model.dart';
import '../domain/usecases/add_order_detail_usecase.dart';
import '../domain/usecases/delete_order_detail_usecase.dart';
import '../domain/usecases/get_order_detail_usecase.dart';
import '../domain/usecases/getby_order_detail_usecase.dart';
import '../domain/usecases/update_order_detail_usecase.dart';
import '../domain/usecases/list_order_detail_usecase.dart';
import '../domain/usecases/filter_order_detail_usecase.dart';
import '../order_detail_exporting.dart';
import '../data/providers/order_detail_provider.dart';



class OrderDetailBinding extends Bindings 
{

  OrderDetailBinding() : super() {
    log("Registrando instancia de:${toString()} y sus dependencias.");
    dependencies();
  }

  @override
  void dependencies() 
  {
    Get.lazyPut<OrderDetailBinding>(() => this);
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );   
    Get.lazyPut<OrderDetailController>(
      () => OrderDetailController(),
    );
    Get.lazyPut<home_app.HomeController>(() => home_app.HomeController(),
    );
    Get.lazyPut<http.Client>(
      () => http.Client(),
    );
    Get.lazyPut<rest_client.Client>(
      () => rest_client.Client(),
    );
     Get.lazyPut<OrderDetailProvider>(
      () => OrderDetailProvider(),
    );
    Get.lazyPut<RemoteOrderDetailDataSourceImpl>(
      () => RemoteOrderDetailDataSourceImpl(),
    );
    Get.lazyPut<LocalOrderDetailDataSourceImpl>(
      () => LocalOrderDetailDataSourceImpl(),
    );
    Get.lazyPut<Repository<OrderDetailModel>>(
      () => OrderDetailRepositoryImpl<OrderDetailModel>(),
    );
    Get.lazyPut<OrderDetailRepository<OrderDetailModel>>(
      () => OrderDetailRepositoryImpl<OrderDetailModel>(),
    );
    Get.lazyPut<UseCase>(
      () => AddOrderDetailUseCase<OrderDetailModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteOrderDetailUseCase<OrderDetailModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetOrderDetailUseCase<OrderDetailModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetOrderDetailByFieldUseCase<OrderDetailModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdateOrderDetailUseCase<OrderDetailModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ListOrderDetailUseCase<OrderDetailModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterOrderDetailUseCase<OrderDetailModel>(Get.find()),
    );
    

  }
  
}
