// ignore_for_file: must_be_immutable, unused_element

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/config_repository.dart';

FilterUseCaseConfigParams filterUseCaseConfigParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseConfigParams.fromMap(params);

class FilterConfigs<Config>
    implements UseCase<EntityModelList<Config>, FilterUseCaseConfigParams> {
  final ConfigRepository<Config> repository;
  FilterUseCaseConfigParams? parameters;

  FilterConfigs(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Config>>> call(
    FilterUseCaseConfigParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(
            InvalidParamsFailure(message: "No existen datos a mostrar...")));
  }

  Future<Either<Failure, EntityModelList<Config>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseConfigParams? getParams() {
    return parameters ?? FilterUseCaseConfigParams();
  }

  @override
  UseCase<EntityModelList<Config>, FilterUseCaseConfigParams> setParams(
      FilterUseCaseConfigParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Config>, FilterUseCaseConfigParams> setParamsFromMap(
      Map params) {
    parameters = FilterUseCaseConfigParams.fromMap(params);
    return this;
  }
}

class FilterUseCaseConfigParams extends Parametizable {
  final String? idconfig; // id de el caso

  int start = 1;
  int limit = 20;

  FilterUseCaseConfigParams({
    this.idconfig,
  }) : super();

  factory FilterUseCaseConfigParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCaseConfigParams(
          idconfig: params.containsKey("idconfig") ? params["idconfig"] : "");

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"idconfig": idconfig};

  bool _validate<T>(T? value) {
    return value != null;
  }
}
