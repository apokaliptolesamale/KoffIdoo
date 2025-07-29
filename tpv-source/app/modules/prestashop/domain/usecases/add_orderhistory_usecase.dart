// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '/app/core/services/logger_service.dart';
import '/app/modules/prestashop/domain/models/orderhistory_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/config/errors/exceptions.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/orderhistory_repository.dart';

AddUseCaseOrderHistoryParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseOrderHistoryParams.fromMap(params);

class AddOrderHistoryUseCase<OrderHistoryModel>
    implements UseCase<OrderHistoryModel, AddUseCaseOrderHistoryParams> {
  final OrderHistoryRepository<OrderHistoryModel> repository;
  late AddUseCaseOrderHistoryParams? parameters;

  AddOrderHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, OrderHistoryModel>> call(
    AddUseCaseOrderHistoryParams? params,
  ) async {
    parameters = params ?? parameters;
    if (parameters != null) {
      log(parameters!.toJson());
      return await repository.add(parameters!.toJson());
    } else {
      return Future.value(Left(
          EmptyParamsFailure(message: "Error por parámetros nulos o vacíos.")));
    }
  }

  @override
  AddUseCaseOrderHistoryParams? getParams() {
    return parameters = parameters ?? AddUseCaseOrderHistoryParams(id: 0);
  }

  @override
  UseCase<OrderHistoryModel, AddUseCaseOrderHistoryParams> setParams(
      AddUseCaseOrderHistoryParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<OrderHistoryModel, AddUseCaseOrderHistoryParams> setParamsFromMap(
      Map params) {
    parameters = AddUseCaseOrderHistoryParams.fromMap(params);
    return this;
  }
}

class AddUseCaseOrderHistoryParams extends Parametizable {
  final dynamic id, idEmployee, idOrderState, idOrder, dateAdd;

  AddUseCaseOrderHistoryParams(
      {this.id, this.dateAdd, this.idEmployee, this.idOrder, this.idOrderState})
      : super();

  factory AddUseCaseOrderHistoryParams.fromMap(Map<dynamic, dynamic> params) {
    if (params.containsKey("entity") && params["entity"] is Map) {
      params["entity"] = OrderHistoryModel.fromJson(params["entity"]);
    }
    if (params.containsKey("entity") && params["entity"] is OrderHistoryModel) {
      final orderHistory = (params["entity"] as OrderHistoryModel);
      return AddUseCaseOrderHistoryParams(
        id: orderHistory.id,
        dateAdd: orderHistory.dateAdd,
        idEmployee: orderHistory.idEmployee,
        idOrder: orderHistory.idOrder,
        idOrderState: orderHistory.idOrderState,
      );
    }
    throw RequiredTypeErrorException();
  }

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "dateAdd": dateAdd,
        "idEmployee": idEmployee,
        "idOrder": idOrder,
        "idOrderState": idOrderState,
      };
}
