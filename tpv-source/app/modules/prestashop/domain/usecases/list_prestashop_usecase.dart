// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/prestashop_repository.dart';

ListUseCasePrestaShopParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCasePrestaShopParams.fromMap(params);

class ListPrestaShopUseCase<PrestaShopModel>
    implements
        UseCase<EntityModelList<PrestaShopModel>, ListUseCasePrestaShopParams> {
  final PrestaShopRepository<PrestaShopModel> repository;
  late ListUseCasePrestaShopParams? parameters;

  ListPrestaShopUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<PrestaShopModel>>> call(
    ListUseCasePrestaShopParams? params,
  ) async {
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<PrestaShopModel>>> getAll() async {
    return await call(getParams());
  }

  @override
  ListUseCasePrestaShopParams? getParams() {
    return parameters = parameters ?? ListUseCasePrestaShopParams();
  }

  @override
  UseCase<EntityModelList<PrestaShopModel>, ListUseCasePrestaShopParams>
      setParams(ListUseCasePrestaShopParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<PrestaShopModel>, ListUseCasePrestaShopParams>
      setParamsFromMap(Map params) {
    parameters = ListUseCasePrestaShopParams.fromMap(params);
    return this;
  }
}

class ListUseCasePrestaShopParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCasePrestaShopParams({
    this.start = -1,
    this.limit = -1,
    this.getAll = false,
  }) : super() {
    if (start == -1 || limit == -1) getAll = true;
  }

  factory ListUseCasePrestaShopParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCasePrestaShopParams(
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
