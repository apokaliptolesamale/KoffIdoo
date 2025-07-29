// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

UseCaseUpdateUserParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseUpdateUserParams.fromMap(params);

class UpdateUserUseCase<UpdateUserModel>
    implements UseCase<UpdateUserModel, UseCaseUpdateUserParams> {
  final RbacRepository<UpdateUserModel> repository;
  late UseCaseUpdateUserParams? parameters;

  UpdateUserUseCase(this.repository);

  @override
  Future<Either<Failure, UpdateUserModel>> call(
    UseCaseUpdateUserParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.updateUser((params ?? parameters)!.id);
  }

  @override
  UseCaseUpdateUserParams? getParams() {
    return parameters = parameters ?? UseCaseUpdateUserParams(id: 0);
  }

  @override
  UseCase<UpdateUserModel, UseCaseUpdateUserParams> setParams(
      UseCaseUpdateUserParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<UpdateUserModel, UseCaseUpdateUserParams> setParamsFromMap(
      Map params) {
    parameters = UseCaseUpdateUserParams.fromMap(params);
    return this;
  }
}

class UseCaseUpdateUserParams extends Parametizable {
  final int id;
  UseCaseUpdateUserParams({
    required this.id,
  }) : super();

  factory UseCaseUpdateUserParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseUpdateUserParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
