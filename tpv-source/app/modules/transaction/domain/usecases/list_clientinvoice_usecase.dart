// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/clientinvoice_repository.dart';

class ListClientInvoiceUseCase<ClientInvoiceModel>
    implements
        UseCase<EntityModelList<ClientInvoiceModel>,
            ListUseCaseClientInvoiceParams> {
  final ClientInvoiceRepository<ClientInvoiceModel> repository;
  late ListUseCaseClientInvoiceParams? parameters;

  ListClientInvoiceUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<ClientInvoiceModel>>> call(
    ListUseCaseClientInvoiceParams? params,
  ) async {
    return /*(params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))*/
        await repository.filter(params!.toJson());
  }

  Future<Either<Failure, EntityModelList<ClientInvoiceModel>>> getAll() async {
    return await call(getParams()!);
  }

  @override
  ListUseCaseClientInvoiceParams? getParams() {
    return parameters = parameters ?? ListUseCaseClientInvoiceParams();
  }

  @override
  UseCase<EntityModelList<ClientInvoiceModel>, ListUseCaseClientInvoiceParams>
      setParams(ListUseCaseClientInvoiceParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<ClientInvoiceModel>, ListUseCaseClientInvoiceParams>
      setParamsFromMap(Map params) {
    parameters = ListUseCaseClientInvoiceParams.fromMap(params);
    return this;
  }
}

ListUseCaseClientInvoiceParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseClientInvoiceParams.fromMap(params);

class ListUseCaseClientInvoiceParams extends Parametizable {
  final int? start;
  final int? limit;
  String? clientId;
  late String? serviceCode;

  ListUseCaseClientInvoiceParams(
      {this.start, this.limit, this.serviceCode, this.clientId})
      : super() {
    start;
    limit;
  }

  @override
  bool isValid() {
    return start! > 0 && start! < limit!;
  }

  factory ListUseCaseClientInvoiceParams.fromMap(
          Map<dynamic, dynamic> params) =>
      ListUseCaseClientInvoiceParams(
          /* start: params.containsKey("") ? params["start"] : 1,
          limit: params.containsKey("limit") ? params["limit"] : 50,*/
          clientId: params.containsKey("client_id") ? params["client_id"] : "",
          serviceCode:
              params.containsKey("service_code") ? params["service_code"] : "");

  @override
  Map<String, dynamic> toJson() => {
        /*"start": start ?? 1,
       "limit": limit ?? 50,*/
        "client_id": clientId,
        "service_code": serviceCode
      };
}
