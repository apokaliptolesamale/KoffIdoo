// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/account_repository.dart';

class ListAccountUseCase<AccountModel> implements UseCase<EntityModelList<AccountModel>, ListUseCaseAccountParams> {
 
  final AccountRepository<AccountModel> repository;
  late ListUseCaseAccountParams? parameters;

  ListAccountUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<AccountModel>>> call(
    ListUseCaseAccountParams? params,
  ) async {
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<AccountModel>>> getAll() async {
    return await call(getParams());
  }

  @override
  ListUseCaseAccountParams? getParams() {
    return parameters=parameters ?? ListUseCaseAccountParams();
  }

  @override
  UseCase<EntityModelList<AccountModel>, ListUseCaseAccountParams> setParams(
      ListUseCaseAccountParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<AccountModel>, ListUseCaseAccountParams> setParamsFromMap(Map params) {
    parameters = ListUseCaseAccountParams.fromMap(params);
    return this;
  }
}

ListUseCaseAccountParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseAccountParams.fromMap(params);

class ListUseCaseAccountParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseAccountParams({
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

  factory ListUseCaseAccountParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseAccountParams(
        start: params.containsKey("start") ? params["start"] : 1,
        limit: params.containsKey("limit") ? params["limit"] : 50,
      );

  @override
  Map<String, dynamic> toJson() => {"start": start ?? 1, "limit": limit ?? 50};
}
