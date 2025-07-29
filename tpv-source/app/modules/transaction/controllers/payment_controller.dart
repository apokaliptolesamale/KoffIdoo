// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../domain/models/payment_model.dart';
import '../domain/usecases/add_payment_usecase.dart';
import '../domain/usecases/delete_payment_usecase.dart';
import '../domain/usecases/filter_payment_usecase.dart';
import '../domain/usecases/get_payment_usecase.dart';
import '../domain/usecases/getby_payment_usecase.dart';
import '../domain/usecases/list_payment_usecase.dart';
import '../domain/usecases/update_payment_usecase.dart';


class PaymentController extends GetxController {

  AddPaymentUseCase<PaymentModel> addPayment = AddPaymentUseCase<PaymentModel>(Get.find());
  DeletePaymentUseCase<PaymentModel> deletePayment = DeletePaymentUseCase<PaymentModel>(Get.find());
  GetPaymentUseCase<PaymentModel> getPayment = GetPaymentUseCase<PaymentModel>(Get.find());
  GetPaymentByFieldUseCase<PaymentModel> getPaymentByField = GetPaymentByFieldUseCase<PaymentModel>(Get.find());
  UpdatePaymentUseCase<PaymentModel> updatePayment = UpdatePaymentUseCase<PaymentModel>(Get.find());
  ListPaymentUseCase<PaymentModel> listPaymentUsePayment = ListPaymentUseCase<PaymentModel>(Get.find());
  FilterPaymentUseCase<PaymentModel> filterUsePayment = FilterPaymentUseCase<PaymentModel>(Get.find());
  
  
  PaymentController() : super();

  Future<Either<Failure, EntityModelList<PaymentModel>>> getPayments() =>
      listPaymentUsePayment.getAll();

  Future<Either<Failure, EntityModelList<PaymentModel>>> filterPayments() =>
      filterUsePayment.filter();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is FilterPaymentUseCase) {
      result = filterPayments().then((value) => Future.value(value as T));
    } else {
      result = getPayments().then((value) => Future.value(value as T));
    }
    return result;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
