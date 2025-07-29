// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/gift_repository.dart';

class FilterGiftUseCase<GiftModel>
    implements UseCase<EntityModelList<GiftModel>, FilterUseCaseGiftParams> {
  final GiftRepository<GiftModel> repository;
  FilterUseCaseGiftParams? parameters;

  FilterGiftUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<GiftModel>>> call(
    FilterUseCaseGiftParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<GiftModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseGiftParams? getParams() {
    return parameters = parameters ?? FilterUseCaseGiftParams(mapGift: {});
  }

  @override
  UseCase<EntityModelList<GiftModel>, FilterUseCaseGiftParams> setParams(
      FilterUseCaseGiftParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<GiftModel>, FilterUseCaseGiftParams> setParamsFromMap(
      Map params) {
    parameters = FilterUseCaseGiftParams.fromMap(params);
    return this;
  }
}

FilterUseCaseGiftParams filterUseCaseGiftParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseGiftParams.fromMap(params);

class FilterUseCaseGiftParams extends Parametizable {
  final Map<String, dynamic> mapGift; // id de el caso

  int start = 1;
  int limit = 20;

  FilterUseCaseGiftParams({
    required this.mapGift,
  }) : super();

  bool _validate<T>(T? value) {
    return value != null;
  }

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  factory FilterUseCaseGiftParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCaseGiftParams(
          mapGift: params.containsKey("gift") ? params["gift"] : {});

  @override
  Map<String, dynamic> toJson() => {"gift": mapGift};
}
