// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/orderhistory_repository.dart';

GetUseCaseOrderHistoryParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseOrderHistoryParams.fromMap(params);

class GetOrderHistoryUseCase<OrderHistoryModel>
    implements UseCase<OrderHistoryModel, GetUseCaseOrderHistoryParams> {
  final OrderHistoryRepository<OrderHistoryModel> repository;
  late GetUseCaseOrderHistoryParams? parameters;

  GetOrderHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, OrderHistoryModel>> call(
    GetUseCaseOrderHistoryParams? params,
  ) async {
    return await repository.getOrderHistory((parameters = params)!.id);
  }

  @override
  GetUseCaseOrderHistoryParams? getParams() {
    return parameters = parameters ?? GetUseCaseOrderHistoryParams(id: 0);
  }

  @override
  UseCase<OrderHistoryModel, GetUseCaseOrderHistoryParams> setParams(
      GetUseCaseOrderHistoryParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<OrderHistoryModel, GetUseCaseOrderHistoryParams> setParamsFromMap(
      Map params) {
    parameters = GetUseCaseOrderHistoryParams.fromMap(params);
    return this;
  }
}

class GetUseCaseOrderHistoryParams extends Parametizable {
  final int id;
  GetUseCaseOrderHistoryParams({required this.id}) : super();

  factory GetUseCaseOrderHistoryParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseOrderHistoryParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
