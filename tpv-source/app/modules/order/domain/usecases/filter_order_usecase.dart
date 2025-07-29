// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../../order/domain/models/order_model.dart';
import '../../../order/domain/repository/order_repository.dart';

FilterUseCaseOrderParams filterUseCaseOrderParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseOrderParams.fromMap(params);

class FilterOrderUseCase<EntityModel extends OrderModel>
    implements UseCase<EntityModelList<EntityModel>, FilterUseCaseOrderParams> {
  final OrderRepository<EntityModel> repository;
  FilterUseCaseOrderParams? parameters = FilterUseCaseOrderParams();

  FilterOrderUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<EntityModel>>> call(
    FilterUseCaseOrderParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<EntityModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseOrderParams? getParams() {
    return parameters = parameters ?? FilterUseCaseOrderParams();
  }

  @override
  UseCase<EntityModelList<EntityModel>, FilterUseCaseOrderParams> setParams(
      FilterUseCaseOrderParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<EntityModel>, FilterUseCaseOrderParams>
      setParamsFromMap(Map params) {
    parameters = FilterUseCaseOrderParams.fromMap(params);
    return this;
  }
}

class FilterUseCaseOrderParams extends Parametizable {
  String? id;
  String? idOrder;
  String? pin;
  String? address;
  List<String>? status;
  String? qrCode;
  String? userName;
  String? beneficiary;

  int? start;
  int? limit;

  FilterUseCaseOrderParams(
      {this.id,
      this.idOrder,
      this.address,
      this.status,
      this.qrCode,
      this.beneficiary,
      this.pin,
      this.userName,
      this.limit,
      this.start})
      : super();

  factory FilterUseCaseOrderParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCaseOrderParams(
        id: params.containsKey("id") ? params["id"] : "",
        idOrder: params.containsKey("idOrder") ? params["idOrder"] : "",
        pin: params.containsKey("pin") ? params["pin"] : "",
        address: params.containsKey("address") ? params["address"] : "",
        status: params.containsKey("status")
            ? List<String>.from(params["status"])
            : [],
        userName: params.containsKey("userName") ? params["userName"] : "",
        qrCode: params.containsKey("qrCode") ? params["qrCode"] : "",
        beneficiary:
            params.containsKey("beneficiary") ? params["beneficiary"] : "",
        start: params.containsKey("start") ? params["start"] : 0,
        limit: params.containsKey("limit") ? params["limit"] : 20,
      );

  FilterUseCaseOrderParams addStatus(List<String> status) {
    this.status =
        this.status == null || this.status != null && this.status!.isEmpty
            ? List.empty(growable: true)
            : this.status;
    for (var element in status) {
      this.status!.addIf(!this.status!.contains(element), element);
    }
    return this;
  }

  @override
  bool isValid() {
    return true;
  }

  FilterUseCaseOrderParams setAddress(String address) {
    this.address = address;
    return this;
  }

  FilterUseCaseOrderParams setBeneficiary(String beneficiary) {
    this.beneficiary = beneficiary;
    return this;
  }

  FilterUseCaseOrderParams setCount(int count) {
    limit = count;
    return this;
  }

  FilterUseCaseOrderParams setId(String id) {
    this.id = id;
    return this;
  }

  FilterUseCaseOrderParams setIdOrder(String idOrder) {
    this.idOrder = idOrder;
    return this;
  }

  FilterUseCaseOrderParams setPage(int page) {
    start = page;
    return this;
  }

  FilterUseCaseOrderParams setPin(String pin) {
    this.pin = pin;
    return this;
  }

  FilterUseCaseOrderParams setQrCode(String qrCode) {
    this.qrCode = qrCode;
    return this;
  }

  FilterUseCaseOrderParams setStatus(List<String> status) {
    this.status = status;
    return this;
  }

  FilterUseCaseOrderParams setUserName(String userName) {
    this.userName = userName;
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final map = {
      "id": id,
      "idOrder": idOrder,
      "pin": pin,
      "address": address,
      "status": status,
      "userName": userName,
      "qrCode": qrCode,
      "beneficiary": beneficiary,
      "page": start,
      "count": limit
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  bool _validate<T>(T? value) {
    return value != null;
  }
}
