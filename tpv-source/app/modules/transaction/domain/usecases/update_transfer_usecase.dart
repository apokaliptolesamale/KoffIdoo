// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/transfer_model.dart';
import '../repository/transfer_repository.dart';

class UpdateTransferUseCase<TransferModelEntity extends TransferModel>
    implements UseCase<TransferModelEntity, UpdateUseCaseTransferParams> {
  final TransferRepository<TransferModelEntity> repository;
  late UpdateUseCaseTransferParams? parameters;
  UpdateTransferUseCase(this.repository);

  @override
  Future<Either<Failure, TransferModelEntity>> call(
    UpdateUseCaseTransferParams? params,
  ) async {
    return await repository.update((parameters = params)!.id, params!.entity);
  }

  @override
  UpdateUseCaseTransferParams? getParams() {
    return parameters =
        parameters ?? UpdateUseCaseTransferParams(entity: parameters);
  }

  @override
  UseCase<TransferModelEntity, UpdateUseCaseTransferParams> setParams(
      UpdateUseCaseTransferParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<TransferModelEntity, UpdateUseCaseTransferParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class UpdateUseCaseTransferParams extends Parametizable {
  dynamic id;
  final dynamic entity;
  UpdateUseCaseTransferParams({this.id, required this.entity}) : super();
}
