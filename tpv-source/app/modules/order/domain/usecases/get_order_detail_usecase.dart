// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/order_detail_repository.dart';

GetUseCaseOrderDetailParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseOrderDetailParams.fromMap(params);

class GetOrderDetailUseCase<OrderDetailModel>
    implements UseCase<OrderDetailModel, GetUseCaseOrderDetailParams> {
  final OrderDetailRepository<OrderDetailModel> repository;
  late GetUseCaseOrderDetailParams? parameters;

  GetOrderDetailUseCase(this.repository);

  @override
  Future<Either<Failure, OrderDetailModel>> call(
    GetUseCaseOrderDetailParams? params,
  ) async {
    return await repository.getOrderDetail((parameters = params)!.id);
  }

  @override
  GetUseCaseOrderDetailParams? getParams() {
    return parameters = parameters ?? GetUseCaseOrderDetailParams(id: 0);
  }

  @override
  UseCase<OrderDetailModel, GetUseCaseOrderDetailParams> setParams(
      GetUseCaseOrderDetailParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<OrderDetailModel, GetUseCaseOrderDetailParams> setParamsFromMap(
      Map params) {
    parameters = GetUseCaseOrderDetailParams.fromMap(params);
    return this;
  }
}

class GetUseCaseOrderDetailParams extends Parametizable {
  final int id;
  GetUseCaseOrderDetailParams({required this.id}) : super();

  factory GetUseCaseOrderDetailParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseOrderDetailParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
