// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/status_repository.dart';

GetUseCaseStatusParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseStatusParams.fromMap(params);

class GetStatusUseCase<StatusModel>
    implements UseCase<StatusModel, GetUseCaseStatusParams> {
  final StatusRepository<StatusModel> repository;
  late GetUseCaseStatusParams? parameters;

  GetStatusUseCase(this.repository);

  @override
  Future<Either<Failure, StatusModel>> call(
    GetUseCaseStatusParams? params,
  ) async {
    return await repository.getStatus((parameters = params)!.id);
  }

  @override
  GetUseCaseStatusParams? getParams() {
    return parameters = parameters ?? GetUseCaseStatusParams(id: 0);
  }

  @override
  UseCase<StatusModel, GetUseCaseStatusParams> setParams(
      GetUseCaseStatusParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<StatusModel, GetUseCaseStatusParams> setParamsFromMap(Map params) {
    parameters = GetUseCaseStatusParams.fromMap(params);
    return this;
  }
}

class GetUseCaseStatusParams extends Parametizable {
  final int id;
  GetUseCaseStatusParams({required this.id}) : super();

  factory GetUseCaseStatusParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseStatusParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
