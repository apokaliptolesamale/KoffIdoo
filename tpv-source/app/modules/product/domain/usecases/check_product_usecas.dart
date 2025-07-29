// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/product_repository.dart';

CheckUseCaseProductParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    CheckUseCaseProductParams.fromMap(params);

class CheckProductUseCase<ProductModel>
    implements UseCase<ProductModel, CheckUseCaseProductParams> {
  final ProductRepository<ProductModel> repository;

  CheckUseCaseProductParams? parameters = CheckUseCaseProductParams();

  CheckProductUseCase(this.repository);

  @override
  Future<Either<Failure, ProductModel>> call(
    CheckUseCaseProductParams? params,
  ) async {
    parameters = params ?? parameters;
    return parameters != null
        ? await repository.checkByCode(parameters!.code)
        : Left(InvalidParamsFailure(
            message: "Debe introducir un código de producto válido."));
  }

  @override
  CheckUseCaseProductParams? getParams() {
    return parameters =
        parameters ?? CheckUseCaseProductParams(id: "0", code: "");
  }

  @override
  UseCase<ProductModel, CheckUseCaseProductParams> setParams(
      CheckUseCaseProductParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<ProductModel, CheckUseCaseProductParams> setParamsFromMap(
      Map params) {
    parameters = CheckUseCaseProductParams.fromMap(params);
    return this;
  }
}

class CheckUseCaseProductParams extends Parametizable {
  String? id, code;

  CheckUseCaseProductParams({
    this.id,
    this.code,
  }) : super();

  factory CheckUseCaseProductParams.fromMap(Map<dynamic, dynamic> params) =>
      CheckUseCaseProductParams(
        id: params.containsKey("id") ? params["id"] : "0",
        code: params.containsKey("code") ? params["code"] : "0",
      );

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
      };
}
