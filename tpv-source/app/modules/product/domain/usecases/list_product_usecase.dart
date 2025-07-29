// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/product_repository.dart';

ListUseCaseProductParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseProductParams.fromMap(params);

class ListProductUseCase<ProductModel>
    implements
        UseCase<EntityModelList<ProductModel>, ListUseCaseProductParams> {
  final ProductRepository<ProductModel> repository;
  ListUseCaseProductParams? parameters;

  ListProductUseCase(this.repository) {
    parameters = ListUseCaseProductParams();
  }

  @override
  Future<Either<Failure, EntityModelList<ProductModel>>> call(
    ListUseCaseProductParams? params,
  ) async {
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<ProductModel>>> getAll() async {
    return await call(parameters = getParams());
  }

  @override
  ListUseCaseProductParams? getParams() {
    return parameters ?? ListUseCaseProductParams();
  }

  @override
  UseCase<EntityModelList<ProductModel>, ListUseCaseProductParams> setParams(
      ListUseCaseProductParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<ProductModel>, ListUseCaseProductParams>
      setParamsFromMap(Map params) {
    parameters = ListUseCaseProductParams.fromMap(params);
    return this;
  }
}

class ListUseCaseProductParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseProductParams({
    this.start = -1,
    this.limit = -1,
    this.getAll = false,
  }) : super() {
    if (start == -1 || limit == -1) getAll = true;
  }

  factory ListUseCaseProductParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseProductParams(
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
