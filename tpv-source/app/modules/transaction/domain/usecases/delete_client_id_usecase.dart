// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '/app/modules/transaction/domain/models/client_service_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/models/clientinvoice_model.dart';
import '../repository/clientinvoice_repository.dart';

class DeleteClientClientIdUseCase<T>
    implements UseCase<ClientServiceModel, DeleteUseCaseClientInvoiceParams> {
  final ClientInvoiceRepository<ClientInvoiceModel> repository;

  late DeleteUseCaseClientInvoiceParams? parameters;

  DeleteClientClientIdUseCase(this.repository);

  @override
  Future<Either<Failure, ClientServiceModel>> call(
    DeleteUseCaseClientInvoiceParams? params,
  ) async {
    return /* (params==null && parameters==null)?Left(NulleableFailure(
        message: "Ha ocurrClientIdo un error relacionado a los parámetros de la operación.")):*/
        await repository.deleteClientId((params ?? parameters)!.serviceUuid);
  }

  Future<Either<Failure, ClientServiceModel>> deleteClientID() async {
    return await call(getParams()!);
  }

  @override
  DeleteUseCaseClientInvoiceParams? getParams() {
    return parameters = parameters ?? DeleteUseCaseClientInvoiceParams();
  }

  @override
  UseCase<ClientServiceModel, DeleteUseCaseClientInvoiceParams> setParams(
      DeleteUseCaseClientInvoiceParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<ClientServiceModel, DeleteUseCaseClientInvoiceParams>
      setParamsFromMap(Map params) {
    parameters = DeleteUseCaseClientInvoiceParams.fromMap(params);
    return this;
  }
}

DeleteUseCaseClientInvoiceParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseClientInvoiceParams.fromMap(params);

class DeleteUseCaseClientInvoiceParams extends Parametizable {
  final String? serviceUuid;
  DeleteUseCaseClientInvoiceParams({
    this.serviceUuid,
  }) : super();

  factory DeleteUseCaseClientInvoiceParams.fromMap(
          Map<dynamic, dynamic> params) =>
      DeleteUseCaseClientInvoiceParams(
        serviceUuid:
            params.containsKey("serviceUuid") ? params["serviceUuid"] : "",
      );

  @override
  Map<String, dynamic> toJson() => {"client_id": serviceUuid};
}
