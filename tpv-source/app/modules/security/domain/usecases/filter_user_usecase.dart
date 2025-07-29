// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

class FilterUserUseCase<FilterUserModel>
    implements UseCase<FilterUserModel, UseCaseFilterUserParams> {
  final RbacRepository<FilterUserModel> repository;
  late UseCaseFilterUserParams? parameters;

  FilterUserUseCase(this.repository);

  @override
  Future<Either<Failure, FilterUserModel>> call(
    UseCaseFilterUserParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.filterUsers((params ?? parameters)!.id);
  }

  @override
  UseCaseFilterUserParams? getParams() {
    return parameters = parameters ?? UseCaseFilterUserParams(id: 0);
  }

  @override
  UseCase<FilterUserModel, UseCaseFilterUserParams> setParams(
      UseCaseFilterUserParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<FilterUserModel, UseCaseFilterUserParams> setParamsFromMap(
      Map params) {
    parameters = UseCaseFilterUserParams.fromMap(params);
    return this;
  }
}

UseCaseFilterUserParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseFilterUserParams.fromMap(params);

class UseCaseFilterUserParams extends Parametizable {
  final int id;
  UseCaseFilterUserParams({
    required this.id,
  }) : super();

  @override
  bool isValid() {
    return true;
  }

  factory UseCaseFilterUserParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseFilterUserParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
