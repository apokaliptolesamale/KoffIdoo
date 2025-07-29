// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

class CreateUserUseCase<CreateUserModel>
    implements UseCase<CreateUserModel, UseCaseCreateUserParams> {
  final RbacRepository<CreateUserModel> repository;
  late UseCaseCreateUserParams? parameters;

  CreateUserUseCase(this.repository);

  @override
  Future<Either<Failure, CreateUserModel>> call(
    UseCaseCreateUserParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.createUser((params ?? parameters)!.id);
  }

  @override
  UseCaseCreateUserParams? getParams() {
    return parameters = parameters ?? UseCaseCreateUserParams(id: 0);
  }

  @override
  UseCase<CreateUserModel, UseCaseCreateUserParams> setParams(
      UseCaseCreateUserParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<CreateUserModel, UseCaseCreateUserParams> setParamsFromMap(
      Map params) {
    parameters = UseCaseCreateUserParams.fromMap(params);
    return this;
  }
}

UseCaseCreateUserParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseCreateUserParams.fromMap(params);

class UseCaseCreateUserParams extends Parametizable {
  final int id;
  UseCaseCreateUserParams({
    required this.id,
  }) : super();

  @override
  bool isValid() {
    return true;
  }

  factory UseCaseCreateUserParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseCreateUserParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
