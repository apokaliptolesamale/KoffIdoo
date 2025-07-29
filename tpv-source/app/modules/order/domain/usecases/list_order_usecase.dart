// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '/app/modules/order/domain/models/order_model.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../../order/domain/repository/order_repository.dart';

ListUseCaseOrderParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseOrderParams.fromMap(params);

class ListOrderUseCase<Model extends OrderModel>
    implements UseCase<EntityModelList<Model>, ListUseCaseOrderParams> {
  final OrderRepository<Model> repository;
  ListUseCaseOrderParams? parameters = ListUseCaseOrderParams();

  ListOrderUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Model>>> call(
    ListUseCaseOrderParams? params,
  ) async {
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<Model>>> getAll() => call(getParams());

  @override
  ListUseCaseOrderParams? getParams() {
    return parameters ?? setParams(ListUseCaseOrderParams()).getParams();
  }

  @override
  UseCase<EntityModelList<Model>, ListUseCaseOrderParams> setParams(
      ListUseCaseOrderParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Model>, ListUseCaseOrderParams> setParamsFromMap(
      Map params) {
    parameters = ListUseCaseOrderParams.fromMap(params);
    return this;
  }
}

class ListUseCaseOrderParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseOrderParams({
    this.start = -1,
    this.limit = -1,
    this.getAll = false,
  }) : super() {
    if (start == -1 || limit == -1) getAll = true;
  }

  factory ListUseCaseOrderParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseOrderParams(
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
