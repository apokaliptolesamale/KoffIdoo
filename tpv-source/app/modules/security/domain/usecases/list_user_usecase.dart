// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

class ListUserUseCase<ListUserModel>
    implements UseCase<ListUserModel, UseCaseListUserParams> {
  final RbacRepository<ListUserModel> repository;
  late UseCaseListUserParams? parameters;

  ListUserUseCase(this.repository);

  @override
  Future<Either<Failure, ListUserModel>> call(
    UseCaseListUserParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.listUsers((params ?? parameters)!.id);
  }

  @override
  UseCaseListUserParams? getParams() {
    return parameters = parameters ?? UseCaseListUserParams(id: 0);
  }

  @override
  UseCase<ListUserModel, UseCaseListUserParams> setParams(
      UseCaseListUserParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<ListUserModel, UseCaseListUserParams> setParamsFromMap(Map params) {
    parameters = UseCaseListUserParams.fromMap(params);
    return this;
  }
}

UseCaseListUserParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseListUserParams.fromMap(params);

class UseCaseListUserParams extends Parametizable {
  final int id;
  UseCaseListUserParams({
    required this.id,
  }) : super();

  @override
  bool isValid() {
    return true;
  }

  factory UseCaseListUserParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseListUserParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
