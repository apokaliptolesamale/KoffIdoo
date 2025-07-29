// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/clientinvoice_repository.dart';



class FilterClientInvoiceUseCase<ClientInvoiceModel> implements UseCase<EntityModelList<ClientInvoiceModel>, FilterUseCaseClientInvoiceParams> {

  final ClientInvoiceRepository<ClientInvoiceModel> repository;
  FilterUseCaseClientInvoiceParams? parameters;

  FilterClientInvoiceUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<ClientInvoiceModel>>> call(
    FilterUseCaseClientInvoiceParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<ClientInvoiceModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseClientInvoiceParams? getParams() {
    return parameters= parameters ?? FilterUseCaseClientInvoiceParams();
  }

  @override
  UseCase<EntityModelList<ClientInvoiceModel>, FilterUseCaseClientInvoiceParams> setParams(
      FilterUseCaseClientInvoiceParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<ClientInvoiceModel>, FilterUseCaseClientInvoiceParams> setParamsFromMap(
      Map params) {
    parameters = FilterUseCaseClientInvoiceParams.fromMap(params);
    return this;
  }
}

FilterUseCaseClientInvoiceParams filterUseCaseClientInvoiceParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseClientInvoiceParams.fromMap(params);

class FilterUseCaseClientInvoiceParams extends Parametizable {
  final String? idclientinvoice; // id de el caso
  

  int start = 1;
  int limit = 20;

  FilterUseCaseClientInvoiceParams({
    this.idclientinvoice,     
  }) : super();

  bool _validate<T>(T? value) {
    return value != null;
  }

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  factory FilterUseCaseClientInvoiceParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCaseClientInvoiceParams(
        idclientinvoice: params.containsKey("idclientinvoice") ? params["idclientinvoice"] : "" 
      );

  @override
  Map<String, dynamic> toJson() => {
        "idclientinvoice": idclientinvoice
      };
}
