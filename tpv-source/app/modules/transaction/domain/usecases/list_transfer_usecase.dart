// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/transfer_repository.dart';

class ListTransferUseCase<TransferModel> implements UseCase<EntityModelList<TransferModel>, ListUseCaseTransferParams> {
 
  final TransferRepository<TransferModel> repository;
  late ListUseCaseTransferParams? parameters;

  ListTransferUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<TransferModel>>> call(
    ListUseCaseTransferParams? params,
  ) async {
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<TransferModel>>> getAll() async {
    return await call(getParams());
  }

  @override
  ListUseCaseTransferParams? getParams() {
    return parameters=parameters ?? ListUseCaseTransferParams();
  }

  @override
  UseCase<EntityModelList<TransferModel>, ListUseCaseTransferParams> setParams(
      ListUseCaseTransferParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<TransferModel>, ListUseCaseTransferParams> setParamsFromMap(Map params) {
    parameters = ListUseCaseTransferParams.fromMap(params);
    return this;
  }
}

ListUseCaseTransferParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseTransferParams.fromMap(params);

class ListUseCaseTransferParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseTransferParams({
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

  factory ListUseCaseTransferParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseTransferParams(
        start: params.containsKey("start") ? params["start"] : 1,
        limit: params.containsKey("limit") ? params["limit"] : 50,
      );

  @override
  Map<String, dynamic> toJson() => {"start": start ?? 1, "limit": limit ?? 50};
}
