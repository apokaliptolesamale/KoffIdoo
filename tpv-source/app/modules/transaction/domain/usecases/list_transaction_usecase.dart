// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/transaction_repository.dart';

class ListTransactionUseCase<TransactionModel> implements UseCase<EntityModelList<TransactionModel>, ListUseCaseTransactionParams> {
 
  final TransactionRepository<TransactionModel> repository;
  late ListUseCaseTransactionParams? parameters;
  ListTransactionUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<TransactionModel>>> call(
    ListUseCaseTransactionParams? params,
  ) async {
    if(parameters!.limit! > 10 && parameters!.offset! > 0 ){
      return await repository.paginate(0,10,parameters!.toJson());
    }else{
    return await repository.getAll();
    }
  }

  Future<Either<Failure, EntityModelList<TransactionModel>>> getAll() async {
    return await call(getParams());
  }


  @override
  ListUseCaseTransactionParams? getParams() {
    return parameters=  ListUseCaseTransactionParams();
  }

  @override
  UseCase<EntityModelList<TransactionModel>, ListUseCaseTransactionParams> setParams(
      ListUseCaseTransactionParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<TransactionModel>, ListUseCaseTransactionParams> setParamsFromMap(Map params) {
    parameters = ListUseCaseTransactionParams.fromMap(params);
    return this;
  }
  
}

ListUseCaseTransactionParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseTransactionParams.fromMap(params);

class ListUseCaseTransactionParams extends Parametizable {
  final int? offset;
  final int? limit;


  ListUseCaseTransactionParams({
    this.offset= 0,
    this.limit=10,

  }) : super() {
     offset;
     limit;
  }

  @override
  bool isValid() {
    return true;
  }

  factory ListUseCaseTransactionParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseTransactionParams(
        offset: params.containsKey("offset") ? params["offset"] : 0,
        limit: params.containsKey("limit") ? params["limit"] : 10,
      );

  @override
  Map<String, dynamic> toJson() => {
    "offset": offset ?? 0,
    "limit": limit ?? 10};
}
