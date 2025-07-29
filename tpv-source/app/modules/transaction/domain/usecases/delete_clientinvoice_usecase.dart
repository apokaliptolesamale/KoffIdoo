// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/models/clientinvoice_model.dart';
import '../repository/clientinvoice_repository.dart';

class DeleteClientInvoiceUseCase<ClientInvoiceModelEntity extends ClientInvoiceModel> implements UseCase<ClientInvoiceModelEntity, DeleteUseCaseClientInvoiceParams> {

  final ClientInvoiceRepository<ClientInvoiceModelEntity> repository;
  
  late DeleteUseCaseClientInvoiceParams? parameters;

  DeleteClientInvoiceUseCase(this.repository);

  @override
  Future<Either<Failure, ClientInvoiceModelEntity>> call(
    DeleteUseCaseClientInvoiceParams? params,
  ) async {
    return (params==null && parameters==null)?Left(NulleableFailure(
        message: "Ha ocurrido un error relacionado a los parámetros de la operación.")): await repository.delete((params??parameters)!.id);
  }

  @override
  DeleteUseCaseClientInvoiceParams? getParams() {
    return parameters=parameters ?? DeleteUseCaseClientInvoiceParams(id:0);
  }

  @override
  UseCase<ClientInvoiceModelEntity, DeleteUseCaseClientInvoiceParams> setParams(
      DeleteUseCaseClientInvoiceParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<ClientInvoiceModelEntity, DeleteUseCaseClientInvoiceParams> setParamsFromMap(Map params) {
    parameters = DeleteUseCaseClientInvoiceParams.fromMap(params);
    return this;
  }

}

DeleteUseCaseClientInvoiceParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseClientInvoiceParams.fromMap(params);

class DeleteUseCaseClientInvoiceParams extends Parametizable {

  final int id;
  DeleteUseCaseClientInvoiceParams({required this.id,}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory DeleteUseCaseClientInvoiceParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCaseClientInvoiceParams(
        id: params.containsKey("id") ? params["id"] : 0 ,
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

