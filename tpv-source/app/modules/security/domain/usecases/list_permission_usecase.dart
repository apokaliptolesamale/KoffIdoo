// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

class ListPermissionUseCase<ListPermissionModel>
    implements UseCase<ListPermissionModel, UseCaseListPermissionParams> {
  final RbacRepository<ListPermissionModel> repository;
  late UseCaseListPermissionParams? parameters;

  ListPermissionUseCase(this.repository);

  @override
  Future<Either<Failure, ListPermissionModel>> call(
    UseCaseListPermissionParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.listPermissions((params ?? parameters)!.id);
  }

  @override
  UseCaseListPermissionParams? getParams() {
    return parameters = parameters ?? UseCaseListPermissionParams(id: 0);
  }

  @override
  UseCase<ListPermissionModel, UseCaseListPermissionParams> setParams(
      UseCaseListPermissionParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<ListPermissionModel, UseCaseListPermissionParams> setParamsFromMap(
      Map params) {
    parameters = UseCaseListPermissionParams.fromMap(params);
    return this;
  }
}

UseCaseListPermissionParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseListPermissionParams.fromMap(params);

class UseCaseListPermissionParams extends Parametizable {
  final int id;
  UseCaseListPermissionParams({
    required this.id,
  }) : super();

  @override
  bool isValid() {
    return true;
  }

  factory UseCaseListPermissionParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseListPermissionParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
