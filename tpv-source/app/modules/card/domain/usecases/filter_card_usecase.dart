// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/card_repository.dart';

class FilterCardUseCase<CardModel>
    implements UseCase<EntityModelList<CardModel>, FilterUseCaseCardParams> {
  final CardRepository<CardModel> repository;
  FilterUseCaseCardParams? parameters;

  FilterCardUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<CardModel>>> call(
    FilterUseCaseCardParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<CardModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseCardParams? getParams() {
    return parameters = parameters ?? FilterUseCaseCardParams();
  }

  @override
  UseCase<EntityModelList<CardModel>, FilterUseCaseCardParams> setParams(
      FilterUseCaseCardParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<CardModel>, FilterUseCaseCardParams> setParamsFromMap(
      Map params) {
    parameters = FilterUseCaseCardParams.fromMap(params);
    return this;
  }
}

FilterUseCaseCardParams filterUseCaseCardParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseCardParams.fromMap(params);

class FilterUseCaseCardParams extends Parametizable {
  final String? idcard; // id de el caso

  int start = 1;
  int limit = 20;

  FilterUseCaseCardParams({
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

  factory FilterUseCaseCardParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCaseCardParams(
          idcard: params.containsKey("idcard") ? params["idcard"] : "");

  @override
  Map<String, dynamic> toJson() => {"idcard": idcard};
}
