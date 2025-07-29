// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/warranty_repository.dart';

FilterUseCaseWarrantyParams filterUseCaseWarrantyParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseWarrantyParams.fromMap(
        params.map((key, value) => MapEntry(key, value)));

class FilterUseCaseWarrantyParams extends Parametizable {
  String? warrantyId;
  String? firstSerialNumber;
  String? secondSerialNumber;
  int? code;
  String? article;
  double? price;
  String? tradeName;
  String? province;
  String? mark;
  String? ci;
  DateTime? time;
  DateTime? createdAt;
  String? paymentType;
  String? clientName;
  String? email;
  String? phoneNumber;
  DateTime? updatedAt;
  String? status;
  String? model;
  String? folio;
  String? qrCode;
  String? seller;

  int? page;
  int? count;

  FilterUseCaseWarrantyParams({
    this.warrantyId,
    this.firstSerialNumber,
    this.secondSerialNumber,
    int? code,
    this.article,
    double? price,
    this.tradeName,
    this.province,
    this.mark,
    this.ci,
    DateTime? time,
    DateTime? createdAt,
    this.paymentType,
    this.clientName,
    this.email,
    this.phoneNumber,
    DateTime? updatedAt,
    this.status,
    this.model,
    this.folio,
    this.qrCode,
    this.seller,
    this.page,
    this.count,
  }) : super();

  factory FilterUseCaseWarrantyParams.fromMap(Map<String, dynamic> json) =>
      FilterUseCaseWarrantyParams(
        warrantyId: getValueFrom("warrantyId", json, null),
        firstSerialNumber: getValueFrom("firstSerialNumber", json, null),
        secondSerialNumber: getValueFrom("secondSerialNumber", json, null),
        code: getValueFrom("code", json, null),
        article: getValueFrom("article", json, null),
        price: getValueFrom("price", json, null),
        tradeName: getValueFrom("tradeName", json, null),
        province: getValueFrom("province", json, null),
        mark: getValueFrom("mark", json, null),
        ci: getValueFrom("ci", json, null),
        time: getValueFrom("time", json, null),
        createdAt: getValueFrom("createdAt", json, null),
        paymentType: getValueFrom("paymentType", json, null),
        clientName: getValueFrom("clientName", json, null),
        email: getValueFrom("email", json, null),
        phoneNumber: getValueFrom("phoneNumber", json, null),
        updatedAt: getValueFrom("updatedAt", json, null),
        status: getValueFrom("status", json, null),
        model: getValueFrom("model", json, null),
        folio: getValueFrom("folio", json, null),
        qrCode: getValueFrom("qrCode", json, null),
        seller: getValueFrom("seller", json, null),
        page: getValueFrom("page", json, null),
        count: getValueFrom("count", json, null),
      );

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  FilterUseCaseWarrantyParams setArticle(String? article) {
    this.article = article;
    return this;
  }

  FilterUseCaseWarrantyParams setCi(String? ci) {
    this.ci = ci;
    return this;
  }

  FilterUseCaseWarrantyParams setClientName(String? clientName) {
    this.clientName = clientName;
    return this;
  }

  FilterUseCaseWarrantyParams setCode(int? code) {
    this.code = code;
    return this;
  }

  FilterUseCaseWarrantyParams setCount(int count) {
    this.count = count;
    return this;
  }

  FilterUseCaseWarrantyParams setCreatedAt(DateTime? createdAt) {
    this.createdAt = createdAt;
    return this;
  }

  FilterUseCaseWarrantyParams setEmail(String? email) {
    this.email = email;
    return this;
  }

  FilterUseCaseWarrantyParams setFirstSerialNumber(String? firstSerialNumber) {
    this.firstSerialNumber = firstSerialNumber;
    return this;
  }

  FilterUseCaseWarrantyParams setFolio(String? folio) {
    this.folio = folio;
    return this;
  }

  FilterUseCaseWarrantyParams setMark(String? mark) {
    this.mark = mark;
    return this;
  }

