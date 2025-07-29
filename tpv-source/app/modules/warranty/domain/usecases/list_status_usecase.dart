// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/status_repository.dart';

ListUseCaseStatusParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseStatusParams.fromMap(params);

class ListStatusUseCase<StatusModel>
    implements UseCase<EntityModelList<StatusModel>, ListUseCaseStatusParams> {
  final StatusRepository<StatusModel> repository;
  late ListUseCaseStatusParams? parameters;

  ListStatusUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<StatusModel>>> call(
    ListUseCaseStatusParams? params,
  ) async {
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<StatusModel>>> getAll() async {
    return await call(getParams());
  }

  @override
  ListUseCaseStatusParams? getParams() {
    return parameters = parameters ?? ListUseCaseStatusParams();
  }

  @override
  UseCase<EntityModelList<StatusModel>, ListUseCaseStatusParams> setParams(
      ListUseCaseStatusParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<StatusModel>, ListUseCaseStatusParams>
      setParamsFromMap(Map params) {
    parameters = ListUseCaseStatusParams.fromMap(params);
    return this;
  }
}

class ListUseCaseStatusParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseStatusParams({
    this.start = -1,
    this.limit = -1,
    this.getAll = false,
  }) : super() {
    if (start == -1 || limit == -1) getAll = true;
  }

  factory ListUseCaseStatusParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseStatusParams(
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
