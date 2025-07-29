// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/models/transaction_model.dart';
import '../repository/transaction_repository.dart';

class DeleteTransactionUseCase<TransactionModelEntity extends TransactionModel> implements UseCase<TransactionModelEntity, DeleteUseCaseTransactionParams> {

  final TransactionRepository<TransactionModelEntity> repository;
  
  late DeleteUseCaseTransactionParams? parameters;

  DeleteTransactionUseCase(this.repository);

  @override
  Future<Either<Failure, TransactionModelEntity>> call(
    DeleteUseCaseTransactionParams? params,
  ) async {
    return await repository.delete((parameters = params)!.id);
  }

  @override
  DeleteUseCaseTransactionParams? getParams() {
    return parameters=parameters ?? DeleteUseCaseTransactionParams(id:0);
  }

  @override
  UseCase<TransactionModelEntity, DeleteUseCaseTransactionParams> setParams(
      DeleteUseCaseTransactionParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<TransactionModelEntity, DeleteUseCaseTransactionParams> setParamsFromMap(Map params) {
    parameters = DeleteUseCaseTransactionParams.fromMap(params);
    return this;
  }

}

DeleteUseCaseTransactionParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseTransactionParams.fromMap(params);

class DeleteUseCaseTransactionParams extends Parametizable {

  final int id;
  DeleteUseCaseTransactionParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory DeleteUseCaseTransactionParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCaseTransactionParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

