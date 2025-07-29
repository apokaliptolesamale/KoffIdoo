// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

UseCaseCreatePermissionParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseCreatePermissionParams.fromMap(params);

class CreatePermissionUseCase<CreatePermissionModel>
    implements UseCase<CreatePermissionModel, UseCaseCreatePermissionParams> {
  final RbacRepository<CreatePermissionModel> repository;
  late UseCaseCreatePermissionParams? parameters;

  CreatePermissionUseCase(this.repository);

  @override
  Future<Either<Failure, CreatePermissionModel>> call(
    UseCaseCreatePermissionParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.createPermissions((params ?? parameters)!.id);
  }

  @override
  UseCaseCreatePermissionParams? getParams() {
    return parameters = parameters ?? UseCaseCreatePermissionParams(id: 0);
  }

  @override
  UseCase<CreatePermissionModel, UseCaseCreatePermissionParams> setParams(
      UseCaseCreatePermissionParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<CreatePermissionModel, UseCaseCreatePermissionParams>
      setParamsFromMap(Map params) {
    parameters = UseCaseCreatePermissionParams.fromMap(params);
    return this;
  }
}

class UseCaseCreatePermissionParams extends Parametizable {
  final int id;
  UseCaseCreatePermissionParams({
    required this.id,
  }) : super();

  factory UseCaseCreatePermissionParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseCreatePermissionParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
