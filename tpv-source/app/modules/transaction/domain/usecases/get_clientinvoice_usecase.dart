// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart'; 
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/clientinvoice_repository.dart';

class GetClientInvoiceUseCase<ClientInvoiceModel> implements UseCase<ClientInvoiceModel, GetUseCaseClientInvoiceParams> {

  final ClientInvoiceRepository<ClientInvoiceModel> repository;
  late GetUseCaseClientInvoiceParams? parameters;

  GetClientInvoiceUseCase(this.repository);

  @override
  Future<Either<Failure, ClientInvoiceModel>> call(
    GetUseCaseClientInvoiceParams? params,
  ) async {
    return (params==null && parameters==null)?Left(NulleableFailure(
        message: "Ha ocurrido un error relacionado a los parámetros de la operación.")): await repository.getClientInvoice((params??parameters)!.id);
  }

  @override
  GetUseCaseClientInvoiceParams? getParams() {
    return parameters=parameters ?? GetUseCaseClientInvoiceParams(id:0);
  }

  @override
  UseCase<ClientInvoiceModel, GetUseCaseClientInvoiceParams> setParams(
      GetUseCaseClientInvoiceParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<ClientInvoiceModel, GetUseCaseClientInvoiceParams> setParamsFromMap(Map params) {
    parameters = GetUseCaseClientInvoiceParams.fromMap(params);
    return this;
  }

}

GetUseCaseClientInvoiceParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseClientInvoiceParams.fromMap(params);

class GetUseCaseClientInvoiceParams extends Parametizable {
  
  final int id;
  GetUseCaseClientInvoiceParams({required this.id,}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetUseCaseClientInvoiceParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseClientInvoiceParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

