// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '/app/core/interfaces/entity_model.dart';
import '/app/widgets/utils/custom_datetime_converter.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/warranty_repository.dart';

AddUseCaseWarrantyParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseWarrantyParams.fromMap(params);

class AddUseCaseWarrantyParams extends Parametizable {
  final String? firstSerialNumber;
  final String? secondSerialNumber;
  final int? code;
  final String? article;
  final double? price;
  final String? tradeName;
  final String? province;
  final String? mark;
  final String? ci;
  final int? warrantyTime;
  final DateTime? createdAt;
  final String? paymentType;
  final String? clientName;
  final String? email;
  final String? phoneNumber;
  final DateTime? updatedAt;
  final DateTime? time;
  final String? status;
  final String? model;
  final String? folio;
  final String? seller;
  final String? address;

  AddUseCaseWarrantyParams({
    this.firstSerialNumber,
    this.secondSerialNumber,
    this.code,
    this.article,
    this.price,
    this.tradeName,
    this.province,
    this.mark,
    this.ci,
    this.warrantyTime,
    this.time,
    this.createdAt,
    this.paymentType,
    this.clientName,
    this.email,
    this.phoneNumber,
    this.updatedAt,
    //final String? qrWarranty;
    this.status,
    this.model,
    this.folio,
    this.seller,
    this.address,
  }) : super();

  factory AddUseCaseWarrantyParams.fromMap(Map<dynamic, dynamic> json) {
    return AddUseCaseWarrantyParams(
      firstSerialNumber: EntityModel.getValueFromJson<String?>(
          "firstSerialNumber", json, null),
      secondSerialNumber: EntityModel.getValueFromJson<String?>(
          "secondSerialNumber", json, null),
      code: EntityModel.getValueFromJson<int>("code", json, 0,
          reader: (key, data, dv) {
        return data.isNotEmpty && data.containsKey(key) && data[key] != null
            ? int.parse(data[key])
            : dv;
      }),
      article: EntityModel.getValueFromJson<String?>("article", json, null),
      price: EntityModel.getValueFromJson<double?>("price", json, 0.0,
          reader: (key, data, dv) {
        return data.isNotEmpty && data.containsKey(key) && data[key] != null
            ? double.parse(data[key].toString())
            : dv;
      }),
      tradeName: EntityModel.getValueFromJson<String?>("tradeName", json, null),
      province: EntityModel.getValueFromJson<String?>("province", json, null),
      mark: EntityModel.getValueFromJson<String?>("mark", json, null),
      ci: EntityModel.getValueFromJson<String?>("ci", json, null),
      warrantyTime: EntityModel.getValueFromJson<int?>(
          "warrantyTime", json, null, reader: (key, data, dv) {
        return data.isNotEmpty && data.containsKey(key) && data[key] != null
            ? int.parse(data[key].toString())
            : dv;
      }),
      createdAt: EntityModel.getValueFromJson<DateTime?>(
          "createdAt", json, null, reader: (key, data, dv) {
        return data.isNotEmpty && data.containsKey(key) && data[key] != null
            ? CustomDateTimeConverter.from(data[key].toString())
            : dv;
      }),
      time: EntityModel.getValueFromJson<DateTime?>("time", json, null,
          reader: (key, data, dv) {
        return data.isNotEmpty && data.containsKey(key) && data[key] != null
            ? CustomDateTimeConverter.from(data[key].toString())
            : dv;
      }),
      paymentType:
          EntityModel.getValueFromJson<String?>("paymentType", json, null),
      clientName:
          EntityModel.getValueFromJson<String?>("clientName", json, null),
      email: EntityModel.getValueFromJson<String?>("email", json, null),
      phoneNumber:
          EntityModel.getValueFromJson<String?>("phoneNumber", json, null),
      updatedAt: EntityModel.getValueFromJson<DateTime?>(
          "updatedAt", json, null, reader: (key, data, dv) {
        return data.isNotEmpty && data.containsKey(key) && data[key] != null
            ? CustomDateTimeConverter.from(data[key].toString())
            : dv;
      }),
      status: EntityModel.getValueFromJson<String?>("status", json, null),
      model: EntityModel.getValueFromJson<String?>("model", json, null),
      folio: EntityModel.getValueFromJson<String?>("folio", json, null),
      seller: EntityModel.getValueFromJson<String?>("seller", json, null),
      address: EntityModel.getValueFromJson<String?>("address", json, null),
    );
  }

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "firstSerialNumber": firstSerialNumber,
      "secondSerialNumber": secondSerialNumber,
      "code": code,
      "article": article,
      "price": price,
      "tradeName": tradeName,
      "province": province,
      "mark": mark,
      "ci": ci,
      "warrantyTime": warrantyTime ?? '',
      "createdAt": createdAt != null ? createdAt!.toIso8601String() : "",
      "time": time != null ? time!.toIso8601String() : "",
      "paymentType": paymentType,
      "clientName": clientName,
      "email": email,
      "phoneNumber": phoneNumber,
      "status": status,
      "model": model,
      "folio": folio,
      "seller": seller,
      "address": address,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}

class AddWarrantyUseCase<WarrantyModel>
    implements UseCase<WarrantyModel, AddUseCaseWarrantyParams> {
  final WarrantyRepository<WarrantyModel> repository;
  late AddUseCaseWarrantyParams? parameters;

  AddWarrantyUseCase(this.repository);

  @override
  Future<Either<Failure, WarrantyModel>> call(
    AddUseCaseWarrantyParams? params,
  ) async {
    return await repository.add(params ?? getParams());
  }

  @override
  AddUseCaseWarrantyParams? getParams() =>
      parameters ?? AddUseCaseWarrantyParams();

  @override
  UseCase<WarrantyModel, AddUseCaseWarrantyParams> setParams(
      AddUseCaseWarrantyParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<WarrantyModel, AddUseCaseWarrantyParams> setParamsFromMap(
      Map params) {
    parameters = AddUseCaseWarrantyParams.fromMap(params);
    return this;
  }
}
