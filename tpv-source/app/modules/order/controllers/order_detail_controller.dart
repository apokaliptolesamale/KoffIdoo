// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../domain/models/order_detail_model.dart';
import '../domain/usecases/add_order_detail_usecase.dart';
import '../domain/usecases/delete_order_detail_usecase.dart';
import '../domain/usecases/filter_order_detail_usecase.dart';
import '../domain/usecases/get_order_detail_usecase.dart';
import '../domain/usecases/getby_order_detail_usecase.dart';
import '../domain/usecases/list_order_detail_usecase.dart';
import '../domain/usecases/update_order_detail_usecase.dart';

class OrderDetailController extends GetxController {
  AddOrderDetailUseCase<OrderDetailModel> addOrderDetail =
      AddOrderDetailUseCase<OrderDetailModel>(Get.find());
  DeleteOrderDetailUseCase<OrderDetailModel> deleteOrderDetail =
      DeleteOrderDetailUseCase<OrderDetailModel>(Get.find());
  GetOrderDetailUseCase<OrderDetailModel> getOrderDetail =
      GetOrderDetailUseCase<OrderDetailModel>(Get.find());
  GetOrderDetailByFieldUseCase<OrderDetailModel> getOrderDetailByField =
      GetOrderDetailByFieldUseCase<OrderDetailModel>(Get.find());
  UpdateOrderDetailUseCase<OrderDetailModel> updateOrderDetail =
      UpdateOrderDetailUseCase<OrderDetailModel>(Get.find());
  ListOrderDetailUseCase<OrderDetailModel> listOrderDetailUseOrderDetail =
      ListOrderDetailUseCase<OrderDetailModel>(Get.find());
  FilterOrderDetailUseCase<OrderDetailModel> filterUseOrderDetail =
      FilterOrderDetailUseCase<OrderDetailModel>(Get.find());

  OrderDetailController() : super();

  Future<Either<Failure, EntityModelList<OrderDetailModel>>>
      filterOrderDetails() => filterUseOrderDetail.filter();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is FilterOrderDetailUseCase) {
      result = filterOrderDetails().then((value) => Future.value(value as T));
    } else {
      result = getOrderDetails().then((value) => Future.value(value as T));
    }
    return result;
  }

  Future<Either<Failure, EntityModelList<OrderDetailModel>>>
      getOrderDetails() => listOrderDetailUseOrderDetail.getAll();

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
