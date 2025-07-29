// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/transfer_model.dart';
import '../repository/transfer_repository.dart';

DeleteUseCaseTransferParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseTransferParams.fromMap(params);

class DeleteTransferUseCase<TransferModelEntity extends TransferModel>
    implements UseCase<TransferModelEntity, DeleteUseCaseTransferParams> {
  final TransferRepository<TransferModelEntity> repository;

  late DeleteUseCaseTransferParams? parameters;

  DeleteTransferUseCase(this.repository);

  @override
  Future<Either<Failure, TransferModelEntity>> call(
    DeleteUseCaseTransferParams? params,
  ) async {
    return await repository.delete((parameters = params)!.id);
  }

  @override
  DeleteUseCaseTransferParams? getParams() {
    return parameters = parameters ?? DeleteUseCaseTransferParams(id: 0);
  }

  @override
  UseCase<TransferModelEntity, DeleteUseCaseTransferParams> setParams(
      DeleteUseCaseTransferParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<TransferModelEntity, DeleteUseCaseTransferParams> setParamsFromMap(
      Map params) {
    parameters = DeleteUseCaseTransferParams.fromMap(params);
    return this;
  }
}

class DeleteUseCaseTransferParams extends Parametizable {
  final int id;
  DeleteUseCaseTransferParams({required this.id}) : super();

  factory DeleteUseCaseTransferParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCaseTransferParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
