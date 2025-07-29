// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '/app/modules/transaction/domain/models/invoice_charged_model.dart';
import '/app/modules/transaction/domain/models/invoice_model.dart';
import '/app/modules/transaction/domain/repository/invoice_repository.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';


class PayServiceUseCase<T>
    implements UseCase< InvoiceChargedModel, PayServiceUseCaseParams> {
  final InvoiceRepository<InvoiceModel> repository;
  late PayServiceUseCaseParams? parameters;

  PayServiceUseCase(this.repository);

   @override
  Future<Either<Failure, InvoiceChargedModel>> call(
    PayServiceUseCaseParams? params,
  ) async {
    return params != null
        ? await repository.payElectricityService((parameters = params).toJson()) 
        : Left(NulleableFailure(message: "Sin parámetros"));
  }

Future<Either<Failure,  InvoiceChargedModel>> payService() async {
    return call(getParams()!);
  }
  @override
  PayServiceUseCaseParams? getParams() {
    return parameters = parameters ?? PayServiceUseCaseParams();
  }

  @override
  UseCase< InvoiceChargedModel, PayServiceUseCaseParams> setParams(
      PayServiceUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase< InvoiceChargedModel, PayServiceUseCaseParams>
      setParamsFromMap(Map params) {
    parameters = PayServiceUseCaseParams.fromMap(params);
    return this;
  }
  



}

PayServiceUseCaseParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    PayServiceUseCaseParams.fromMap(params);

class PayServiceUseCaseParams extends Parametizable {
   String? paymentPassword;
   String ? fundingSourceUuid;
   String? owner;
   String? amount;
   String? metadata;
   dynamic period;
   dynamic serviceCode;
   dynamic clientId;
   dynamic fingerPrint;
   String? automatic;


  PayServiceUseCaseParams({
    this.serviceCode,
    this.paymentPassword,
    this.fundingSourceUuid,
    this.owner,
    this.metadata,
    this.amount,
    this.period,
    this.clientId,
    this.fingerPrint,
    this.automatic
  }) : super();

  @override
  bool isValid() {
    return (serviceCode != null) ||
        (paymentPassword != null && paymentPassword != '') ||
        (fundingSourceUuid != null && fundingSourceUuid != '') ||
        (owner != null && owner != '') ||
        (metadata != null && metadata != '');
  }

  factory PayServiceUseCaseParams.fromMap(Map<dynamic, dynamic> params) =>
      PayServiceUseCaseParams(
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
             automatic: params.containsKey("automatic") && params["automatic"] != null
            ? params["automatic"]
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
        "payment_password": paymentPassword,
        "automatic":automatic
      };
}