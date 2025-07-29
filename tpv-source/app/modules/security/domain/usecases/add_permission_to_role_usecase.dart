// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

class AddPermissionToRoleUseCase<AddPermissionToRoleModel>
    implements
        UseCase<AddPermissionToRoleModel, UseCaseAddPermissionToRoleParams> {
  final RbacRepository<AddPermissionToRoleModel> repository;
  late UseCaseAddPermissionToRoleParams? parameters;

  AddPermissionToRoleUseCase(this.repository);

  @override
  Future<Either<Failure, AddPermissionToRoleModel>> call(
    UseCaseAddPermissionToRoleParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.addPermissionsToRole((params ?? parameters)!.id);
  }

  @override
  UseCaseAddPermissionToRoleParams? getParams() {
    return parameters = parameters ?? UseCaseAddPermissionToRoleParams(id: 0);
  }

  @override
  UseCase<AddPermissionToRoleModel, UseCaseAddPermissionToRoleParams> setParams(
      UseCaseAddPermissionToRoleParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<AddPermissionToRoleModel, UseCaseAddPermissionToRoleParams>
      setParamsFromMap(Map params) {
    parameters = UseCaseAddPermissionToRoleParams.fromMap(params);
    return this;
  }
}

UseCaseAddPermissionToRoleParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseAddPermissionToRoleParams.fromMap(params);

class UseCaseAddPermissionToRoleParams extends Parametizable {
  final int id;
  UseCaseAddPermissionToRoleParams({
    required this.id,
  }) : super();

  @override
  bool isValid() {
    return true;
  }

  factory UseCaseAddPermissionToRoleParams.fromMap(
          Map<dynamic, dynamic> params) =>
      UseCaseAddPermissionToRoleParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
