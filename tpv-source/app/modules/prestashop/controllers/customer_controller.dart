// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../domain/models/customer_model.dart';
import '../domain/usecases/add_customer_usecase.dart';
import '../domain/usecases/delete_customer_usecase.dart';
import '../domain/usecases/filter_customer_usecase.dart';
import '../domain/usecases/get_customer_usecase.dart';
import '../domain/usecases/getby_customer_usecase.dart';
import '../domain/usecases/list_customer_usecase.dart';
import '../domain/usecases/update_customer_usecase.dart';

class CustomerController extends GetxController {
  AddCustomerUseCase<CustomerModel> addCustomer =
      AddCustomerUseCase<CustomerModel>(Get.find());
  DeleteCustomerUseCase<CustomerModel> deleteCustomer =
      DeleteCustomerUseCase<CustomerModel>(Get.find());
  GetCustomerUseCase<CustomerModel> getCustomer =
      GetCustomerUseCase<CustomerModel>(Get.find());
  GetCustomerByFieldUseCase<CustomerModel> getCustomerByField =
      GetCustomerByFieldUseCase<CustomerModel>(Get.find());
  UpdateCustomerUseCase<CustomerModel> updateCustomer =
      UpdateCustomerUseCase<CustomerModel>(Get.find());
  ListCustomerUseCase<CustomerModel> listCustomerUseCustomer =
      ListCustomerUseCase<CustomerModel>(Get.find());
  FilterCustomerUseCase<CustomerModel> filterUseCustomer =
      FilterCustomerUseCase<CustomerModel>(Get.find());

  CustomerController() : super();

  Future<Either<Failure, EntityModelList<CustomerModel>>> filterCustomers() =>
      filterUseCustomer.filter();

  Future<Either<Failure, EntityModelList<CustomerModel>>> getCustomers() =>
      listCustomerUseCustomer.getAll();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is FilterCustomerUseCase) {
      result = filterCustomers().then((value) => Future.value(value as T));
    } else {
      result = getCustomers().then((value) => Future.value(value as T));
    }
    return result;
  }

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
