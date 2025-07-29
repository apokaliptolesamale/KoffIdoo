// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '/app/core/services/logger_service.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/orderhistory_model.dart';
import '../repository/orderhistory_repository.dart';

class UpdateOrderHistoryUseCase<
        OrderHistoryModelEntity extends OrderHistoryModel>
    implements
        UseCase<OrderHistoryModelEntity, UpdateUseCaseOrderHistoryParams> {
  final OrderHistoryRepository<OrderHistoryModelEntity> repository;
  late UpdateUseCaseOrderHistoryParams? parameters;
  UpdateOrderHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, OrderHistoryModelEntity>> call(
    UpdateUseCaseOrderHistoryParams? params,
  ) async {
    parameters = params ?? parameters;
    if (parameters != null) {
      log("Cargando datos desde el repositorio de historial de orden...");
      return await repository.update(parameters!.id, parameters!.entity);
    } else {
      return Left(
          InvalidParamsFailure(message: "Falla por nulidad de parámetros"));
    }
  }

  @override
  UpdateUseCaseOrderHistoryParams? getParams() {
    return parameters = parameters ??
        UpdateUseCaseOrderHistoryParams(
          id: 0,
          entity: OrderHistoryModel(),
        );
  }

  @override
  UseCase<OrderHistoryModelEntity, UpdateUseCaseOrderHistoryParams> setParams(
      UpdateUseCaseOrderHistoryParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<OrderHistoryModelEntity, UpdateUseCaseOrderHistoryParams>
      setParamsFromMap(Map params) {
    parameters = UpdateUseCaseOrderHistoryParams.fromMap(params);
    return this;
  }
}

class UpdateUseCaseOrderHistoryParams extends Parametizable {
  final dynamic id;
  final OrderHistoryModel entity;
  UpdateUseCaseOrderHistoryParams({
    required this.id,
    required this.entity,
  }) : super();

  factory UpdateUseCaseOrderHistoryParams.fromMap(Map params) {
    if (params.containsKey("entity") && params["entity"] is Map) {
      params["entity"] = OrderHistoryModel.fromJson(params["entity"]);
    }
    if (params.containsKey("id") &&
        params.containsKey("entity") &&
        params["entity"] is OrderHistoryModel) {
      return UpdateUseCaseOrderHistoryParams(
        id: params.containsKey("id") ? params["id"] : "",
        entity: params.containsKey("entity") ? params["entity"] : null,
      );
    }
    throw RequiredTypeErrorException();
  }
}
