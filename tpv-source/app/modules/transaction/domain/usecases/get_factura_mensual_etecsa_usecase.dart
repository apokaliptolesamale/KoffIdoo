import '../models/etecsa_invoice_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/clientinvoice_model.dart';
import '../repository/clientinvoice_repository.dart';

class GetFactMensualEtecsaUseCase
    implements UseCase<EtecsaModel, GetUseCaseGetFactMensualEtecsaParams> {
  final ClientInvoiceRepository<ClientInvoiceModel> repository;
  late GetUseCaseGetFactMensualEtecsaParams? parameters;

  GetFactMensualEtecsaUseCase(this.repository);

  @override
  Future<Either<Failure, EtecsaModel>> call(
    GetUseCaseGetFactMensualEtecsaParams? params,
  ) async {
    params = params ?? getParams();
    return await repository.getFactMensualEtecsa(params!.toJson());
  }

  @override
  GetUseCaseGetFactMensualEtecsaParams? getParams() {
    return parameters = parameters ?? GetUseCaseGetFactMensualEtecsaParams();
  }

  @override
  UseCase<EtecsaModel, GetUseCaseGetFactMensualEtecsaParams> setParams(
      GetUseCaseGetFactMensualEtecsaParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EtecsaModel, GetUseCaseGetFactMensualEtecsaParams> setParamsFromMap(
      Map params) {
    parameters = GetUseCaseGetFactMensualEtecsaParams.fromMap(params);
    return this;
  }
}

GetUseCaseGetFactMensualEtecsaParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseGetFactMensualEtecsaParams.fromMap(params);

class GetUseCaseGetFactMensualEtecsaParams extends Parametizable {
  String? serviceCode;
  String? clientId;
  GetUseCaseGetFactMensualEtecsaParams({this.serviceCode, this.clientId})
      : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetUseCaseGetFactMensualEtecsaParams.fromMap(
          Map<dynamic, dynamic> params) =>
      GetUseCaseGetFactMensualEtecsaParams(
        serviceCode:
            params.containsKey("service_code") ? params["service_code"] : "",
        clientId: params.containsKey("client_id") ? params["client_id"] : "",
      );

  @override
  Map<String, dynamic> toJson() =>
      {"client_id": clientId, "service_code": serviceCode};
}
