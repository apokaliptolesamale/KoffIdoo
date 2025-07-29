// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/models/invoice_model.dart';
import '../repository/invoice_repository.dart';

class DeleteInvoiceUseCase<InvoiceModelEntity extends InvoiceModel> implements UseCase<InvoiceModelEntity, DeleteUseCaseInvoiceParams> {

  final InvoiceRepository<InvoiceModelEntity> repository;
  
  late DeleteUseCaseInvoiceParams? parameters;

  DeleteInvoiceUseCase(this.repository);

  @override
  Future<Either<Failure, InvoiceModelEntity>> call(
    DeleteUseCaseInvoiceParams? params,
  ) async {
    return (params==null && parameters==null)?Left(NulleableFailure(
        message: "Ha ocurrido un error relacionado a los parámetros de la operación.")): await repository.delete((params??parameters)!.id);
  }

  @override
  DeleteUseCaseInvoiceParams? getParams() {
    return parameters=parameters ?? DeleteUseCaseInvoiceParams(id:0);
  }

  @override
  UseCase<InvoiceModelEntity, DeleteUseCaseInvoiceParams> setParams(
      DeleteUseCaseInvoiceParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<InvoiceModelEntity, DeleteUseCaseInvoiceParams> setParamsFromMap(Map params) {
    parameters = DeleteUseCaseInvoiceParams.fromMap(params);
    return this;
  }

}

DeleteUseCaseInvoiceParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseInvoiceParams.fromMap(params);

class DeleteUseCaseInvoiceParams extends Parametizable {

  final int id;
  DeleteUseCaseInvoiceParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory DeleteUseCaseInvoiceParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCaseInvoiceParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

