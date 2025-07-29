// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import '../models/transaction_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/transaction_repository.dart';

class UpdateTransactionUseCase<TransactionModelEntity extends TransactionModel> implements UseCase<TransactionModelEntity, UpdateUseCaseTransactionParams> {
 
  final TransactionRepository<TransactionModelEntity> repository;
  late UpdateUseCaseTransactionParams? parameters;
  UpdateTransactionUseCase(this.repository);

  @override
  Future<Either<Failure, TransactionModelEntity>> call(
    UpdateUseCaseTransactionParams? params,
  ) async {
    return await repository.update((parameters = params)!.id, params!.entity);
  }

  @override
/*  UpdateUseCaseTransactionParams? getParams() {
    return parameters=parameters ?? UpdateUseCaseTransactionParams(id: 0,entity: TransactionModel(idTransaction: "0")); 
  }*/

  @override
  UseCase<TransactionModelEntity, UpdateUseCaseTransactionParams> setParams(
      UpdateUseCaseTransactionParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<TransactionModelEntity, UpdateUseCaseTransactionParams> setParamsFromMap(Map params) {
    return this;
  }
  
  @override
  UpdateUseCaseTransactionParams? getParams() {
    // TODO: implement getParams
    throw UnimplementedError();
  }
}

class UpdateUseCaseTransactionParams extends Parametizable {
  final dynamic id;
  final TransactionModel entity;
  UpdateUseCaseTransactionParams({required this.id, required this.entity}) : super();
}
