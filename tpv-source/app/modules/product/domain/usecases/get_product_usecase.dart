// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/product_repository.dart';

GetUseCaseProductParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseProductParams.fromMap(params);

class GetProductUseCase<ProductModel>
    implements UseCase<ProductModel, GetUseCaseProductParams> {
  final ProductRepository<ProductModel> repository;

  GetUseCaseProductParams? parameters = GetUseCaseProductParams();

  GetProductUseCase(this.repository);

  @override
  Future<Either<Failure, ProductModel>> call(
    GetUseCaseProductParams? params,
  ) async {
    return await repository.getProduct((parameters = params ?? parameters)!.id);
  }

  @override
  GetUseCaseProductParams? getParams() {
    return parameters = parameters ?? GetUseCaseProductParams(id: "0");
  }

  @override
  UseCase<ProductModel, GetUseCaseProductParams> setParams(
      GetUseCaseProductParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<ProductModel, GetUseCaseProductParams> setParamsFromMap(Map params) {
    parameters = GetUseCaseProductParams.fromMap(params);
    return this;
  }
}

class GetUseCaseProductParams extends Parametizable {
  String? id;
  String? idProduct;
  GetUseCaseProductParams({
    this.id,
    this.idProduct,
  }) : super();

  factory GetUseCaseProductParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseProductParams(
        id: params.containsKey("id") ? params["id"].toString() : "0",
        idProduct: params.containsKey("idProduct")
            ? params["idProduct"].toString()
            : "0",
      );

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "idProduct": idProduct,
      };
}
