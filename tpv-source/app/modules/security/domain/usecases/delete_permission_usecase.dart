// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

class DeletePermissionUseCase<DeletePermissionModel>
    implements UseCase<DeletePermissionModel, UseCaseDeletePermissionParams> {
  final RbacRepository<DeletePermissionModel> repository;
  late UseCaseDeletePermissionParams? parameters;

  DeletePermissionUseCase(this.repository);

  @override
  Future<Either<Failure, DeletePermissionModel>> call(
    UseCaseDeletePermissionParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.deletePermissions((params ?? parameters)!.id);
  }

  @override
  UseCaseDeletePermissionParams? getParams() {
    return parameters = parameters ?? UseCaseDeletePermissionParams(id: 0);
  }

  @override
  UseCase<DeletePermissionModel, UseCaseDeletePermissionParams> setParams(
      UseCaseDeletePermissionParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<DeletePermissionModel, UseCaseDeletePermissionParams>
      setParamsFromMap(Map params) {
    parameters = UseCaseDeletePermissionParams.fromMap(params);
    return this;
  }
}

UseCaseDeletePermissionParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseDeletePermissionParams.fromMap(params);

class UseCaseDeletePermissionParams extends Parametizable {
  final int id;
  UseCaseDeletePermissionParams({
    required this.id,
  }) : super();

  @override
  bool isValid() {
    return true;
  }

  factory UseCaseDeletePermissionParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseDeletePermissionParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
