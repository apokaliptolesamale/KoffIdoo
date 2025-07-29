// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/transaction_repository.dart';

class FilterTransactionUseCase<TransactionModel>
    implements
        UseCase<EntityModelList<TransactionModel>,
            FilterUseCaseTransactionParams> {
  final TransactionRepository<TransactionModel> repository;
  FilterUseCaseTransactionParams? parameters;

  FilterTransactionUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<TransactionModel>>> call(
    FilterUseCaseTransactionParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<TransactionModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseTransactionParams? getParams() {
    return parameters = parameters ?? FilterUseCaseTransactionParams();
  }

  @override
  UseCase<EntityModelList<TransactionModel>, FilterUseCaseTransactionParams>
      setParams(FilterUseCaseTransactionParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<TransactionModel>, FilterUseCaseTransactionParams>
      setParamsFromMap(Map params) {
    parameters = FilterUseCaseTransactionParams.fromMap(params);
    return this;
  }
}

FilterUseCaseTransactionParams filterUseCaseTransactionParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseTransactionParams.fromMap(params);

class FilterUseCaseTransactionParams extends Parametizable {
  int? offset;
  int? limit;
  dynamic startDate;
  dynamic endDate;
  dynamic transctionType;
  dynamic transactionStatus;

  FilterUseCaseTransactionParams(
      {this.offset,
      this.limit,
      this.startDate,
      this.endDate,
      this.transctionType,
      this.transactionStatus})
      : super();

  bool _validate<T>(T? value) {
    return value != null;
  }

  @override
  bool isValid() {
    return (offset != null) ||
        (limit != null) ||
        (startDate != null && startDate != '') ||
        (endDate != null && endDate != '') ||
        (transctionType != null && transctionType != '') ||
        (transactionStatus != null && transactionStatus != '');
  }

  factory FilterUseCaseTransactionParams.fromMap(Map<dynamic, dynamic> params) {
    return FilterUseCaseTransactionParams(
      offset: 0,
      limit: 10,
      startDate: hasValue(params, "startDate") ? params["startDate"] : "",
      endDate: hasValue(params, "endDate") ? params["endDate"] : "",
      transctionType:
          hasValue(params, "transactionType") ? params["transactionType"] : "",
      transactionStatus: hasValue(params, "transactionStatus")
          ? params["transactionStatus"]
          : "",
    );
  }
  static bool hasValue(Map<dynamic, dynamic> params, String key) {
    return params.containsKey(key) && params[key] != "" && params[key] != null;
  }

  @override
  Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "start_date_filter": startDate,
        "end_date_filter": endDate,
        "transaction_type_filter": transctionType,
        "status_filter": transactionStatus
      };
}
