// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/config_repository.dart';

GetByFieldUseCaseConfigParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetByFieldUseCaseConfigParams.fromMap(params);

class GetByFieldConfig<Config>
    implements UseCase<EntityModelList<Config>, GetByFieldUseCaseConfigParams> {
  final ConfigRepository<Config> repository;
  late GetByFieldUseCaseConfigParams? parameters;

  GetByFieldConfig(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Config>>> call(
    GetByFieldUseCaseConfigParams? params,
  ) async {
    return await repository.getBy((parameters = params)!.filters);
  }

  @override
  GetByFieldUseCaseConfigParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Config>, GetByFieldUseCaseConfigParams> setParams(
      GetByFieldUseCaseConfigParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Config>, GetByFieldUseCaseConfigParams>
      setParamsFromMap(Map params) {
    parameters = GetByFieldUseCaseConfigParams.fromMap(params);
    return this;
  }
}

class GetByFieldUseCaseConfigParams extends Parametizable {
  final Map filters;

  GetByFieldUseCaseConfigParams({required this.filters}) : super();

  factory GetByFieldUseCaseConfigParams.fromMap(Map<dynamic, dynamic> params) =>
      GetByFieldUseCaseConfigParams(filters: params);

  @override
  bool isValid() {
    //is valid only if all key of filters is presents on entity or model mapped.
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"filters": filters};
}
