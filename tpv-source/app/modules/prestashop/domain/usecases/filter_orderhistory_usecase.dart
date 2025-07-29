// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/orderhistory_repository.dart';

FilterUseCaseOrderHistoryParams filterUseCaseOrderHistoryParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseOrderHistoryParams.fromMap(params);

class FilterOrderHistoryUseCase<OrderHistoryModel>
    implements
        UseCase<EntityModelList<OrderHistoryModel>,
            FilterUseCaseOrderHistoryParams> {
  final OrderHistoryRepository<OrderHistoryModel> repository;
  FilterUseCaseOrderHistoryParams? parameters;

  FilterOrderHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<OrderHistoryModel>>> call(
    FilterUseCaseOrderHistoryParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<OrderHistoryModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseOrderHistoryParams? getParams() {
    return parameters = parameters ?? FilterUseCaseOrderHistoryParams();
  }

  @override
  UseCase<EntityModelList<OrderHistoryModel>, FilterUseCaseOrderHistoryParams>
      setParams(FilterUseCaseOrderHistoryParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<OrderHistoryModel>, FilterUseCaseOrderHistoryParams>
      setParamsFromMap(Map params) {
    parameters = FilterUseCaseOrderHistoryParams.fromMap(params);
    return this;
  }
}

class FilterUseCaseOrderHistoryParams extends Parametizable {
  final String? idorderhistory; // id de el caso

  int start = 1;
  int limit = 20;

  FilterUseCaseOrderHistoryParams({
    this.idorderhistory,
  }) : super();

  factory FilterUseCaseOrderHistoryParams.fromMap(
          Map<dynamic, dynamic> params) =>
      FilterUseCaseOrderHistoryParams(
          idorderhistory: params.containsKey("idorderhistory")
              ? params["idorderhistory"]
              : "");

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"idorderhistory": idorderhistory};

  bool _validate<T>(T? value) {
    return value != null;
  }
}
