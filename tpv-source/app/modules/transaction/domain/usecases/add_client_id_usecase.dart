// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '/app/modules/transaction/domain/repository/config_service_repository.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';


class AddClientIdUseCase<ClientServiceModel>
    implements UseCase< ClientServiceModel, AddClientIdUseCaseParams> {
  final ClientServiceRepository<ClientServiceModel> repository;
  late AddClientIdUseCaseParams? parameters;

  AddClientIdUseCase(this.repository);

   @override
 Future<Either<Failure,ClientServiceModel>> call(
    AddClientIdUseCaseParams? params,
  ) async {
  return  params != null
        ? await repository.addClientId((parameters = params).toJson())
        : Left(NulleableFailure(message: "Sin parámetros"));
  }

Future<Either<Failure,  ClientServiceModel>> addClientId() async {
    return call(getParams()!);
  }
  @override
  AddClientIdUseCaseParams? getParams() {
    return parameters = parameters ?? AddClientIdUseCaseParams();
  }

  @override
  UseCase< ClientServiceModel, AddClientIdUseCaseParams> setParams(
      AddClientIdUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase< ClientServiceModel, AddClientIdUseCaseParams>
      setParamsFromMap(Map params) {
    parameters = AddClientIdUseCaseParams.fromMap(params);
    return this;
  }
  


}

AddClientIdUseCaseParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddClientIdUseCaseParams.fromMap(params);

class AddClientIdUseCaseParams extends Parametizable {
  dynamic serviceCode;
  //dynamic fundingSourceUuid;
  dynamic clientId;
  dynamic automatic;
  dynamic owner;
  dynamic metadata;

  AddClientIdUseCaseParams({
    this.serviceCode,
   // this.fundingSourceUuid,
    this.clientId,
    this.automatic,
    this.owner,
    this.metadata,
  }) : super();

  @override
  bool isValid() {
    return (serviceCode != null) ||
        (clientId != null && clientId != '') ||
        (automatic != null && automatic != '') ||
        (owner != null && owner != '') ||
        (metadata != null && metadata != '');
  }

  factory AddClientIdUseCaseParams.fromMap(Map<dynamic, dynamic> params) =>
      AddClientIdUseCaseParams(
        serviceCode:
            params.containsKey("service_code") && params["service_code"] != null
                ? params["service_code"]
                : "",
        /*fundingSourceUuid: params.containsKey("funding_source_uuid") &&
                params["funding_source_uuid"] != null
            ? params["funding_source_uuid"]
            : "",*/
        clientId: params.containsKey("client_id") && params["client_id"] != null
            ? params["client_id"]
            : "",
        automatic:
            params.containsKey("automatic") && params["automatic"] != null
                ? params["automatic"]
                : "",
        owner: params.containsKey("owner") && params["owner"] != null
            ? params["owner"]
            : "",
        metadata: params.containsKey("metadata") && params["metadata"] != null
            ? params["metadata"]
            : "",
      );

  @override
  Map<String, dynamic> toJson() => {
        "service_code": serviceCode,
       // "funding_source_uuid": fundingSourceUuid,
        "client_id": clientId,
        "automatic": automatic,
        "owner": owner,
        "metadata": metadata
      };
}