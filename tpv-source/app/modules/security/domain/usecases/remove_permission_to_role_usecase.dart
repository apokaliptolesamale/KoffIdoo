// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

class RemovePermissionToRoleUseCase<RemovePermissionToRoleModel>
    implements
        UseCase<RemovePermissionToRoleModel,
            UseCaseRemovePermissionToRoleParams> {
  final RbacRepository<RemovePermissionToRoleModel> repository;
  late UseCaseRemovePermissionToRoleParams? parameters;

  RemovePermissionToRoleUseCase(this.repository);

  @override
  Future<Either<Failure, RemovePermissionToRoleModel>> call(
    UseCaseRemovePermissionToRoleParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.removePermissionsOnRole((params ?? parameters)!.id);
  }

  @override
  UseCaseRemovePermissionToRoleParams? getParams() {
    return parameters =
        parameters ?? UseCaseRemovePermissionToRoleParams(id: 0);
  }

  @override
  UseCase<RemovePermissionToRoleModel, UseCaseRemovePermissionToRoleParams>
      setParams(UseCaseRemovePermissionToRoleParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<RemovePermissionToRoleModel, UseCaseRemovePermissionToRoleParams>
      setParamsFromMap(Map params) {
    parameters = UseCaseRemovePermissionToRoleParams.fromMap(params);
    return this;
  }
}

UseCaseRemovePermissionToRoleParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseRemovePermissionToRoleParams.fromMap(params);

class UseCaseRemovePermissionToRoleParams extends Parametizable {
  final int id;
  UseCaseRemovePermissionToRoleParams({
    required this.id,
  }) : super();

  @override
  bool isValid() {
    return true;
  }

  factory UseCaseRemovePermissionToRoleParams.fromMap(
          Map<dynamic, dynamic> params) =>
      UseCaseRemovePermissionToRoleParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
