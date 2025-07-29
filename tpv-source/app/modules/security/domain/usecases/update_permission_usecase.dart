// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

class UpdatePermissionUseCase<UpdatePermissionModel>
    implements UseCase<UpdatePermissionModel, UseCaseUpdatePermissionParams> {
  final RbacRepository<UpdatePermissionModel> repository;
  late UseCaseUpdatePermissionParams? parameters;

  UpdatePermissionUseCase(this.repository);

  @override
  Future<Either<Failure, UpdatePermissionModel>> call(
    UseCaseUpdatePermissionParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.updatePermission((params ?? parameters)!.id);
  }

  @override
  UseCaseUpdatePermissionParams? getParams() {
    return parameters = parameters ?? UseCaseUpdatePermissionParams(id: 0);
  }

  @override
  UseCase<UpdatePermissionModel, UseCaseUpdatePermissionParams> setParams(
      UseCaseUpdatePermissionParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<UpdatePermissionModel, UseCaseUpdatePermissionParams>
      setParamsFromMap(Map params) {
    parameters = UseCaseUpdatePermissionParams.fromMap(params);
    return this;
  }
}

UseCaseUpdatePermissionParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseUpdatePermissionParams.fromMap(params);

class UseCaseUpdatePermissionParams extends Parametizable {
  final int id;
  UseCaseUpdatePermissionParams({
    required this.id,
  }) : super();

  @override
  bool isValid() {
    return true;
  }

  factory UseCaseUpdatePermissionParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseUpdatePermissionParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
