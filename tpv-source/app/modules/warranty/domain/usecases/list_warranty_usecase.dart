// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/warranty_repository.dart';

ListUseCaseWarrantyParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseWarrantyParams.fromMap(params);

class ListUseCaseWarrantyParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseWarrantyParams({
    this.start = -1,
    this.limit = -1,
    this.getAll = false,
  }) : super() {
    if (start == -1 || limit == -1) getAll = true;
  }

  factory ListUseCaseWarrantyParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseWarrantyParams(
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

class ListWarrantyUseCase<WarrantyModel>
    implements
        UseCase<EntityModelList<WarrantyModel>, ListUseCaseWarrantyParams> {
  final WarrantyRepository<WarrantyModel> repository;
  late ListUseCaseWarrantyParams? parameters;

  ListWarrantyUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<WarrantyModel>>> call(
    ListUseCaseWarrantyParams? params,
  ) async {
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<WarrantyModel>>> getAll() async {
    return await call(getParams());
  }

  @override
  ListUseCaseWarrantyParams? getParams() {
    return parameters = parameters ?? ListUseCaseWarrantyParams();
  }

  @override
  UseCase<EntityModelList<WarrantyModel>, ListUseCaseWarrantyParams> setParams(
      ListUseCaseWarrantyParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<WarrantyModel>, ListUseCaseWarrantyParams>
      setParamsFromMap(Map params) {
    parameters = ListUseCaseWarrantyParams.fromMap(params);
    return this;
  }
}
