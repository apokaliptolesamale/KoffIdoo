// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

class SyncRoleUseCase<SyncRoleModel>
    implements UseCase<SyncRoleModel, UseCaseSyncRoleParams> {
  final RbacRepository<SyncRoleModel> repository;
  late UseCaseSyncRoleParams? parameters;

  SyncRoleUseCase(this.repository);

  @override
  Future<Either<Failure, SyncRoleModel>> call(
    UseCaseSyncRoleParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.syncRoles((params ?? parameters)!.id);
  }

  @override
  UseCaseSyncRoleParams? getParams() {
    return parameters = parameters ?? UseCaseSyncRoleParams(id: 0);
  }

  @override
  UseCase<SyncRoleModel, UseCaseSyncRoleParams> setParams(
      UseCaseSyncRoleParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<SyncRoleModel, UseCaseSyncRoleParams> setParamsFromMap(Map params) {
    parameters = UseCaseSyncRoleParams.fromMap(params);
    return this;
  }
}

UseCaseSyncRoleParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseSyncRoleParams.fromMap(params);

class UseCaseSyncRoleParams extends Parametizable {
  final int id;
  UseCaseSyncRoleParams({
    required this.id,
  }) : super();

  @override
  bool isValid() {
    return true;
  }

  factory UseCaseSyncRoleParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseSyncRoleParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
