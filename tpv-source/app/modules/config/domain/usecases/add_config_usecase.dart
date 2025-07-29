// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/config_repository.dart';

AddUseCaseConfigParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseConfigParams.fromMap(params);

class AddConfig<Config> implements UseCase<Config, AddUseCaseConfigParams> {
  final ConfigRepository<Config> repository;
  late AddUseCaseConfigParams? parameters;

  AddConfig(this.repository);

  @override
  Future<Either<Failure, Config>> call(
    AddUseCaseConfigParams? params,
  ) async {
    return await repository.add(parameters = params);
  }

  @override
  AddUseCaseConfigParams? getParams() {
    return parameters;
  }

  @override
  UseCase<Config, AddUseCaseConfigParams> setParams(
      AddUseCaseConfigParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<Config, AddUseCaseConfigParams> setParamsFromMap(Map params) {
    parameters = AddUseCaseConfigParams.fromMap(params);
    return this;
  }
}

class AddUseCaseConfigParams extends Parametizable {
  final int id;
  AddUseCaseConfigParams({required this.id}) : super();

  factory AddUseCaseConfigParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCaseConfigParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
