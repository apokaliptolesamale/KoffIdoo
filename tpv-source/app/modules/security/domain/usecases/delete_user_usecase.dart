// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

class DeleteUserUseCase<DeleteUserModel>
    implements UseCase<DeleteUserModel, UseCaseDeleteUserParams> {
  final RbacRepository<DeleteUserModel> repository;
  late UseCaseDeleteUserParams? parameters;

  DeleteUserUseCase(this.repository);

  @override
  Future<Either<Failure, DeleteUserModel>> call(
    UseCaseDeleteUserParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.deleteUsers((params ?? parameters)!.id);
  }

  @override
  UseCaseDeleteUserParams? getParams() {
    return parameters = parameters ?? UseCaseDeleteUserParams(id: 0);
  }

  @override
  UseCase<DeleteUserModel, UseCaseDeleteUserParams> setParams(
      UseCaseDeleteUserParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<DeleteUserModel, UseCaseDeleteUserParams> setParamsFromMap(
      Map params) {
    parameters = UseCaseDeleteUserParams.fromMap(params);
    return this;
  }
}

UseCaseDeleteUserParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseDeleteUserParams.fromMap(params);

class UseCaseDeleteUserParams extends Parametizable {
  final int id;
  UseCaseDeleteUserParams({
    required this.id,
  }) : super();

  @override
  bool isValid() {
    return true;
  }

  factory UseCaseDeleteUserParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseDeleteUserParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
