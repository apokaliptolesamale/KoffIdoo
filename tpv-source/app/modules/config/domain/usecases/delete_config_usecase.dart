// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/config_repository.dart';

DeleteUseCaseConfigParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseConfigParams.fromMap(params);

class DeleteConfig<Config>
    implements UseCase<Config, DeleteUseCaseConfigParams> {
  final ConfigRepository<Config> repository;

  late DeleteUseCaseConfigParams? parameters;

  DeleteConfig(this.repository);

  @override
  Future<Either<Failure, Config>> call(
    DeleteUseCaseConfigParams? params,
  ) async {
    return await repository.delete((parameters = params)!.id);
  }

  @override
  DeleteUseCaseConfigParams? getParams() {
    return parameters;
  }

  @override
  UseCase<Config, DeleteUseCaseConfigParams> setParams(
      DeleteUseCaseConfigParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<Config, DeleteUseCaseConfigParams> setParamsFromMap(Map params) {
    parameters = DeleteUseCaseConfigParams.fromMap(params);
    return this;
  }
}

class DeleteUseCaseConfigParams extends Parametizable {
  final int id;
  DeleteUseCaseConfigParams({required this.id}) : super();

  factory DeleteUseCaseConfigParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCaseConfigParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
