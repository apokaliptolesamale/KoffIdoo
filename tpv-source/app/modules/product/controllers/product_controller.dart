// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '/app/modules/product/domain/usecases/check_product_usecas.dart';
import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../../product/domain/models/product_model.dart';
import '../../product/domain/usecases/add_product_usecase.dart';
import '../../product/domain/usecases/delete_product_usecase.dart';
import '../../product/domain/usecases/filter_product_usecase.dart';
import '../../product/domain/usecases/get_product_usecase.dart';
import '../../product/domain/usecases/getby_product_usecase.dart';
import '../../product/domain/usecases/list_product_usecase.dart';
import '../../product/domain/usecases/update_product_usecase.dart';

class ProductController extends GetxController {
  AddProductUseCase<ProductModel> addProduct =
      AddProductUseCase<ProductModel>(Get.find());
  DeleteProductUseCase<ProductModel> deleteProduct =
      DeleteProductUseCase<ProductModel>(Get.find());
  GetProductUseCase<ProductModel> getProduct =
      GetProductUseCase<ProductModel>(Get.find());
  GetProductByFieldUseCase<ProductModel> getProductByField =
      GetProductByFieldUseCase<ProductModel>(Get.find());
  UpdateProductUseCase<ProductModel> updateProduct =
      UpdateProductUseCase<ProductModel>(Get.find());
  ListProductUseCase<ProductModel> listProductUseProduct =
      ListProductUseCase<ProductModel>(Get.find());
  FilterProductUseCase<ProductModel> filterUseProduct =
      FilterProductUseCase<ProductModel>(Get.find());
  CheckProductUseCase<ProductModel> checkUseProduct =
      CheckProductUseCase<ProductModel>(Get.find());

  ProductController() : super();

  Future<Either<Failure, ProductModel>> check() =>
      checkUseProduct.call(checkUseProduct.parameters);

  Future<Either<Failure, EntityModelList<ProductModel>>> filterProducts() =>
      filterUseProduct.filter();
  Future<Either<Failure, ProductModel>> get() =>
      getProduct.call(getProduct.parameters);

  Future<Either<Failure, EntityModelList<ProductModel>>> getByFields() =>
      getProductByField.call(null);

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is FilterProductUseCase<ProductModel>) {
      filterUseProduct = uc;
      result = filterProducts().then((value) => Future.value(value as T));
    } else if (uc is GetProductByFieldUseCase<ProductModel>) {
      getProductByField = uc;
      result = getByFields().then((value) => Future.value(value as T));
    } else if (uc is GetProductUseCase<ProductModel>) {
      getProduct = uc;
      result = get().then((value) => Future.value(value as T));
    } else if (uc is CheckProductUseCase<ProductModel>) {
      checkUseProduct = uc;
      result = check().then((value) => Future.value(value as T));
    } else {
      result = getProducts().then((value) => Future.value(value as T));
    }
    return result;
  }

  Future<Either<Failure, EntityModelList<ProductModel>>> getProducts() =>
      listProductUseProduct.getAll();

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
