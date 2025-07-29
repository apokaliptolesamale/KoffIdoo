// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/nomenclador_repository.dart';

ListUseCaseNomencladorParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseNomencladorParams.fromMap(params);

class ListNomencladorUseCase<NomencladorModel>
    implements
        UseCase<EntityModelList<NomencladorModel>,
            ListUseCaseNomencladorParams> {
  final NomencladorRepository<NomencladorModel> repository;
  late ListUseCaseNomencladorParams? parameters;

  ListNomencladorUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<NomencladorModel>>> call(
    ListUseCaseNomencladorParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<NomencladorModel>>> getAll() async {
    return await call(getParams());
  }

  Future<Either<Failure, EntityModelList<NomencladorModel>>>
      getComercialUnits() {
    return repository.getComercialUnits();
  }

  @override
  ListUseCaseNomencladorParams? getParams() {
    return parameters = parameters ?? ListUseCaseNomencladorParams();
  }

  Future<Either<Failure, EntityModelList<NomencladorModel>>>
      getPaymentTypesFromAssets() {
    return repository.getPaymentTypesFromAssets();
  }

  Future<Either<Failure, EntityModelList<NomencladorModel>>>
      getProvinciasFromAssets() {
    return repository.getProvinciasFromAssets();
  }

  Future<Either<Failure, EntityModelList<NomencladorModel>>>
      getTrdUnitsFromAssets() {
    return repository.getTrdUnitsFromAssets();
  }

  @override
  UseCase<EntityModelList<NomencladorModel>, ListUseCaseNomencladorParams>
      setParams(ListUseCaseNomencladorParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<NomencladorModel>, ListUseCaseNomencladorParams>
      setParamsFromMap(Map params) {
    parameters = ListUseCaseNomencladorParams.fromMap(params);
    return this;
  }
}

class ListUseCaseNomencladorParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseNomencladorParams({
    this.start = -1,
    this.limit = -1,
    this.getAll = false,
  }) : super() {
    if (start == -1 || limit == -1) getAll = true;
  }

  factory ListUseCaseNomencladorParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseNomencladorParams(
        start: params.containsKey("start") ? params["start"] : 1,
        limit: params.containsKey("limit") ? params["limit"] : 50,
      );

  @override
  bool isValid() {
    return start! > 0 && start! < limit!;
  }

  @override
  Map<String, dynamic> toJson() => {"start": start ?? 1, "limit": limit ?? 50};
}
