// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

UseCaseFilterPermissionParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseFilterPermissionParams.fromMap(params);

class FilterPermissionUseCase<FilterPermissionModel>
    implements UseCase<FilterPermissionModel, UseCaseFilterPermissionParams> {
  final RbacRepository<FilterPermissionModel> repository;
  late UseCaseFilterPermissionParams? parameters;

  FilterPermissionUseCase(this.repository);

  @override
  Future<Either<Failure, FilterPermissionModel>> call(
    UseCaseFilterPermissionParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.filterPermission((params ?? parameters)!.id);
  }

  @override
  UseCaseFilterPermissionParams? getParams() {
    return parameters = parameters ?? UseCaseFilterPermissionParams(id: 0);
  }

  @override
  UseCase<FilterPermissionModel, UseCaseFilterPermissionParams> setParams(
      UseCaseFilterPermissionParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<FilterPermissionModel, UseCaseFilterPermissionParams>
      setParamsFromMap(Map params) {
    parameters = UseCaseFilterPermissionParams.fromMap(params);
    return this;
  }
}

class UseCaseFilterPermissionParams extends Parametizable {
  final int id;
  UseCaseFilterPermissionParams({
    required this.id,
  }) : super();

  factory UseCaseFilterPermissionParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseFilterPermissionParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
