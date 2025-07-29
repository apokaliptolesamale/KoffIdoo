// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/status_model.dart';
import '../repository/status_repository.dart';

class UpdateStatusUseCase<StatusModelEntity extends StatusModel>
    implements UseCase<StatusModelEntity, UpdateUseCaseStatusParams> {
  final StatusRepository<StatusModelEntity> repository;
  late UpdateUseCaseStatusParams? parameters;
  UpdateStatusUseCase(this.repository);

  @override
  Future<Either<Failure, StatusModelEntity>> call(
    UpdateUseCaseStatusParams? params,
  ) async {
    return await repository.update((parameters = params)!.id, params!.entity);
  }

  @override
  UpdateUseCaseStatusParams? getParams() {
    return parameters = parameters ??
        UpdateUseCaseStatusParams(
            id: 0,
            entity: StatusModel(
              id: "0",
              denominacion: "",
              descripcion: "",
            ));
  }

  @override
  UseCase<StatusModelEntity, UpdateUseCaseStatusParams> setParams(
      UpdateUseCaseStatusParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<StatusModelEntity, UpdateUseCaseStatusParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class UpdateUseCaseStatusParams extends Parametizable {
  final dynamic id;
  final StatusModel entity;
  UpdateUseCaseStatusParams({required this.id, required this.entity}) : super();
}
