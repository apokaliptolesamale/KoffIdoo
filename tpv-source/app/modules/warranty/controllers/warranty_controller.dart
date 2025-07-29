// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../domain/models/warranty_model.dart';
import '../domain/usecases/add_warranty_usecase.dart';
import '../domain/usecases/delete_warranty_usecase.dart';
import '../domain/usecases/filter_warranty_usecase.dart';
import '../domain/usecases/get_warranty_usecase.dart';
import '../domain/usecases/getby_warranty_usecase.dart';
import '../domain/usecases/list_warranty_usecase.dart';
import '../domain/usecases/update_warranty_usecase.dart';

class WarrantyController extends GetxController {
  AddWarrantyUseCase<WarrantyModel> addWarranty =
      AddWarrantyUseCase<WarrantyModel>(Get.find());
  DeleteWarrantyUseCase<WarrantyModel> deleteWarranty =
      DeleteWarrantyUseCase<WarrantyModel>(Get.find());
  GetWarrantyUseCase<WarrantyModel> getWarranty =
      GetWarrantyUseCase<WarrantyModel>(Get.find());
  GetWarrantyByFieldUseCase<WarrantyModel> getWarrantyByField =
      GetWarrantyByFieldUseCase<WarrantyModel>(Get.find());
  UpdateWarrantyUseCase<WarrantyModel> updateWarranty =
      UpdateWarrantyUseCase<WarrantyModel>(Get.find());
  ListWarrantyUseCase<WarrantyModel> listWarrantyUseWarranty =
      ListWarrantyUseCase<WarrantyModel>(Get.find());
  FilterWarrantyUseCase<WarrantyModel> filterUseWarranty =
      FilterWarrantyUseCase<WarrantyModel>(Get.find());

  WarrantyController() : super();

  Future<Either<Failure, EntityModelList<WarrantyModel>>> filterWarrantys() =>
      filterUseWarranty.filter();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;

    if (uc is GetWarrantyUseCase<WarrantyModel>) {
      getWarranty = uc;
      result = getWarrantyModel().then((value) => Future.value(value as T));
    } else if (uc is FilterWarrantyUseCase<WarrantyModel>) {
      filterUseWarranty = uc;
      result = filterWarrantys().then((value) => Future.value(value as T));
    } else {
      result = getWarrantys().then((value) => Future.value(value as T));
    }
    return result;
  }

  Future<Either<Failure, WarrantyModel>> getWarrantyModel() =>
      getWarranty.call(getWarranty.getParams());

  Future<Either<Failure, EntityModelList<WarrantyModel>>> getWarrantys() =>
      listWarrantyUseWarranty.getAll();

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
