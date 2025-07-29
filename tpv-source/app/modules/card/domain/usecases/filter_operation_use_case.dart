// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/operation_model.dart';
import '../repository/operation_repository.dart';

class FilterOperationUseCase<CardModel>
    implements
        UseCase<EntityModelList<OperationModel>,
            FilterOperationUseCaseCardParams> {
  final OperationRepository<OperationModel> repository;
  FilterOperationUseCaseCardParams? parameters;

  FilterOperationUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<OperationModel>>> call(
    FilterOperationUseCaseCardParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<OperationModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterOperationUseCaseCardParams? getParams() {
    return parameters = parameters ?? FilterOperationUseCaseCardParams();
  }

  @override
  UseCase<EntityModelList<OperationModel>, FilterOperationUseCaseCardParams>
      setParams(FilterOperationUseCaseCardParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<OperationModel>, FilterOperationUseCaseCardParams>
      setParamsFromMap(Map params) {
    parameters = FilterOperationUseCaseCardParams.fromMap(params);
    return this;
  }
}

FilterOperationUseCaseCardParams filterUseCaseCardParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterOperationUseCaseCardParams.fromMap(params);

class FilterOperationUseCaseCardParams extends Parametizable {
  final String? idcard; // id de el caso

  int start = 1;
  int limit = 20;

  FilterOperationUseCaseCardParams({
    this.idcard,
  }) : super();

  bool _validate<T>(T? value) {
    return value != null;
  }

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  factory FilterOperationUseCaseCardParams.fromMap(
          Map<dynamic, dynamic> params) =>
      FilterOperationUseCaseCardParams(
          idcard: params.containsKey("id") ? params["id"] : "");

  @override
  Map<String, dynamic> toJson() => {"id": idcard};
}
