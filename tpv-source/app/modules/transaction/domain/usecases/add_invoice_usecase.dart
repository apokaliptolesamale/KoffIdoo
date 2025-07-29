// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart'; 
import '../repository/invoice_repository.dart';

class AddInvoiceUseCase<InvoiceModel> implements UseCase<InvoiceModel, AddUseCaseInvoiceParams> {

  final InvoiceRepository<InvoiceModel> repository;
  late AddUseCaseInvoiceParams? parameters;

  AddInvoiceUseCase(this.repository);

  @override
  Future<Either<Failure, InvoiceModel>> call(
    AddUseCaseInvoiceParams? params,
  ) async {
    return (params==null && parameters==null)?Left(NulleableFailure(
        message: "Ha ocurrido un error relacionado a los parámetros de la operación.")):await repository.add(params??parameters);
  }

  @override
  AddUseCaseInvoiceParams? getParams() {
    return parameters=parameters ?? AddUseCaseInvoiceParams(id:0);
  }

  @override
  UseCase<InvoiceModel, AddUseCaseInvoiceParams> setParams(AddUseCaseInvoiceParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<InvoiceModel, AddUseCaseInvoiceParams> setParamsFromMap(Map params) {
    parameters = AddUseCaseInvoiceParams.fromMap(params);
    return this;
  }

}

AddUseCaseInvoiceParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseInvoiceParams.fromMap(params);

class AddUseCaseInvoiceParams extends Parametizable {

  final int id;
  AddUseCaseInvoiceParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory AddUseCaseInvoiceParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCaseInvoiceParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

