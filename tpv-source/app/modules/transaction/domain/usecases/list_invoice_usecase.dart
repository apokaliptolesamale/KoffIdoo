// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/invoice_repository.dart';

class ListInvoiceUseCase<InvoiceModel> implements UseCase<EntityModelList<InvoiceModel>, ListUseCaseInvoiceParams> {
 
  final InvoiceRepository<InvoiceModel> repository;
  late ListUseCaseInvoiceParams? parameters;

  ListInvoiceUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<InvoiceModel>>> call(
    ListUseCaseInvoiceParams? params,
  ) async {
    return  await repository.filter(params!.toJson());/*(params==null && parameters==null)?Left(NulleableFailure(
        message: "Ha ocurrido un error relacionado a los parámetros de la operación.")): await repository.getAll();*/
  }

  Future<Either<Failure, EntityModelList<InvoiceModel>>> getInvoices() async {
    return await call(getParams());
  }


  @override
  ListUseCaseInvoiceParams? getParams() {
    return parameters=parameters ?? ListUseCaseInvoiceParams();
  }

  @override
  UseCase<EntityModelList<InvoiceModel>, ListUseCaseInvoiceParams> setParams(
      ListUseCaseInvoiceParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<InvoiceModel>, ListUseCaseInvoiceParams> setParamsFromMap(Map params) {
    parameters = ListUseCaseInvoiceParams.fromMap(params);
    return this;
  }
}

ListUseCaseInvoiceParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseInvoiceParams.fromMap(params);

class ListUseCaseInvoiceParams extends Parametizable {
  final int? start;
  final int? limit;
  final int? transactionTypeFilter;

  ListUseCaseInvoiceParams({
    this.start,
    this.limit,
    this.transactionTypeFilter
  }) : super() {
start;
limit;
  }

  @override
  bool isValid() {
    return start! > 0 && start! < limit!;
  }

  factory ListUseCaseInvoiceParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseInvoiceParams(
        start: params.containsKey("start") ? params["start"] : 1,
        limit: params.containsKey("limit") ? params["limit"] : 10,
        transactionTypeFilter: params.containsKey("transaction_type_filter") ? params["transaction_type_filter"] : null,
      );

  @override
  Map<String, dynamic> toJson() => {
    "start": start ?? 1,
    "limit": limit ?? 10,
    "transaction_type_filter": transactionTypeFilter
    };
}
