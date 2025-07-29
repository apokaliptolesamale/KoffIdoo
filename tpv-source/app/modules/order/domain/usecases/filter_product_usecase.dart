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
    return (parameters = params)!.isValid()
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
  final String? idproduct; // id de el caso

  int start = 1;
  int limit = 20;

  FilterUseCaseProductParams({
    this.idproduct,
  }) : super();

  factory FilterUseCaseProductParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCaseProductParams(
          idproduct:
              params.containsKey("idproduct") ? params["idproduct"] : "");

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"idproduct": idproduct};

  bool _validate<T>(T? value) {
    return value != null;
  }
}
