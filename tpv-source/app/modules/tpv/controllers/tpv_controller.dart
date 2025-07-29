// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../../product/domain/models/product_model.dart';
import '../../product/domain/usecases/filter_product_usecase.dart';

class TpvController extends GetxController {
  TpvController() : super();

  FilterProductUseCase<ProductModel> getAllProductsByFilterUseCase =
      Get.isRegistered<FilterProductUseCase<ProductModel>>()
          ? Get.find<FilterProductUseCase<ProductModel>>()
          : FilterProductUseCase<ProductModel>(Get.find());

  Future<Either<Failure, EntityModelList<ProductModel>>>
      getAllProducts() async {
    return getAllProductsByFilterUseCase.setParamsFromMap({
      "page": 0,
      "count": 15,
    }).call(null);
    // return getAllProductsByFilterUseCase.call(null);
  }

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    return Future.value();
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
