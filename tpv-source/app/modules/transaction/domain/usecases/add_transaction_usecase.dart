// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/transaction_repository.dart';

class AddTransactionUseCase<TransactionModel> implements UseCase<TransactionModel, AddUseCaseTransactionParams> {

  final TransactionRepository<TransactionModel> repository;
  late AddUseCaseTransactionParams? parameters;

  AddTransactionUseCase(this.repository);

  @override
  Future<Either<Failure, TransactionModel>> call(
    AddUseCaseTransactionParams? params,
  ) async {
    return await repository.add(parameters=params);
  }

  @override
  AddUseCaseTransactionParams? getParams() {
    return parameters=parameters ?? AddUseCaseTransactionParams(id:0);
  }

  @override
  UseCase<TransactionModel, AddUseCaseTransactionParams> setParams(AddUseCaseTransactionParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<TransactionModel, AddUseCaseTransactionParams> setParamsFromMap(Map params) {
    parameters = AddUseCaseTransactionParams.fromMap(params);
    return this;
  }

}

AddUseCaseTransactionParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseTransactionParams.fromMap(params);

class AddUseCaseTransactionParams extends Parametizable {

  final int id;
  AddUseCaseTransactionParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory AddUseCaseTransactionParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCaseTransactionParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

