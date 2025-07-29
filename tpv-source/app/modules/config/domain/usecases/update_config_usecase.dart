// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../entities/config.dart';
import '../repository/config_repository.dart';

class UpdateConfig<Config>
    implements UseCase<Config, UpdateUseCaseConfigParams> {
  final ConfigRepository<Config> repository;
  late UpdateUseCaseConfigParams? parameters;
  UpdateConfig(this.repository);

  @override
  Future<Either<Failure, Config>> call(
    UpdateUseCaseConfigParams? params,
  ) async {
    return await repository.update((parameters = params)!.id, params!.entity);
  }

  @override
  UpdateUseCaseConfigParams? getParams() {
    return parameters;
  }

  @override
  UseCase<Config, UpdateUseCaseConfigParams> setParams(
      UpdateUseCaseConfigParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<Config, UpdateUseCaseConfigParams> setParamsFromMap(Map params) {
    return this;
  }
}

class UpdateUseCaseConfigParams extends Parametizable {
  final int id;
  final Config entity;
  UpdateUseCaseConfigParams({required this.id, required this.entity}) : super();
}
