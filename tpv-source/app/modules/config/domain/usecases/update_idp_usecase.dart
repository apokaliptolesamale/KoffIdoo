// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/idp_model.dart';
import '../repository/idp_repository.dart';

class UpdateIdpUseCase<IdpModelEntity extends IdpModel>
    implements UseCase<IdpModelEntity, UpdateUseCaseIdpParams> {
  final IdpRepository<IdpModelEntity> repository;
  late UpdateUseCaseIdpParams? parameters;
  UpdateIdpUseCase(this.repository);

  @override
  Future<Either<Failure, IdpModelEntity>> call(
    UpdateUseCaseIdpParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.update((params ?? parameters)!.id, params!.entity);
  }

  @override
  UpdateUseCaseIdpParams? getParams() {
    return parameters =
        parameters ?? UpdateUseCaseIdpParams(id: 0, entity: IdpModel());
  }

  @override
  UseCase<IdpModelEntity, UpdateUseCaseIdpParams> setParams(
      UpdateUseCaseIdpParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<IdpModelEntity, UpdateUseCaseIdpParams> setParamsFromMap(Map params) {
    return this;
  }
}

class UpdateUseCaseIdpParams extends Parametizable {
  final dynamic id;
  final IdpModel entity;
  UpdateUseCaseIdpParams({required this.id, required this.entity}) : super();
}
