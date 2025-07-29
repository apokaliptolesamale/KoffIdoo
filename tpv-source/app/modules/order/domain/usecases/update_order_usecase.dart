// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../../order/domain/models/order_model.dart';
import '../../../order/domain/repository/order_repository.dart';

class UpdateOrderUseCase<OrderModelEntity extends OrderModel>
    implements UseCase<OrderModelEntity, UpdateUseCaseOrderParams> {
  final OrderRepository<OrderModelEntity> repository;
  late UpdateUseCaseOrderParams? parameters;
  UpdateOrderUseCase(this.repository);

  @override
  Future<Either<Failure, OrderModelEntity>> call(
    UpdateUseCaseOrderParams? params,
  ) async {
    parameters = params ?? parameters;
    if (parameters != null) {
      return await repository.update(parameters!.id, parameters!.entity);
    } else {
      return Future.value(Left(
          EmptyParamsFailure(message: "Error por parámetros nulos o vacíos.")));
    }
  }

  @override
  UpdateUseCaseOrderParams? getParams() {
    return parameters = parameters ??
        UpdateUseCaseOrderParams(id: 0, entity: OrderModel.fromJson({}));
  }

  @override
  UseCase<OrderModelEntity, UpdateUseCaseOrderParams> setParams(
      UpdateUseCaseOrderParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<OrderModelEntity, UpdateUseCaseOrderParams> setParamsFromMap(
      Map params) {
    parameters = UpdateUseCaseOrderParams.fromMap(params);
    return this;
  }
}

class UpdateUseCaseOrderParams extends Parametizable {
  final dynamic id;
  final OrderModel entity;

  UpdateUseCaseOrderParams({required this.id, required this.entity}) : super();

  factory UpdateUseCaseOrderParams.fromMap(Map<dynamic, dynamic> params) {
    if (params.containsKey("entity") && params["entity"] is Map) {
      params["entity"] = OrderModel.fromJson(params["entity"]);
    }
    if (params.containsKey("entity") && params["entity"] is OrderModel) {
      final order = (params["entity"] as OrderModel);
      return UpdateUseCaseOrderParams(
        id: params.containsKey("id") ? params["id"] : "",
        entity: order,
      );
    }
    throw RequiredTypeErrorException();
  }
}
