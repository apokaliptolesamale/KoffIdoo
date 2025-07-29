// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/idp_repository.dart';

class ListIdpUseCase<IdpModel> implements UseCase<EntityModelList<IdpModel>, ListUseCaseIdpParams> {
 
  final IdpRepository<IdpModel> repository;
  late ListUseCaseIdpParams? parameters;

  ListIdpUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<IdpModel>>> call(
    ListUseCaseIdpParams? params,
  ) async {
    return (params==null && parameters==null)?Left(NulleableFailure(
        message: "Ha ocurrido un error relacionado a los parámetros de la operación.")): await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<IdpModel>>> getAll() async {
    return await call(getParams());
  }

  @override
  ListUseCaseIdpParams? getParams() {
    return parameters=parameters ?? ListUseCaseIdpParams();
  }

  @override
  UseCase<EntityModelList<IdpModel>, ListUseCaseIdpParams> setParams(
      ListUseCaseIdpParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<IdpModel>, ListUseCaseIdpParams> setParamsFromMap(Map params) {
    parameters = ListUseCaseIdpParams.fromMap(params);
    return this;
  }
}

ListUseCaseIdpParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseIdpParams.fromMap(params);

class ListUseCaseIdpParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseIdpParams({
    this.start=-1,
    this.limit=-1,
    this.getAll=false,
  }) : super() {
    if(start==-1||limit==-1) getAll = true;
  }

  @override
  bool isValid() {
    return start! > 0 && start! < limit!;
  }

  factory ListUseCaseIdpParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseIdpParams(
        start: params.containsKey("start") ? params["start"] : 1,
        limit: params.containsKey("limit") ? params["limit"] : 50,
      );

  @override
  Map<String, dynamic> toJson() => {"start": start ?? 1, "limit": limit ?? 50};
}
