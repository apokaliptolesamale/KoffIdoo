// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/models/status_model.dart';
import '../repository/status_repository.dart';

DeleteUseCaseStatusParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseStatusParams.fromMap(params);

class DeleteStatusUseCase<StatusModelEntity extends StatusModel>
    implements UseCase<StatusModelEntity, DeleteUseCaseStatusParams> {
  final StatusRepository<StatusModelEntity> repository;

  late DeleteUseCaseStatusParams? parameters;

  DeleteStatusUseCase(this.repository);

  @override
  Future<Either<Failure, StatusModelEntity>> call(
    DeleteUseCaseStatusParams? params,
  ) async {
    return await repository.delete((parameters = params)!.id);
  }

  @override
  DeleteUseCaseStatusParams? getParams() {
    return parameters = parameters ?? DeleteUseCaseStatusParams(id: 0);
  }

  @override
  UseCase<StatusModelEntity, DeleteUseCaseStatusParams> setParams(
      DeleteUseCaseStatusParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<StatusModelEntity, DeleteUseCaseStatusParams> setParamsFromMap(
      Map params) {
    parameters = DeleteUseCaseStatusParams.fromMap(params);
    return this;
  }
}

class DeleteUseCaseStatusParams extends Parametizable {
  final int id;
  DeleteUseCaseStatusParams({required this.id}) : super();

  factory DeleteUseCaseStatusParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCaseStatusParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
