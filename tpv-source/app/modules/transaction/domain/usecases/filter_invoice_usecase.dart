// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/invoice_repository.dart';



class FilterInvoiceUseCase<InvoiceModel> implements UseCase<EntityModelList<InvoiceModel>, FilterUseCaseInvoiceParams> {

  final InvoiceRepository<InvoiceModel> repository;
  FilterUseCaseInvoiceParams? parameters;

  FilterInvoiceUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<InvoiceModel>>> call(
    FilterUseCaseInvoiceParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<InvoiceModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseInvoiceParams? getParams() {
    return parameters= parameters ?? FilterUseCaseInvoiceParams();
  }

  @override
  UseCase<EntityModelList<InvoiceModel>, FilterUseCaseInvoiceParams> setParams(
      FilterUseCaseInvoiceParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<InvoiceModel>, FilterUseCaseInvoiceParams> setParamsFromMap(
      Map params) {
    parameters = FilterUseCaseInvoiceParams.fromMap(params);
    return this;
  }
}

FilterUseCaseInvoiceParams filterUseCaseInvoiceParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseInvoiceParams.fromMap(params);

class FilterUseCaseInvoiceParams extends Parametizable {
  final String? idinvoice; // id de el caso
  

  int start = 1;
  int limit = 20;

  FilterUseCaseInvoiceParams({
    this.idinvoice,     
  }) : super();

  bool _validate<T>(T? value) {
    return value != null;
  }

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  factory FilterUseCaseInvoiceParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCaseInvoiceParams(
        idinvoice: params.containsKey("idinvoice") ? params["idinvoice"] : "" 
      );

  @override
  Map<String, dynamic> toJson() => {
        "idinvoice": idinvoice
      };
}
