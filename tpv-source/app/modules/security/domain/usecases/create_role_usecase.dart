// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

class CreateRoleUseCase<CreateRoleModel>
    implements UseCase<CreateRoleModel, UseCaseCreateRoleParams> {
  final RbacRepository<CreateRoleModel> repository;
  late UseCaseCreateRoleParams? parameters;

  CreateRoleUseCase(this.repository);

  @override
  Future<Either<Failure, CreateRoleModel>> call(
    UseCaseCreateRoleParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.createRole((params ?? parameters)!.id);
  }

  @override
  UseCaseCreateRoleParams? getParams() {
    return parameters = parameters ?? UseCaseCreateRoleParams(id: 0);
  }

  @override
  UseCase<CreateRoleModel, UseCaseCreateRoleParams> setParams(
      UseCaseCreateRoleParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<CreateRoleModel, UseCaseCreateRoleParams> setParamsFromMap(
      Map params) {
    parameters = UseCaseCreateRoleParams.fromMap(params);
    return this;
  }
}

UseCaseCreateRoleParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseCreateRoleParams.fromMap(params);

class UseCaseCreateRoleParams extends Parametizable {
  final int id;
  UseCaseCreateRoleParams({
    required this.id,
  }) : super();

  @override
  bool isValid() {
    return true;
  }

  factory UseCaseCreateRoleParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseCreateRoleParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
