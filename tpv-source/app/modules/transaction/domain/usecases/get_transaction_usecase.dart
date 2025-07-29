// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/transaction_repository.dart';

class GetTransactionUseCase<TransactionModel> implements UseCase<TransactionModel, GetUseCaseTransactionParams> {

  final TransactionRepository<TransactionModel> repository;
  late GetUseCaseTransactionParams? parameters;

  GetTransactionUseCase(this.repository);

  @override
  Future<Either<Failure, TransactionModel>> call(
    GetUseCaseTransactionParams? params,
  ) async {
    return await repository.getTransaction((parameters = params)!.id);
  }

  @override
  GetUseCaseTransactionParams? getParams() {
    return parameters=parameters ?? GetUseCaseTransactionParams(id:0);
  }

  @override
  UseCase<TransactionModel, GetUseCaseTransactionParams> setParams(
      GetUseCaseTransactionParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<TransactionModel, GetUseCaseTransactionParams> setParamsFromMap(Map params) {
    parameters = GetUseCaseTransactionParams.fromMap(params);
    return this;
  }

}

GetUseCaseTransactionParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseTransactionParams.fromMap(params);

class GetUseCaseTransactionParams extends Parametizable {
  
  final int id;
  GetUseCaseTransactionParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetUseCaseTransactionParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseTransactionParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

