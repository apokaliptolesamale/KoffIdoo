// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/order_detail_model.dart';
import '../repository/order_detail_repository.dart';

class UpdateOrderDetailUseCase<OrderDetailModelEntity extends OrderDetailModel>
    implements UseCase<OrderDetailModelEntity, UpdateUseCaseOrderDetailParams> {
  final OrderDetailRepository<OrderDetailModelEntity> repository;
  late UpdateUseCaseOrderDetailParams? parameters;
  UpdateOrderDetailUseCase(this.repository);

  @override
  Future<Either<Failure, OrderDetailModelEntity>> call(
    UpdateUseCaseOrderDetailParams? params,
  ) async {
    return await repository.update((parameters = params)!.id, params!.entity);
  }

  @override
  UpdateUseCaseOrderDetailParams? getParams() {
    return parameters = parameters ??
        UpdateUseCaseOrderDetailParams(
            id: 0, entity: OrderDetailModel(idOrderDetail: -1));
  }

  @override
  UseCase<OrderDetailModelEntity, UpdateUseCaseOrderDetailParams> setParams(
      UpdateUseCaseOrderDetailParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<OrderDetailModelEntity, UpdateUseCaseOrderDetailParams>
      setParamsFromMap(Map params) {
    return this;
  }
}

class UpdateUseCaseOrderDetailParams extends Parametizable {
  final dynamic id;
  final OrderDetailModel entity;
  UpdateUseCaseOrderDetailParams({required this.id, required this.entity})
      : super();
}
