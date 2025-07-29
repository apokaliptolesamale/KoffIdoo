// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '/app/modules/transaction/domain/repository/card_gift_repository.dart';

class FilterCardGiftCategoryUseCase<CardGiftModel>
    implements
        UseCase<EntityModelList<CardGiftModel>,
            FilterUseCaseGiftCategoryParams> {
  final CardGiftRepository<CardGiftModel> repository;
  FilterUseCaseGiftCategoryParams? parameters;

  FilterCardGiftCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<CardGiftModel>>> call(
    FilterUseCaseGiftCategoryParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<CardGiftModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseGiftCategoryParams? getParams() {
    return parameters =
        parameters ?? FilterUseCaseGiftCategoryParams(uuid: '');
  }

  @override
  UseCase<EntityModelList<CardGiftModel>, FilterUseCaseGiftCategoryParams>
      setParams(FilterUseCaseGiftCategoryParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<CardGiftModel>, FilterUseCaseGiftCategoryParams>
      setParamsFromMap(Map params) {
    parameters = FilterUseCaseGiftCategoryParams.fromMap(params);
    return this;
  }
}

FilterUseCaseGiftCategoryParams filterUseCaseGiftParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseGiftCategoryParams.fromMap(params);

class FilterUseCaseGiftCategoryParams extends Parametizable {
  final String uuid; // id de el caso

  int start = 1;
  int limit = 20;

  FilterUseCaseGiftCategoryParams({
    required this.uuid,
  }) : super();

  bool _validate<T>(T? value) {
    return value != null;
  }

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  factory FilterUseCaseGiftCategoryParams.fromMap(
          Map<dynamic, dynamic> params) =>
      FilterUseCaseGiftCategoryParams(
          uuid: params.containsKey("uuid") ? params["uuid"] : '');

  @override
  Map<String, dynamic> toJson() => {"uuid": uuid};
}
