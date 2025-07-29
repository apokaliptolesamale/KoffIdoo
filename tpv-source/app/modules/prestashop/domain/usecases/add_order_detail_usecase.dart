// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/order_detail_repository.dart';

AddUseCaseOrderDetailParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseOrderDetailParams.fromMap(params);

class AddOrderDetailUseCase<OrderDetailModel>
    implements UseCase<OrderDetailModel, AddUseCaseOrderDetailParams> {
  final OrderDetailRepository<OrderDetailModel> repository;
  late AddUseCaseOrderDetailParams? parameters;

  AddOrderDetailUseCase(this.repository);

  @override
  Future<Either<Failure, OrderDetailModel>> call(
    AddUseCaseOrderDetailParams? params,
  ) async {
    return await repository.add(parameters = params);
  }

  @override
  AddUseCaseOrderDetailParams? getParams() {
    return parameters = parameters ?? AddUseCaseOrderDetailParams(id: 0);
  }

  @override
  UseCase<OrderDetailModel, AddUseCaseOrderDetailParams> setParams(
      AddUseCaseOrderDetailParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<OrderDetailModel, AddUseCaseOrderDetailParams> setParamsFromMap(
      Map params) {
    parameters = AddUseCaseOrderDetailParams.fromMap(params);
    return this;
  }
}

class AddUseCaseOrderDetailParams extends Parametizable {
  final int id;
  AddUseCaseOrderDetailParams({required this.id}) : super();

  factory AddUseCaseOrderDetailParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCaseOrderDetailParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
