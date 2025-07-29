// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart'; 
import '../repository/clientinvoice_repository.dart';

class AddClientInvoiceUseCase<ClientServiceModel> implements UseCase<ClientServiceModel, AddUseCaseClientInvoiceParams> {

  final ClientInvoiceRepository<ClientServiceModel> repository;
  late AddUseCaseClientInvoiceParams? parameters;

  AddClientInvoiceUseCase(this.repository);

  @override
  Future<Either<Failure, ClientServiceModel>> call(
    AddUseCaseClientInvoiceParams? params,
  ) async {
    return (params==null && parameters==null)?Left(NulleableFailure(
        message: "Ha ocurrido un error relacionado a los parámetros de la operación.")):await repository.add(params??parameters);
  }

  


  @override
  AddUseCaseClientInvoiceParams? getParams() {
    return parameters=parameters ?? AddUseCaseClientInvoiceParams(id:0);
  }

  @override
  UseCase<ClientServiceModel, AddUseCaseClientInvoiceParams> setParams(AddUseCaseClientInvoiceParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<ClientServiceModel, AddUseCaseClientInvoiceParams> setParamsFromMap(Map params) {
    parameters = AddUseCaseClientInvoiceParams.fromMap(params);
    return this;
  }

}

AddUseCaseClientInvoiceParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseClientInvoiceParams.fromMap(params);

class AddUseCaseClientInvoiceParams extends Parametizable {

  final int id;
  AddUseCaseClientInvoiceParams({required this.id,}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory AddUseCaseClientInvoiceParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCaseClientInvoiceParams(
        id: params.containsKey("id") ? params["id"] : 0 ,
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

