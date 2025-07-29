// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/status_repository.dart';

FilterUseCaseStatusParams filterUseCaseStatusParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseStatusParams.fromMap(params);

class FilterStatusUseCase<StatusModel>
    implements
        UseCase<EntityModelList<StatusModel>, FilterUseCaseStatusParams> {
  final StatusRepository<StatusModel> repository;
  FilterUseCaseStatusParams? parameters;

  FilterStatusUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<StatusModel>>> call(
    FilterUseCaseStatusParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<StatusModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseStatusParams? getParams() {
    return parameters = parameters ?? FilterUseCaseStatusParams();
  }

  @override
  UseCase<EntityModelList<StatusModel>, FilterUseCaseStatusParams> setParams(
      FilterUseCaseStatusParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<StatusModel>, FilterUseCaseStatusParams>
      setParamsFromMap(Map params) {
    parameters = FilterUseCaseStatusParams.fromMap(params);
    return this;
  }
}

class FilterUseCaseStatusParams extends Parametizable {
  final String? idstatus; // id de el caso

  int start = 1;
  int limit = 20;

  FilterUseCaseStatusParams({
    this.idstatus,
  }) : super();

  factory FilterUseCaseStatusParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCaseStatusParams(
          idstatus: params.containsKey("idstatus") ? params["idstatus"] : "");

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"idstatus": idstatus};

  bool _validate<T>(T? value) {
    return value != null;
  }
}
