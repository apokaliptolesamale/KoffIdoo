// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/modules/transaction/clientinvoice_exporting.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

class GetClientIdUseCase<ClientInvoiceModel>
    implements
        UseCase<EntityModelList<ClientInvoiceModel>,
            GetUseCaseIClientIdParams> {
  final ClientInvoiceRepository<ClientInvoiceModel> repository;
  late GetUseCaseIClientIdParams? parameters;

  GetClientIdUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<ClientInvoiceModel>>> call(
    GetUseCaseIClientIdParams? params,
  ) async {
    // return await repository.getClientId(params!.toJson());
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.getClientId((params!.toJson()));
  }

  Future<Either<Failure, EntityModelList<ClientInvoiceModel>>>
      getClientId() async {
    return call(getParams()!);
  }

  @override
  GetUseCaseIClientIdParams? getParams() {
    return parameters = parameters ?? GetUseCaseIClientIdParams();
  }

  @override
  UseCase<EntityModelList<ClientInvoiceModel>, GetUseCaseIClientIdParams>
      setParams(GetUseCaseIClientIdParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<ClientInvoiceModel>, GetUseCaseIClientIdParams>
      setParamsFromMap(Map params) {
    parameters = GetUseCaseIClientIdParams.fromMap(params);
    return this;
  }
}

GetUseCaseIClientIdParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseIClientIdParams.fromMap(params);

class GetUseCaseIClientIdParams extends Parametizable {
  dynamic serviceCode;
  dynamic clientId;
  GetUseCaseIClientIdParams({this.clientId, this.serviceCode}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetUseCaseIClientIdParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseIClientIdParams(
          clientId: params.containsKey("clientId") ? params["clientId"] : null,
          serviceCode:
              params.containsKey("serviceCode") ? params["serviceCode"] : null);

  @override
  Map<String, dynamic> toJson() =>
      {"client_id": clientId, "service_code": serviceCode};
}
