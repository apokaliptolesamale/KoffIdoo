// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

UseCaseUpdateRoleParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseUpdateRoleParams.fromMap(params);

class UpdateRoleUseCase<UpdateRoleModel>
    implements UseCase<UpdateRoleModel, UseCaseUpdateRoleParams> {
  final RbacRepository<UpdateRoleModel> repository;
  late UseCaseUpdateRoleParams? parameters;

  UpdateRoleUseCase(this.repository);

  @override
  Future<Either<Failure, UpdateRoleModel>> call(
    UseCaseUpdateRoleParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.updateRole((params ?? parameters)!.id);
  }

  @override
  UseCaseUpdateRoleParams? getParams() {
    return parameters = parameters ?? UseCaseUpdateRoleParams(id: 0);
  }

  @override
  UseCase<UpdateRoleModel, UseCaseUpdateRoleParams> setParams(
      UseCaseUpdateRoleParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<UpdateRoleModel, UseCaseUpdateRoleParams> setParamsFromMap(
      Map params) {
    parameters = UseCaseUpdateRoleParams.fromMap(params);
    return this;
  }
}

class UseCaseUpdateRoleParams extends Parametizable {
  final int id;
  UseCaseUpdateRoleParams({
    required this.id,
  }) : super();

  factory UseCaseUpdateRoleParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseUpdateRoleParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
