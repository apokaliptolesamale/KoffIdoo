// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

class DeleteRoleUseCase<DeleteRoleModel>
    implements UseCase<DeleteRoleModel, UseCaseDeleteRoleParams> {
  final RbacRepository<DeleteRoleModel> repository;
  late UseCaseDeleteRoleParams? parameters;

  DeleteRoleUseCase(this.repository);

  @override
  Future<Either<Failure, DeleteRoleModel>> call(
    UseCaseDeleteRoleParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.deleteRoles((params ?? parameters)!.id);
  }

  @override
  UseCaseDeleteRoleParams? getParams() {
    return parameters = parameters ?? UseCaseDeleteRoleParams(id: 0);
  }

  @override
  UseCase<DeleteRoleModel, UseCaseDeleteRoleParams> setParams(
      UseCaseDeleteRoleParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<DeleteRoleModel, UseCaseDeleteRoleParams> setParamsFromMap(
      Map params) {
    parameters = UseCaseDeleteRoleParams.fromMap(params);
    return this;
  }
}

UseCaseDeleteRoleParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseDeleteRoleParams.fromMap(params);

class UseCaseDeleteRoleParams extends Parametizable {
  final int id;
  UseCaseDeleteRoleParams({
    required this.id,
  }) : super();

  @override
  bool isValid() {
    return true;
  }

  factory UseCaseDeleteRoleParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseDeleteRoleParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
