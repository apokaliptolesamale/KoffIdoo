// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/card_repository.dart';

GetUseCaseSetAsDefaultParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseSetAsDefaultParams.fromMap(params);

class GetSetAsDefaultUseCase<CardModel>
    implements UseCase<CardModel, GetUseCaseSetAsDefaultParams> {
  final CardRepository<CardModel> repository;
  late GetUseCaseSetAsDefaultParams? parameters;

  GetSetAsDefaultUseCase(this.repository);

  @override
  Future<Either<Failure, CardModel>> call(
    GetUseCaseSetAsDefaultParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.getSetAsDefault((params ?? parameters)!.entity);
  }

  @override
  GetUseCaseSetAsDefaultParams? getParams() {
    return parameters = parameters ?? GetUseCaseSetAsDefaultParams(entity: '');
  }

  @override
  UseCase<CardModel, GetUseCaseSetAsDefaultParams> setParams(
      GetUseCaseSetAsDefaultParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<CardModel, GetUseCaseSetAsDefaultParams> setParamsFromMap(
      Map params) {
    parameters = GetUseCaseSetAsDefaultParams.fromMap(params);
    return this;
  }
}

class GetUseCaseSetAsDefaultParams extends Parametizable {
  final String entity;
  GetUseCaseSetAsDefaultParams({
    required this.entity,
  }) : super();

  factory GetUseCaseSetAsDefaultParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseSetAsDefaultParams(
          entity: params.containsKey("funding_source_uuid")
              ? params["primary_source"]
              : '');

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"funding_source_uuid": entity};
}
