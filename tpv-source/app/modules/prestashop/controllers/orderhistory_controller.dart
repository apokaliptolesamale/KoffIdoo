// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../domain/models/orderhistory_model.dart';
import '../domain/usecases/add_orderhistory_usecase.dart';
import '../domain/usecases/delete_orderhistory_usecase.dart';
import '../domain/usecases/filter_orderhistory_usecase.dart';
import '../domain/usecases/get_orderhistory_usecase.dart';
import '../domain/usecases/getby_orderhistory_usecase.dart';
import '../domain/usecases/list_orderhistory_usecase.dart';
import '../domain/usecases/update_orderhistory_usecase.dart';

class OrderHistoryController extends GetxController {
  AddOrderHistoryUseCase<OrderHistoryModel> addOrderHistory =
      AddOrderHistoryUseCase<OrderHistoryModel>(Get.find());
  DeleteOrderHistoryUseCase<OrderHistoryModel> deleteOrderHistory =
      DeleteOrderHistoryUseCase<OrderHistoryModel>(Get.find());
  GetOrderHistoryUseCase<OrderHistoryModel> getOrderHistory =
      GetOrderHistoryUseCase<OrderHistoryModel>(Get.find());
  GetOrderHistoryByFieldUseCase<OrderHistoryModel> getOrderHistoryByField =
      GetOrderHistoryByFieldUseCase<OrderHistoryModel>(Get.find());
  UpdateOrderHistoryUseCase<OrderHistoryModel> updateOrderHistory =
      UpdateOrderHistoryUseCase<OrderHistoryModel>(Get.find());
  ListOrderHistoryUseCase<OrderHistoryModel> listOrderHistoryUseOrderHistory =
      ListOrderHistoryUseCase<OrderHistoryModel>(Get.find());
  FilterOrderHistoryUseCase<OrderHistoryModel> filterUseOrderHistory =
      FilterOrderHistoryUseCase<OrderHistoryModel>(Get.find());

  OrderHistoryController() : super();

  Future<Either<Failure, EntityModelList<OrderHistoryModel>>>
      filterOrderHistorys() => filterUseOrderHistory.filter();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is FilterOrderHistoryUseCase) {
      result = filterOrderHistorys().then((value) => Future.value(value as T));
    } else if (uc is UpdateOrderHistoryUseCase<OrderHistoryModel>) {
      result = updateOrderHistorys().then((value) => Future.value(value as T));
    } else {
      result = getOrderHistorys().then((value) => Future.value(value as T));
    }
    return result;
  }

  Future<Either<Failure, EntityModelList<OrderHistoryModel>>>
      getOrderHistorys() => listOrderHistoryUseOrderHistory.getAll();

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

  Future<Either<Failure, OrderHistoryModel>> updateOrderHistorys() =>
      updateOrderHistory.call(null);
}
