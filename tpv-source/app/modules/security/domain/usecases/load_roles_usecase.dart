// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/rbac_repository.dart';

UseCaseLoadRolesParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    UseCaseLoadRolesParams.fromMap(params);

class LoadRolesUseCase<LoadRolesModel>
    implements UseCase<LoadRolesModel, UseCaseLoadRolesParams> {
  final RbacRepository<LoadRolesModel> repository;
  late UseCaseLoadRolesParams? parameters;

  LoadRolesUseCase(this.repository);

  @override
  Future<Either<Failure, LoadRolesModel>> call(
    UseCaseLoadRolesParams? params,
  ) async {
    return repository.loadRoles((params ?? parameters)!.path);
  }

  Future<Either<Failure, LoadRolesModel>> fromAsset(String fileAsset) {
    return call(UseCaseLoadRolesParams(
      path: fileAsset,
    ));
  }

  @override
  UseCaseLoadRolesParams? getParams() {
    return parameters = parameters ?? UseCaseLoadRolesParams(path: "");
  }

  @override
  UseCase<LoadRolesModel, UseCaseLoadRolesParams> setParams(
      UseCaseLoadRolesParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<LoadRolesModel, UseCaseLoadRolesParams> setParamsFromMap(Map params) {
    parameters = UseCaseLoadRolesParams.fromMap(params);
    return this;
  }
}

class UseCaseLoadRolesParams extends Parametizable {
  final String path;
  UseCaseLoadRolesParams({
    required this.path,
  }) : super();

  factory UseCaseLoadRolesParams.fromMap(Map<dynamic, dynamic> params) =>
      UseCaseLoadRolesParams(
          path: params.containsKey("path") ? params["path"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {
        "path": path,
      };
}
