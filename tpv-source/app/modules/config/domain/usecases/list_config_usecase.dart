// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/config_repository.dart';

ListUseCaseConfigParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseConfigParams.fromMap(params);

class ListConfig<Config>
    implements UseCase<EntityModelList<Config>, ListUseCaseConfigParams> {
  final ConfigRepository<Config> repository;
  late ListUseCaseConfigParams? parameters;

  ListConfig(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Config>>> call(
    ListUseCaseConfigParams? params,
  ) async {
    return await repository.getAll();
  }

  @override
  ListUseCaseConfigParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Config>, ListUseCaseConfigParams> setParams(
      ListUseCaseConfigParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Config>, ListUseCaseConfigParams> setParamsFromMap(
      Map params) {
    parameters = ListUseCaseConfigParams.fromMap(params);
    return this;
  }
}

class ListUseCaseConfigParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseConfigParams({
    this.start = -1,
    this.limit = -1,
    this.getAll = false,
  }) : super() {
    if (start == -1 || limit == -1) getAll = true;
  }

  factory ListUseCaseConfigParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseConfigParams(
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
