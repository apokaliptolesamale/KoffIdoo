// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../repository/operation_repository.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

class GetOperationUseCase<OperationModel>
    implements UseCase<EntityModelList<OperationModel>, ListUseCaseCardParams> {
  final OperationRepository<OperationModel> repository;
  late ListUseCaseCardParams? parameters;

  GetOperationUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<OperationModel>>> call(
    ListUseCaseCardParams? params,
  ) async {
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<OperationModel>>> getAll() async {
    return await call(getParams());
  }

  @override
  ListUseCaseCardParams? getParams() {
    return parameters = parameters ?? ListUseCaseCardParams();
  }

  @override
  UseCase<EntityModelList<OperationModel>, ListUseCaseCardParams> setParams(
      ListUseCaseCardParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<OperationModel>, ListUseCaseCardParams>
      setParamsFromMap(Map params) {
    parameters = ListUseCaseCardParams.fromMap(params);
    return this;
  }
}

ListUseCaseCardParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseCardParams.fromMap(params);

class ListUseCaseCardParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseCardParams({
    this.start = -1,
    this.limit = -1,
    this.getAll = false,
  }) : super() {
    if (start == -1 || limit == -1) getAll = true;
  }

  @override
  bool isValid() {
    return start! > 0 && start! < limit!;
  }

  factory ListUseCaseCardParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseCardParams(
        start: params.containsKey("start") ? params["start"] : 1,
        limit: params.containsKey("limit") ? params["limit"] : 50,
      );

  @override
  Map<String, dynamic> toJson() => {"start": start ?? 1, "limit": limit ?? 50};
}
