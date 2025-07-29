// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/product_repository.dart';

FilterUseCaseProductParams filterUseCaseProductParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseProductParams.fromMap(params);

class FilterProductUseCase<ProductModel>
    implements
        UseCase<EntityModelList<ProductModel>, FilterUseCaseProductParams> {
  final ProductRepository<ProductModel> repository;
  FilterUseCaseProductParams? parameters;

  FilterProductUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<ProductModel>>> call(
    FilterUseCaseProductParams? params,
  ) async {
    parameters = params ?? parameters ?? FilterUseCaseProductParams.fromMap({});
    return parameters!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<ProductModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseProductParams? getParams() {
    return parameters = parameters ?? FilterUseCaseProductParams();
  }

  @override
  UseCase<EntityModelList<ProductModel>, FilterUseCaseProductParams> setParams(
      FilterUseCaseProductParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<ProductModel>, FilterUseCaseProductParams>
      setParamsFromMap(Map params) {
    parameters = FilterUseCaseProductParams.fromMap(params);
    return this;
  }
}

class FilterUseCaseProductParams extends Parametizable {
  String? idProduct;
  String? idOrderService,
      productName,
      serialNumber1,
      code,
      mark,
      model,
      idWarranty,
      salePrice;
  String? idOrder;

  int? page = 1;
  int? count = 20;

  FilterUseCaseProductParams({
    this.idProduct,
    this.idOrder,
    this.idOrderService,
    this.productName,
    this.serialNumber1,
    this.code,
    this.mark,
    this.model,
    this.idWarranty,
    this.salePrice,
    this.page,
    this.count,
  }) : super();

  factory FilterUseCaseProductParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCaseProductParams(
        idProduct: EntityModel.getValueFromJson("idProduct", params, null),
        idOrderService:
            EntityModel.getValueFromJson("idOrderService", params, null),
        idOrder: EntityModel.getValueFromJson("idOrder", params, null),
        productName: EntityModel.getValueFromJson("productName", params, null),
        serialNumber1:
            EntityModel.getValueFromJson("serialNumber1", params, null),
        code: EntityModel.getValueFromJson("code", params, null),
        mark: EntityModel.getValueFromJson("mark", params, null),
        model: EntityModel.getValueFromJson("model", params, null),
        idWarranty: EntityModel.getValueFromJson("idWarranty", params, null),
        salePrice: EntityModel.getValueFromJson("salePrice", params, null),
        page: EntityModel.getValueFromJson("page", params, 0),
        count: EntityModel.getValueFromJson("count", params, 5),
      );

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {
        "idProduct": idProduct,
        "idOrder": idOrder,
        "idOrderService": idOrderService,
        "productName": productName,
        "serialNumber1": serialNumber1,
        "code": code,
        "mark": mark,
        "model": model,
        "idWarranty": idWarranty,
        "salePrice": salePrice,
        "page": page,
        "count": count,
      };

  bool _validate<T>(T? value) {
    return value != null;
  }
}
