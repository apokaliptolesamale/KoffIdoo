// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/models/orderhistory_model.dart';
import '../repository/orderhistory_repository.dart';

DeleteUseCaseOrderHistoryParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseOrderHistoryParams.fromMap(params);

class DeleteOrderHistoryUseCase<
        OrderHistoryModelEntity extends OrderHistoryModel>
    implements
        UseCase<OrderHistoryModelEntity, DeleteUseCaseOrderHistoryParams> {
  final OrderHistoryRepository<OrderHistoryModelEntity> repository;

  late DeleteUseCaseOrderHistoryParams? parameters;

  DeleteOrderHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, OrderHistoryModelEntity>> call(
    DeleteUseCaseOrderHistoryParams? params,
  ) async {
    return await repository.delete((parameters = params)!.id);
  }

  @override
  DeleteUseCaseOrderHistoryParams? getParams() {
    return parameters = parameters ?? DeleteUseCaseOrderHistoryParams(id: 0);
  }

  @override
  UseCase<OrderHistoryModelEntity, DeleteUseCaseOrderHistoryParams> setParams(
      DeleteUseCaseOrderHistoryParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<OrderHistoryModelEntity, DeleteUseCaseOrderHistoryParams>
      setParamsFromMap(Map params) {
    parameters = DeleteUseCaseOrderHistoryParams.fromMap(params);
    return this;
  }
}

class DeleteUseCaseOrderHistoryParams extends Parametizable {
  final int id;
  DeleteUseCaseOrderHistoryParams({required this.id}) : super();

  factory DeleteUseCaseOrderHistoryParams.fromMap(
          Map<dynamic, dynamic> params) =>
      DeleteUseCaseOrderHistoryParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
