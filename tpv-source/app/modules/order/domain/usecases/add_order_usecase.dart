// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../../order/domain/models/order_model.dart';
import '../../../order/domain/repository/order_repository.dart';

AddUseCaseOrderParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseOrderParams.fromMap(params);

class AddOrderUseCase<EntityModel extends OrderModel>
    implements UseCase<EntityModel, AddUseCaseOrderParams> {
  final OrderRepository<EntityModel> repository;
  late AddUseCaseOrderParams? parameters;

  AddOrderUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModel>> call(
    AddUseCaseOrderParams? params,
  ) async {
    return await repository.add(params ?? getParams()!.toJson());
  }

  @override
  AddUseCaseOrderParams? getParams() {
    return parameters = parameters ?? AddUseCaseOrderParams.fromMap({});
  }

  @override
  UseCase<EntityModel, AddUseCaseOrderParams> setParams(
      AddUseCaseOrderParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModel, AddUseCaseOrderParams> setParamsFromMap(Map params) {
    parameters = AddUseCaseOrderParams.fromMap(params);
    return this;
  }
}

class AddUseCaseOrderParams extends Parametizable {
  final String id;
  final String idOrder;
  final String? pin;
  final String number;
  final String address;
  final String status;
  final String? qrCode;
  final String? userName;
  final String? beneficiary;

  AddUseCaseOrderParams(
      {required this.id,
      required this.idOrder,
      required this.number,
      required this.address,
      required this.status,
      this.qrCode,
      this.beneficiary,
      this.pin,
      this.userName})
      : super();

  factory AddUseCaseOrderParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCaseOrderParams(
        id: params.containsKey("id") ? params["id"] : "-1",
        idOrder: params.containsKey("idOrder") ? params["idOrder"] : "-1",
        beneficiary: params.containsKey("beneficiary")
            ? params["beneficiary"]
            : "Sin beneficiario",
        pin: params.containsKey("pin") ? params["pin"] : "-1",
        userName:
            params.containsKey("userName") ? params["userName"] : "Sin usuario",
        number: params.containsKey("number") ? params["number"] : "Sin número",
        address:
            params.containsKey("address") ? params["address"] : "Sin dirección",
        status: params.containsKey("status") ? params["status"] : "Desconocido",
        qrCode: params.containsKey("qrCode") ? params["qrCode"] : "Sin Qr",
      );

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "idOrder": idOrder,
        "beneficiary": beneficiary,
        "pin": pin,
        "userName": userName,
        "number": number,
        "address": address,
        "status": status,
        "qrCode": qrCode,
      };
}
