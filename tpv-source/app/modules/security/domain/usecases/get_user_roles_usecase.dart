// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

class GetUserRolesUseCase<GetUserRolesModel>
    implements UseCase<GetUserRolesModel, UseCaseGetUserRolesParams> {
  final RbacRepository<GetUserRolesModel> repository;
  late UseCaseGetUserRolesParams? parameters;

  GetUserRolesUseCase(this.repository);

  @override
  Future<Either<Failure, GetUserRolesModel>> call(
    UseCaseGetUserRolesParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.getUserRoles((params ?? parameters)!.id);
  }

  @override
  UseCaseGetUserRolesParams? getParams() {
    return parameters = parameters ?? UseCaseGetUserRolesParams(id: 0);
  }

  @override
  UseCase<GetUserRolesModel, UseCaseGetUserRolesParams> setParams(
      UseCaseGetUserRolesParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<GetUserRolesModel, UseCaseGetUserRolesParams> setParamsFromMap(
      Map params) {
    parameters = UseCaseGetUserRolesParams.fromMap(params);
    return this;
  }
}

UseCaseGetUserRolesParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseGetUserRolesParams.fromMap(params);

class UseCaseGetUserRolesParams extends Parametizable {
  final int id;
  UseCaseGetUserRolesParams({
    required this.id,
  }) : super();

  @override
  bool isValid() {
    return true;
  }

  factory UseCaseGetUserRolesParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseGetUserRolesParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
