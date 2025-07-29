// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

class AddRolesToUsersUseCase<AddRolesToUsersModel>
    implements UseCase<AddRolesToUsersModel, UseCaseAddRolesToUsersParams> {
  final RbacRepository<AddRolesToUsersModel> repository;
  late UseCaseAddRolesToUsersParams? parameters;

  AddRolesToUsersUseCase(this.repository);

  @override
  Future<Either<Failure, AddRolesToUsersModel>> call(
    UseCaseAddRolesToUsersParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.addRolesToUsers((params ?? parameters)!.id);
  }

  @override
  UseCaseAddRolesToUsersParams? getParams() {
    return parameters = parameters ?? UseCaseAddRolesToUsersParams(id: 0);
  }

  @override
  UseCase<AddRolesToUsersModel, UseCaseAddRolesToUsersParams> setParams(
      UseCaseAddRolesToUsersParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<AddRolesToUsersModel, UseCaseAddRolesToUsersParams> setParamsFromMap(
      Map params) {
    parameters = UseCaseAddRolesToUsersParams.fromMap(params);
    return this;
  }
}

UseCaseAddRolesToUsersParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseAddRolesToUsersParams.fromMap(params);

class UseCaseAddRolesToUsersParams extends Parametizable {
  final int id;
  UseCaseAddRolesToUsersParams({
    required this.id,
  }) : super();

  @override
  bool isValid() {
    return true;
  }

  factory UseCaseAddRolesToUsersParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseAddRolesToUsersParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
