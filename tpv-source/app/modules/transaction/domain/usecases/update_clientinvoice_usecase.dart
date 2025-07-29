// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/clientinvoice_model.dart';
import '../repository/clientinvoice_repository.dart';

class UpdateClientInvoiceUseCase<
        ClientInvoiceModelEntity extends ClientInvoiceModel>
    implements
        UseCase<ClientInvoiceModelEntity, UpdateUseCaseClientInvoiceParams> {
  final ClientInvoiceRepository<ClientInvoiceModelEntity> repository;
  late UpdateUseCaseClientInvoiceParams? parameters;
  UpdateClientInvoiceUseCase(this.repository);

  @override
  Future<Either<Failure, ClientInvoiceModelEntity>> call(
    UpdateUseCaseClientInvoiceParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.update((params ?? parameters)!.id, params!.entity);
  }

  @override
  UpdateUseCaseClientInvoiceParams? getParams() {
    return parameters = parameters ??
        UpdateUseCaseClientInvoiceParams(
          id: 0,
          entity: ClientInvoiceModel(clientId: ""),
        );
  }

  @override
  UseCase<ClientInvoiceModelEntity, UpdateUseCaseClientInvoiceParams> setParams(
      UpdateUseCaseClientInvoiceParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<ClientInvoiceModelEntity, UpdateUseCaseClientInvoiceParams>
      setParamsFromMap(Map params) {
    return this;
  }
}

class UpdateUseCaseClientInvoiceParams extends Parametizable {
  final dynamic id;
  final ClientInvoiceModel entity;
  UpdateUseCaseClientInvoiceParams({
    required this.id,
    required this.entity,
  }) : super();
}
