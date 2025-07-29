// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../../order/domain/models/order_model.dart';
import '../../../order/domain/repository/order_repository.dart';

DeleteUseCaseOrderParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseOrderParams.fromMap(params);

class DeleteOrderUseCase<OrderModelEntity extends OrderModel>
    implements UseCase<OrderModelEntity, DeleteUseCaseOrderParams> {
  final OrderRepository<OrderModelEntity> repository;

  late DeleteUseCaseOrderParams? parameters;

  DeleteOrderUseCase(this.repository);

  @override
  Future<Either<Failure, OrderModelEntity>> call(
    DeleteUseCaseOrderParams? params,
  ) async {
    return await repository.delete((parameters = params)!.id);
  }

  @override
  DeleteUseCaseOrderParams? getParams() {
    return parameters = parameters ?? DeleteUseCaseOrderParams(id: 0);
  }

  @override
  UseCase<OrderModelEntity, DeleteUseCaseOrderParams> setParams(
      DeleteUseCaseOrderParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<OrderModelEntity, DeleteUseCaseOrderParams> setParamsFromMap(
      Map params) {
    parameters = DeleteUseCaseOrderParams.fromMap(params);
    return this;
  }
}

class DeleteUseCaseOrderParams extends Parametizable {
  final int id;
  DeleteUseCaseOrderParams({required this.id}) : super();

  factory DeleteUseCaseOrderParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCaseOrderParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
