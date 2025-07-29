// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/order_detail_repository.dart';

ListUseCaseOrderDetailParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseOrderDetailParams.fromMap(params);

class ListOrderDetailUseCase<OrderDetailModel>
    implements
        UseCase<EntityModelList<OrderDetailModel>,
            ListUseCaseOrderDetailParams> {
  final OrderDetailRepository<OrderDetailModel> repository;
  late ListUseCaseOrderDetailParams? parameters;

  ListOrderDetailUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<OrderDetailModel>>> call(
    ListUseCaseOrderDetailParams? params,
  ) async {
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<OrderDetailModel>>> getAll() async {
    return await call(getParams());
  }

  @override
  ListUseCaseOrderDetailParams? getParams() {
    return parameters = parameters ?? ListUseCaseOrderDetailParams();
  }

  @override
  UseCase<EntityModelList<OrderDetailModel>, ListUseCaseOrderDetailParams>
      setParams(ListUseCaseOrderDetailParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<OrderDetailModel>, ListUseCaseOrderDetailParams>
      setParamsFromMap(Map params) {
    parameters = ListUseCaseOrderDetailParams.fromMap(params);
    return this;
  }
}

class ListUseCaseOrderDetailParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseOrderDetailParams({
    this.start = -1,
    this.limit = -1,
    this.getAll = false,
  }) : super() {
    if (start == -1 || limit == -1) getAll = true;
  }

  factory ListUseCaseOrderDetailParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseOrderDetailParams(
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