  FilterUseCaseWarrantyParams setModel(String? model) {
    this.model = model;
    return this;
  }

  FilterUseCaseWarrantyParams setPage(int page) {
    this.page = page;
    return this;
  }

  FilterUseCaseWarrantyParams setPaymentType(String? paymentType) {
    this.paymentType = paymentType;
    return this;
  }

  FilterUseCaseWarrantyParams setPhoneNumber(String? phoneNumber) {
    this.phoneNumber = phoneNumber;
    return this;
  }

  FilterUseCaseWarrantyParams setPrice(double? price) {
    this.price = price;
    return this;
  }

  FilterUseCaseWarrantyParams setProvince(String? province) {
    this.province = province;
    return this;
  }

  FilterUseCaseWarrantyParams setQrCode(String? qrCode) {
    this.qrCode = qrCode;
    return this;
  }

  FilterUseCaseWarrantyParams setSecondSerialNumber(
      String? secondSerialNumber) {
    this.secondSerialNumber = secondSerialNumber;
    return this;
  }

  FilterUseCaseWarrantyParams setSeller(String? seller) {
    this.seller = seller;
    return this;
  }

  FilterUseCaseWarrantyParams setStatus(String? status) {
    this.status = status;
    return this;
  }

  FilterUseCaseWarrantyParams setTime(DateTime? time) {
    this.time = time;
    return this;
  }

  FilterUseCaseWarrantyParams setTradeName(String? tradeName) {
    this.tradeName = tradeName;
    return this;
  }

  FilterUseCaseWarrantyParams setUpdatedAt(DateTime? updatedAt) {
    this.updatedAt = updatedAt;
    return this;
  }

  FilterUseCaseWarrantyParams setWarrantyId(String? warrantyId) {
    this.warrantyId = warrantyId;
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> tmp = {
      "warrantyId": warrantyId,
      "firstSerialNumber": firstSerialNumber,
      "secondSerialNumber": secondSerialNumber,
      "code": code,
      "article": article,
      "price": price,
      "tradeName": tradeName,
      "province": province,
      "mark": mark,
      "ci": ci,
      "time": time,
      "createdAt": createdAt,
      "paymentType": paymentType,
      "clientName": clientName,
      "email": email,
      "phoneNumber": phoneNumber,
      "updatedAt": updatedAt,
      "status": status,
      "model": model,
      "folio": folio,
      "qrCode": qrCode,
      "seller": seller,
      "page": page,
      "count": count,
    };
    tmp.removeWhere((key, value) => value == null);
    return tmp;
  }

  bool _validate<T>(T? value) {
    return value != null;
  }

  static T? getValueFrom<T>(
      String key, Map<dynamic, dynamic> json, T? defaultValue,
      {JsonReader<T?>? reader}) {
    return EntityModel.getValueFromJson<T?>(key, json, defaultValue,
        reader: reader);
  }
}

class FilterWarrantyUseCase<WarrantyModel>
    implements
        UseCase<EntityModelList<WarrantyModel>, FilterUseCaseWarrantyParams> {
  final WarrantyRepository<WarrantyModel> repository;
  FilterUseCaseWarrantyParams? parameters;

  FilterWarrantyUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<WarrantyModel>>> call(
    FilterUseCaseWarrantyParams? params,
  ) async {
    parameters = params ?? parameters;
    return parameters!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<WarrantyModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseWarrantyParams? getParams() {
    return parameters = parameters ?? FilterUseCaseWarrantyParams();
  }

  @override
  UseCase<EntityModelList<WarrantyModel>, FilterUseCaseWarrantyParams>
      setParams(FilterUseCaseWarrantyParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<WarrantyModel>, FilterUseCaseWarrantyParams>
      setParamsFromMap(Map params) {
    parameters = FilterUseCaseWarrantyParams.fromMap(
        params.map((key, value) => MapEntry(key.toString(), value)));

    return this;
  }
}
