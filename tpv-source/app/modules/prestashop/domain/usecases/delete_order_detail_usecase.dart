// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/models/order_detail_model.dart';
import '../repository/order_detail_repository.dart';

DeleteUseCaseOrderDetailParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseOrderDetailParams.fromMap(params);

class DeleteOrderDetailUseCase<OrderDetailModelEntity extends OrderDetailModel>
    implements UseCase<OrderDetailModelEntity, DeleteUseCaseOrderDetailParams> {
  final OrderDetailRepository<OrderDetailModelEntity> repository;

  late DeleteUseCaseOrderDetailParams? parameters;

  DeleteOrderDetailUseCase(this.repository);

  @override
  Future<Either<Failure, OrderDetailModelEntity>> call(
    DeleteUseCaseOrderDetailParams? params,
  ) async {
    return await repository.delete((parameters = params)!.id);
  }

  @override
  DeleteUseCaseOrderDetailParams? getParams() {
    return parameters = parameters ?? DeleteUseCaseOrderDetailParams(id: 0);
  }

  @override
  UseCase<OrderDetailModelEntity, DeleteUseCaseOrderDetailParams> setParams(
      DeleteUseCaseOrderDetailParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<OrderDetailModelEntity, DeleteUseCaseOrderDetailParams>
      setParamsFromMap(Map params) {
    parameters = DeleteUseCaseOrderDetailParams.fromMap(params);
    return this;
  }
}

class DeleteUseCaseOrderDetailParams extends Parametizable {
  final int id;
  DeleteUseCaseOrderDetailParams({required this.id}) : super();

  factory DeleteUseCaseOrderDetailParams.fromMap(
          Map<dynamic, dynamic> params) =>
      DeleteUseCaseOrderDetailParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
