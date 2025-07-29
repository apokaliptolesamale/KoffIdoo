// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/orderhistory_repository.dart';

ListUseCaseOrderHistoryParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseOrderHistoryParams.fromMap(params);

class ListOrderHistoryUseCase<OrderHistoryModel>
    implements
        UseCase<EntityModelList<OrderHistoryModel>,
            ListUseCaseOrderHistoryParams> {
  final OrderHistoryRepository<OrderHistoryModel> repository;
  late ListUseCaseOrderHistoryParams? parameters;

  ListOrderHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<OrderHistoryModel>>> call(
    ListUseCaseOrderHistoryParams? params,
  ) async {
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<OrderHistoryModel>>> getAll() async {
    return await call(getParams());
  }

  @override
  ListUseCaseOrderHistoryParams? getParams() {
    return parameters = parameters ?? ListUseCaseOrderHistoryParams();
  }

  @override
  UseCase<EntityModelList<OrderHistoryModel>, ListUseCaseOrderHistoryParams>
      setParams(ListUseCaseOrderHistoryParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<OrderHistoryModel>, ListUseCaseOrderHistoryParams>
      setParamsFromMap(Map params) {
    parameters = ListUseCaseOrderHistoryParams.fromMap(params);
    return this;
  }
}

class ListUseCaseOrderHistoryParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseOrderHistoryParams({
    this.start = -1,
    this.limit = -1,
    this.getAll = false,
  }) : super() {
    if (start == -1 || limit == -1) getAll = true;
  }

  factory ListUseCaseOrderHistoryParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseOrderHistoryParams(
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
