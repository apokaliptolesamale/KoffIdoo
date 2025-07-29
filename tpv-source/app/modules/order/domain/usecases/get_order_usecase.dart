// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../../order/domain/models/order_model.dart';
import '../../../order/domain/repository/order_repository.dart';

GetUseCaseOrderParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseOrderParams.fromMap(params);

class GetOrderUseCase<EntityModel extends OrderModel>
    implements UseCase<EntityModel, GetUseCaseOrderParams> {
  final OrderRepository<EntityModel> repository;
  late GetUseCaseOrderParams? parameters;

  GetOrderUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModel>> call(
    GetUseCaseOrderParams? params,
  ) async {
    parameters = params ?? parameters;
    return await repository.getOrder(parameters!.id);
  }

  @override
  GetUseCaseOrderParams? getParams() {
    return parameters = parameters ?? GetUseCaseOrderParams();
  }

  @override
  UseCase<EntityModel, GetUseCaseOrderParams> setParams(
      GetUseCaseOrderParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModel, GetUseCaseOrderParams> setParamsFromMap(Map params) {
    parameters = GetUseCaseOrderParams.fromMap(params);
    return this;
  }
}

class GetUseCaseOrderParams extends Parametizable {
  final String? id;
  GetUseCaseOrderParams({this.id}) : super();

  factory GetUseCaseOrderParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseOrderParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
