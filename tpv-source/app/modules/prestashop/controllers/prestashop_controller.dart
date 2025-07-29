// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../domain/models/prestashop_model.dart';
import '../domain/usecases/add_prestashop_usecase.dart';
import '../domain/usecases/delete_prestashop_usecase.dart';
import '../domain/usecases/filter_prestashop_usecase.dart';
import '../domain/usecases/get_prestashop_usecase.dart';
import '../domain/usecases/getby_prestashop_usecase.dart';
import '../domain/usecases/list_prestashop_usecase.dart';
import '../domain/usecases/update_prestashop_usecase.dart';

class PrestaShopController extends GetxController {
  AddPrestaShopUseCase<PrestaShopModel> addPrestaShop =
      AddPrestaShopUseCase<PrestaShopModel>(Get.find());
  DeletePrestaShopUseCase<PrestaShopModel> deletePrestaShop =
      DeletePrestaShopUseCase<PrestaShopModel>(Get.find());
  GetPrestaShopUseCase<PrestaShopModel> getPrestaShop =
      GetPrestaShopUseCase<PrestaShopModel>(Get.find());
  GetPrestaShopByFieldUseCase<PrestaShopModel> getPrestaShopByField =
      GetPrestaShopByFieldUseCase<PrestaShopModel>(Get.find());
  UpdatePrestaShopUseCase<PrestaShopModel> updatePrestaShop =
      UpdatePrestaShopUseCase<PrestaShopModel>(Get.find());
  ListPrestaShopUseCase<PrestaShopModel> listPrestaShopUsePrestaShop =
      ListPrestaShopUseCase<PrestaShopModel>(Get.find());
  FilterPrestaShopUseCase<PrestaShopModel> filterUsePrestaShop =
      FilterPrestaShopUseCase<PrestaShopModel>(Get.find());

  PrestaShopController() : super();

  Future<Either<Failure, EntityModelList<PrestaShopModel>>>
      filterPrestaShops() => filterUsePrestaShop.filter();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is FilterPrestaShopUseCase) {
      result = filterPrestaShops().then((value) => Future.value(value as T));
    } else {
      result = getPrestaShops().then((value) => Future.value(value as T));
    }
    return result;
  }

  Future<Either<Failure, EntityModelList<PrestaShopModel>>> getPrestaShops() =>
      listPrestaShopUsePrestaShop.getAll();

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
