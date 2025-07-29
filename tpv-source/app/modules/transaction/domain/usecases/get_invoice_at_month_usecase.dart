// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart'; 
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/invoice_repository.dart';

class GetMonthlyInvoiceUseCase<InvoiceModel> implements UseCase<InvoiceModel, GetUseCaseInvoiceParams> {

  final InvoiceRepository<InvoiceModel> repository;
  late GetUseCaseInvoiceParams? parameters;

  GetMonthlyInvoiceUseCase(this.repository);

  @override
  Future<Either<Failure, InvoiceModel>> call(
    GetUseCaseInvoiceParams? params,
  ) async {
    return (params==null && parameters==null)?Left(NulleableFailure(
        message: "Ha ocurrido un error relacionado a los parámetros de la operación.")): await repository.getInvoice((params??parameters)!.id);
  }

  @override
  GetUseCaseInvoiceParams? getParams() {
    return parameters=parameters ?? GetUseCaseInvoiceParams(id:0);
  }

  @override
  UseCase<InvoiceModel, GetUseCaseInvoiceParams> setParams(
      GetUseCaseInvoiceParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<InvoiceModel, GetUseCaseInvoiceParams> setParamsFromMap(Map params) {
    parameters = GetUseCaseInvoiceParams.fromMap(params);
    return this;
  }

}

GetUseCaseInvoiceParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseInvoiceParams.fromMap(params);

class GetUseCaseInvoiceParams extends Parametizable {
  
  final int id;
  GetUseCaseInvoiceParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetUseCaseInvoiceParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseInvoiceParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

