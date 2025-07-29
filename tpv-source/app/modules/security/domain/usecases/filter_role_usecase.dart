// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

class FilterRoleUseCase<FilterRoleModel>
    implements UseCase<FilterRoleModel, UseCaseFilterRoleParams> {
  final RbacRepository<FilterRoleModel> repository;
  late UseCaseFilterRoleParams? parameters;

  FilterRoleUseCase(this.repository);

  @override
  Future<Either<Failure, FilterRoleModel>> call(
    UseCaseFilterRoleParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.filterRole((params ?? parameters)!.id);
  }

  @override
  UseCaseFilterRoleParams? getParams() {
    return parameters = parameters ?? UseCaseFilterRoleParams(id: 0);
  }

  @override
  UseCase<FilterRoleModel, UseCaseFilterRoleParams> setParams(
      UseCaseFilterRoleParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<FilterRoleModel, UseCaseFilterRoleParams> setParamsFromMap(
      Map params) {
    parameters = UseCaseFilterRoleParams.fromMap(params);
    return this;
  }
}

UseCaseFilterRoleParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseFilterRoleParams.fromMap(params);

class UseCaseFilterRoleParams extends Parametizable {
  final int id;
  UseCaseFilterRoleParams({
    required this.id,
  }) : super();

  @override
  bool isValid() {
    return true;
  }

  factory UseCaseFilterRoleParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseFilterRoleParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
