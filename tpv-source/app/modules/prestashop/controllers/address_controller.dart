// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../domain/models/address_model.dart';
import '../domain/usecases/add_address_usecase.dart';
import '../domain/usecases/delete_address_usecase.dart';
import '../domain/usecases/filter_address_usecase.dart';
import '../domain/usecases/get_address_usecase.dart';
import '../domain/usecases/getby_address_usecase.dart';
import '../domain/usecases/list_address_usecase.dart';
import '../domain/usecases/update_address_usecase.dart';

class AddressController extends GetxController {
  AddAddressUseCase<AddressModel> addAddress =
      AddAddressUseCase<AddressModel>(Get.find());
  DeleteAddressUseCase<AddressModel> deleteAddress =
      DeleteAddressUseCase<AddressModel>(Get.find());
  GetAddressUseCase<AddressModel> getAddress =
      GetAddressUseCase<AddressModel>(Get.find());
  GetAddressByFieldUseCase<AddressModel> getAddressByField =
      GetAddressByFieldUseCase<AddressModel>(Get.find());
  UpdateAddressUseCase<AddressModel> updateAddress =
      UpdateAddressUseCase<AddressModel>(Get.find());
  ListAddressUseCase<AddressModel> listAddressUseAddress =
      ListAddressUseCase<AddressModel>(Get.find());
  FilterAddressUseCase<AddressModel> filterUseAddress =
      FilterAddressUseCase<AddressModel>(Get.find());

  AddressController() : super();

  Future<Either<Failure, EntityModelList<AddressModel>>> filterAddresss() =>
      filterUseAddress.filter();

  Future<Either<Failure, EntityModelList<AddressModel>>> getAddresss() =>
      listAddressUseAddress.getAll();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is FilterAddressUseCase) {
      result = filterAddresss().then((value) => Future.value(value as T));
    } else {
      result = getAddresss().then((value) => Future.value(value as T));
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
