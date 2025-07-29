// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/nomenclador_repository.dart';

FilterUseCaseNomencladorParams filterUseCaseIdpParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseNomencladorParams.fromMap(params);

class FilterNomencladorUseCase<NomencladorModel>
    implements
        UseCase<EntityModelList<NomencladorModel>,
            FilterUseCaseNomencladorParams> {
  final NomencladorRepository<NomencladorModel> repository;
  FilterUseCaseNomencladorParams? parameters;

  FilterNomencladorUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<NomencladorModel>>> call(
    FilterUseCaseNomencladorParams? params,
  ) async {
    return (parameters = params ?? parameters)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<NomencladorModel>>> filter() async {
    return call(getParams()!);
  }

  Future<Either<Failure, EntityModelList<NomencladorModel>>>
      getNomencladoresByClientId(String clientId) {
    return repository.getNomencladoresByClientId(clientId);
  }

  @override
  FilterUseCaseNomencladorParams? getParams() {
    return parameters = parameters ?? FilterUseCaseNomencladorParams();
  }

  @override
  UseCase<EntityModelList<NomencladorModel>, FilterUseCaseNomencladorParams>
      setParams(FilterUseCaseNomencladorParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<NomencladorModel>, FilterUseCaseNomencladorParams>
      setParamsFromMap(Map params) {
    parameters = FilterUseCaseNomencladorParams.fromMap(params);
    return this;
  }
}

class FilterUseCaseNomencladorParams extends Parametizable {
  final String? clientId, name; // id de el caso

  int start = 1;
  int limit = 20;

  FilterUseCaseNomencladorParams({
    this.clientId,
    this.name,
  }) : super();

  factory FilterUseCaseNomencladorParams.fromMap(
          Map<dynamic, dynamic> params) =>
      FilterUseCaseNomencladorParams(
        clientId: params.containsKey("clientId") ? params["clientId"] : "",
        name: params.containsKey("name") ? params["name"] : "",
      );

  @override
  bool isValid() {
    return name != null && clientId != null;
  }

  @override
  Map<String, dynamic> toJson() => {
        "clientId": clientId,
        "name": name,
      };

  bool _validate<T>(T? value) {
    return value != null;
  }
}
