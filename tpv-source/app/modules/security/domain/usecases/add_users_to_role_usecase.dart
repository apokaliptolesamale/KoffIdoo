// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

UseCaseAddUsersToRoleParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseAddUsersToRoleParams.fromMap(params);

class AddUsersToRoleUseCase<AddUsersToRoleModel>
    implements UseCase<AddUsersToRoleModel, UseCaseAddUsersToRoleParams> {
  final RbacRepository<AddUsersToRoleModel> repository;
  late UseCaseAddUsersToRoleParams? parameters;

  AddUsersToRoleUseCase(this.repository);

  @override
  Future<Either<Failure, AddUsersToRoleModel>> call(
    UseCaseAddUsersToRoleParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.addUsersToRole((params ?? parameters)!.id);
  }

  @override
  UseCaseAddUsersToRoleParams? getParams() {
    return parameters = parameters ?? UseCaseAddUsersToRoleParams(id: 0);
  }

  @override
  UseCase<AddUsersToRoleModel, UseCaseAddUsersToRoleParams> setParams(
      UseCaseAddUsersToRoleParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<AddUsersToRoleModel, UseCaseAddUsersToRoleParams> setParamsFromMap(
      Map params) {
    parameters = UseCaseAddUsersToRoleParams.fromMap(params);
    return this;
  }
}

class UseCaseAddUsersToRoleParams extends Parametizable {
  final int id;
  UseCaseAddUsersToRoleParams({
    required this.id,
  }) : super();

  factory UseCaseAddUsersToRoleParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseAddUsersToRoleParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
