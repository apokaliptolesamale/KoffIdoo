// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/bank_repository.dart';


class ListBankUseCase<BankModel>
    implements UseCase<EntityModelList<BankModel>,ListUseCaseBankParams> {
  final BankRepository<BankModel> repository;
  ListUseCaseBankParams? parameters;

  ListBankUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<BankModel>>> call(
    ListUseCaseBankParams? params,
  ) async {
    parameters = params;
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<BankModel>>> getAll() async {
    return call(getParams());
  }

  @override
  ListUseCaseBankParams? getParams() {
    return parameters ;
  }

  @override
  UseCase<EntityModelList<BankModel>, ListUseCaseBankParams> setParams(
      ListUseCaseBankParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<BankModel>, ListUseCaseBankParams> setParamsFromMap(
      Map params) {
    parameters = ListUseCaseBankParams.fromMap(params);
    return this;
  }
}

ListUseCaseBankParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseBankParams.fromMap(params);

class ListUseCaseBankParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseBankParams({
    this.start = -1,
    this.limit = -1,
    this.getAll = false,
  }) : super() {
    if (start == -1 || limit == -1) getAll = true;
  }

  @override
  bool isValid() {
    return start! > 0 && start! < limit!;
  }

  factory ListUseCaseBankParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseBankParams(
        start: params.containsKey("start") ? params["start"] : 1,
        limit: params.containsKey("limit") ? params["limit"] : 50,
      );

  @override
  Map<String, dynamic> toJson() => {"start": start ?? 1, "limit": limit ?? 50};
}
