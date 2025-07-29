// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/config_repository.dart';

GetUseCaseConfigParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseConfigParams.fromMap(params);

class GetConfig<Config> implements UseCase<Config, GetUseCaseConfigParams> {
  final ConfigRepository<Config> repository;
  late GetUseCaseConfigParams? parameters;

  GetConfig(this.repository);

  @override
  Future<Either<Failure, Config>> call(
    GetUseCaseConfigParams? params,
  ) async {
    return await repository.getConfig((parameters = params)!.id);
  }

  @override
  GetUseCaseConfigParams? getParams() {
    return parameters;
  }

  @override
  UseCase<Config, GetUseCaseConfigParams> setParams(
      GetUseCaseConfigParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<Config, GetUseCaseConfigParams> setParamsFromMap(Map params) {
    parameters = GetUseCaseConfigParams.fromMap(params);
    return this;
  }
}

class GetUseCaseConfigParams extends Parametizable {
  final int id;
  GetUseCaseConfigParams({required this.id}) : super();

  factory GetUseCaseConfigParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseConfigParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
