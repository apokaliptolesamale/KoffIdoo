// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/status_repository.dart';

AddUseCaseStatusParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseStatusParams.fromMap(params);

class AddStatusUseCase<StatusModel>
    implements UseCase<StatusModel, AddUseCaseStatusParams> {
  final StatusRepository<StatusModel> repository;
  late AddUseCaseStatusParams? parameters;

  AddStatusUseCase(this.repository);

  @override
  Future<Either<Failure, StatusModel>> call(
    AddUseCaseStatusParams? params,
  ) async {
    return await repository.add(parameters = params);
  }

  @override
  AddUseCaseStatusParams? getParams() {
    return parameters = parameters ?? AddUseCaseStatusParams(id: 0);
  }

  @override
  UseCase<StatusModel, AddUseCaseStatusParams> setParams(
      AddUseCaseStatusParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<StatusModel, AddUseCaseStatusParams> setParamsFromMap(Map params) {
    parameters = AddUseCaseStatusParams.fromMap(params);
    return this;
  }
}

class AddUseCaseStatusParams extends Parametizable {
  final int id;
  AddUseCaseStatusParams({required this.id}) : super();

  factory AddUseCaseStatusParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCaseStatusParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
