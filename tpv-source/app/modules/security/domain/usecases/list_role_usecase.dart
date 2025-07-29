// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

class ListRoleUseCase<ListRoleModel>
    implements UseCase<ListRoleModel, UseCaseListRoleParams> {
  final RbacRepository<ListRoleModel> repository;
  late UseCaseListRoleParams? parameters;

  ListRoleUseCase(this.repository);

  @override
  Future<Either<Failure, ListRoleModel>> call(
    UseCaseListRoleParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.listRoles((params ?? parameters)!.id);
  }

  @override
  UseCaseListRoleParams? getParams() {
    return parameters = parameters ?? UseCaseListRoleParams(id: 0);
  }

  @override
  UseCase<ListRoleModel, UseCaseListRoleParams> setParams(
      UseCaseListRoleParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<ListRoleModel, UseCaseListRoleParams> setParamsFromMap(Map params) {
    parameters = UseCaseListRoleParams.fromMap(params);
    return this;
  }
}

UseCaseListRoleParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseListRoleParams.fromMap(params);

class UseCaseListRoleParams extends Parametizable {
  final int id;
  UseCaseListRoleParams({
    required this.id,
  }) : super();

  @override
  bool isValid() {
    return true;
  }

  factory UseCaseListRoleParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseListRoleParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
