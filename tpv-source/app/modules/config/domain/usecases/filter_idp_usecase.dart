// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/idp_repository.dart';

class FilterIdpUseCase<IdpModel>
    implements UseCase<EntityModelList<IdpModel>, FilterUseCaseIdpParams> {
  final IdpRepository<IdpModel> repository;
  FilterUseCaseIdpParams? parameters;

  FilterIdpUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<IdpModel>>> call(
    FilterUseCaseIdpParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<IdpModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseIdpParams? getParams() {
    return parameters = parameters ?? FilterUseCaseIdpParams();
  }

  @override
  UseCase<EntityModelList<IdpModel>, FilterUseCaseIdpParams> setParams(
      FilterUseCaseIdpParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<IdpModel>, FilterUseCaseIdpParams> setParamsFromMap(
      Map params) {
    parameters = FilterUseCaseIdpParams.fromMap(params);
    return this;
  }
}

FilterUseCaseIdpParams filterUseCaseIdpParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseIdpParams.fromMap(params);

class FilterUseCaseIdpParams extends Parametizable {
  final String? ididp; // id de el caso

  int start = 1;
  int limit = 20;

  FilterUseCaseIdpParams({
    this.ididp,
  }) : super();

  bool _validate<T>(T? value) {
    return value != null;
  }

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  factory FilterUseCaseIdpParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCaseIdpParams(
          ididp: params.containsKey("ididp") ? params["ididp"] : "");

  @override
  Map<String, dynamic> toJson() => {"ididp": ididp};
}
