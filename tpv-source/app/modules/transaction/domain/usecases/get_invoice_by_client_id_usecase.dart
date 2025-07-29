// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '/app/modules/transaction/domain/models/invoice_model.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/invoice_repository.dart';

class GetInvoiceByClientIdUseCase<T>
    implements
        UseCase<EntityModelList<InvoiceModel>, ListUseCaseInvoiceParams> {
  final InvoiceRepository<InvoiceModel> repository;
  late ListUseCaseInvoiceParams? parameters;

  GetInvoiceByClientIdUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<InvoiceModel>>> call(
    ListUseCaseInvoiceParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.getInvoiceByClientId(params!.toJson());

    /*(parameters = params)
        ? await repository.getInvoiceByClientId(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));*/
  }

  Future<Either<Failure, EntityModelList<InvoiceModel>>>
      getInvoiceByClientId() async {
    return await call(getParams()!);
  }

  @override
  ListUseCaseInvoiceParams? getParams() {
    return parameters = parameters ?? ListUseCaseInvoiceParams();
  }

  @override
  UseCase<EntityModelList<InvoiceModel>, ListUseCaseInvoiceParams> setParams(
      ListUseCaseInvoiceParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<InvoiceModel>, ListUseCaseInvoiceParams>
      setParamsFromMap(Map params) {
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
  final dynamic clientId;
  final dynamic status;

  ListUseCaseInvoiceParams({
    this.start,
    this.limit,
    this.clientId,
    this.status,
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
        start: params.containsKey("start") ? params["start"] : 0,
        limit: params.containsKey("limit") ? params["limit"] : 10,
        clientId: params.containsKey("clientId") ? params["clientId"] : "",
        status: params.containsKey("status") ? params["status"] : null,
      );

  @override
  Map<String, dynamic> toJson() => {
        "limit": limit ?? 10,
        "offset": start ?? 0,
        "transaction_type_filter": 19,
        "client_id": clientId,
        "status": 1111,
      };
}
