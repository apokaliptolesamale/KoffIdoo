// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../../order/domain/usecases/add_order_usecase.dart';
import '../../order/domain/usecases/delete_order_usecase.dart';
import '../../order/domain/usecases/filter_order_usecase.dart';
import '../../order/domain/usecases/get_order_usecase.dart';
import '../../order/domain/usecases/getby_order_usecase.dart';
import '../../order/domain/usecases/list_order_usecase.dart';
import '../../order/domain/usecases/update_order_usecase.dart';
import '../domain/models/order_model.dart';

class OrderController extends GetxController {
  AddOrderUseCase<OrderModel> addOrder =
      AddOrderUseCase<OrderModel>(Get.find());
  DeleteOrderUseCase<OrderModel> deleteOrder =
      DeleteOrderUseCase<OrderModel>(Get.find());
  GetOrderUseCase<OrderModel> getOrder =
      GetOrderUseCase<OrderModel>(Get.find());
  GetOrderByFieldUseCase<OrderModel> getOrderByField =
      GetOrderByFieldUseCase<OrderModel>(Get.find());
  UpdateOrderUseCase<OrderModel> updateOrder =
      UpdateOrderUseCase<OrderModel>(Get.find());
  ListOrderUseCase<OrderModel> listOrderUseOrder =
      ListOrderUseCase<OrderModel>(Get.find());
  FilterOrderUseCase<OrderModel> filterUseOrder =
      FilterOrderUseCase<OrderModel>(Get.find());
  ListOrderUseCase<OrderModel> listOrderUseCase =
      ListOrderUseCase<OrderModel>(Get.find());

  OrderController() : super();

  Future<Either<Failure, EntityModelList<OrderModel>>> filterOrders() =>
      filterUseOrder.filter();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is FilterOrderUseCase) {
      filterUseOrder = uc;
      result = filterOrders().then((value) => Future.value(value as T));
    } else if (uc is ListOrderUseCase) {
      result = getOrders().then((value) => Future.value(value as T));
    } else {
      result = getOrders().then((value) => Future.value(value as T));
    }
    return result;
  }

  Future<Either<Failure, EntityModelList<OrderModel>>> getOrders() =>
      listOrderUseOrder.getAll();

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
