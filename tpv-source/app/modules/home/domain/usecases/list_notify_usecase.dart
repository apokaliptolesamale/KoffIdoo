// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/notify_repository.dart';

ListUseCaseNotifyParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseNotifyParams.fromMap(params);

class ListNotifyUseCase<NotifyModel>
    implements UseCase<EntityModelList<NotifyModel>, ListUseCaseNotifyParams> {
  final NotifyRepository<NotifyModel> repository;
  late ListUseCaseNotifyParams? parameters;

  ListNotifyUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<NotifyModel>>> call(
    ListUseCaseNotifyParams? params,
  ) async {
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<NotifyModel>>> getAll() async {
    return await call(getParams());
  }

  @override
  ListUseCaseNotifyParams? getParams() {
    return parameters = parameters ?? ListUseCaseNotifyParams();
  }

  @override
  UseCase<EntityModelList<NotifyModel>, ListUseCaseNotifyParams> setParams(
      ListUseCaseNotifyParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<NotifyModel>, ListUseCaseNotifyParams>
      setParamsFromMap(Map params) {
    parameters = ListUseCaseNotifyParams.fromMap(params);
    return this;
  }
}

class ListUseCaseNotifyParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseNotifyParams({
    this.start = -1,
    this.limit = -1,
    this.getAll = false,
  }) : super() {
    if (start == -1 || limit == -1) getAll = true;
  }

  factory ListUseCaseNotifyParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseNotifyParams(
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
