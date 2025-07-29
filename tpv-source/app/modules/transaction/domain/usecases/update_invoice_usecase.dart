// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/invoice_model.dart';
import '../repository/invoice_repository.dart';

class UpdateInvoiceUseCase<InvoiceModelEntity extends InvoiceModel>
    implements UseCase<InvoiceModelEntity, UpdateUseCaseInvoiceParams> {
  final InvoiceRepository<InvoiceModelEntity> repository;
  late UpdateUseCaseInvoiceParams? parameters;
  UpdateInvoiceUseCase(this.repository);

  @override
  Future<Either<Failure, InvoiceModelEntity>> call(
    UpdateUseCaseInvoiceParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.update((params ?? parameters)!.id, params!.entity);
  }

  @override
  UpdateUseCaseInvoiceParams? getParams() {
    return parameters = parameters ??
        UpdateUseCaseInvoiceParams(id: 0, entity: InvoiceModel());
  }

  @override
  UseCase<InvoiceModelEntity, UpdateUseCaseInvoiceParams> setParams(
      UpdateUseCaseInvoiceParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<InvoiceModelEntity, UpdateUseCaseInvoiceParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class UpdateUseCaseInvoiceParams extends Parametizable {
  final dynamic id;
  final InvoiceModel entity;
  UpdateUseCaseInvoiceParams({required this.id, required this.entity})
      : super();
}
