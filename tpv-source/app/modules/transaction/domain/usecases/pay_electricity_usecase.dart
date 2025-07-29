// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '/app/modules/transaction/domain/repository/clientinvoice_repository.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';


class PayElectricityUseCase<ClientInvoiceModel>
    implements UseCase< ClientInvoiceModel, PayElectricityUseCaseParams> {
  final ClientInvoiceRepository<ClientInvoiceModel> repository;
  late PayElectricityUseCaseParams? parameters;

  PayElectricityUseCase(this.repository);

  /* @override
  Future<Either<Failure,  ClientInvoiceModel>> call(
    PayElectricityUseCaseParams? params,
  ) async {
    return params != null
        ? await repository.addClientId((parameters = params).toJson())
        : Left(NulleableFailure(message: "Sin parámetros"));
  }*/

Future<Either<Failure,  ClientInvoiceModel>> payService() async {
    return call(getParams()!);
  }
  @override
  PayElectricityUseCaseParams? getParams() {
    return parameters = parameters ?? PayElectricityUseCaseParams();
  }

  @override
  UseCase< ClientInvoiceModel, PayElectricityUseCaseParams> setParams(
      PayElectricityUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase< ClientInvoiceModel, PayElectricityUseCaseParams>
      setParamsFromMap(Map params) {
    parameters = PayElectricityUseCaseParams.fromMap(params);
    return this;
  }
  
  @override
  Future<Either<Failure, ClientInvoiceModel>> call(PayElectricityUseCaseParams? params) {
    // TODO: implement call
    throw UnimplementedError();
  }


}

PayElectricityUseCaseParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    PayElectricityUseCaseParams.fromMap(params);

class PayElectricityUseCaseParams extends Parametizable {
   String? paymentPassword;
   String ? fundingSourceUuid;
   String? owner;
   String? amount;
   String? metadata;
   String? period;
   dynamic serviceCode;
   dynamic clientId;
   dynamic fingerPrint;


  PayElectricityUseCaseParams({
    this.serviceCode,
    this.paymentPassword,
    this.fundingSourceUuid,
    this.owner,
    this.metadata,
    this.amount,
    this.period,
    this.clientId,
    this.fingerPrint
  }) : super();

  @override
  bool isValid() {
    return (serviceCode != null) ||
        (paymentPassword != null && paymentPassword != '') ||
        (fundingSourceUuid != null && fundingSourceUuid != '') ||
        (owner != null && owner != '') ||
        (metadata != null && metadata != '');
  }

  factory PayElectricityUseCaseParams.fromMap(Map<dynamic, dynamic> params) =>
      PayElectricityUseCaseParams(
        serviceCode:
            params.containsKey("service_code") && params["service_code"] != null
                ? params["service_code"]
                : "",
        paymentPassword: params.containsKey("payment_password") && params["payment_password"] != null
            ? params["payment_password"]
            : "",
        fundingSourceUuid:
            params.containsKey("funding_source_uuid") && params["funding_source_uuid"] != null
                ? params["funding_source_uuid"]
                : "",
        owner: params.containsKey("owner") && params["owner"] != null
            ? params["owner"]
            : "",
        metadata: params.containsKey("metadata") && params["metadata"] != null
            ? params["metadata"]
            : "",
            amount: params.containsKey("amount") && params["amount"] != null
            ? params["amount"]
            : "",
           period: params.containsKey("period") && params["period"] != null
            ? params["period"]
            : "",  
            clientId: params.containsKey("client_id") && params["client_id"] != null
            ? params["client_id"]
            : "",
      );

  @override
  Map<String, dynamic> toJson() => {
        "service_code": serviceCode,
       "funding_source_uuid": fundingSourceUuid,
        "client_id": clientId,
        "owner": owner,
        "metadata": metadata,
        "period":period,
        "amount":amount,
        "payment_password": paymentPassword
      };
}