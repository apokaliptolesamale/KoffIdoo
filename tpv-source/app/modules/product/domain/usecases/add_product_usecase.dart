// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '/app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/product_repository.dart';

AddUseCaseProductParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseProductParams.fromMap(params);

class AddProductUseCase<ProductModel>
    implements UseCase<ProductModel, AddUseCaseProductParams> {
  final ProductRepository<ProductModel> repository;
  late AddUseCaseProductParams? parameters;

  AddProductUseCase(this.repository);

  @override
  Future<Either<Failure, ProductModel>> call(
    AddUseCaseProductParams? params,
  ) async {
    parameters = params ?? parameters;
    return await repository.add(parameters!.toJson());
  }

  @override
  AddUseCaseProductParams? getParams() {
    return parameters = parameters ?? AddUseCaseProductParams();
  }

  @override
  UseCase<ProductModel, AddUseCaseProductParams> setParams(
      AddUseCaseProductParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<ProductModel, AddUseCaseProductParams> setParamsFromMap(Map params) {
    parameters = AddUseCaseProductParams.fromMap(params);
    return this;
  }
}

class AddUseCaseProductParams extends Parametizable {
  String? code;

  String? idProduct;

  String? idOrder;

  String? idOrderService;

  String? name;

  String? description;

  String? shortDescription;

  double? regularPrice;

  double? salePrice;

  double? discount;

  bool? ifItemAvailable;

  bool? ifAddedToCart;

  int? stockQuantity;

  int? quantity;

  String? idWarranty;

  AddUseCaseProductParams({
    this.idProduct = "",
    this.code = "",
    this.name,
    this.description = "Sin descripción",
    this.idWarranty = "",
    this.idOrder = "-",
    this.shortDescription = "Sin descripción",
    this.regularPrice = 0.00,
    this.salePrice = 0.00,
    this.ifAddedToCart = false,
    this.stockQuantity = 0,
    this.ifItemAvailable = false,
    this.discount = 0.0,
    this.quantity = 0,
    this.idOrderService,
  }) : super();

  factory AddUseCaseProductParams.fromMap(Map<dynamic, dynamic> json) =>
      AddUseCaseProductParams(
        idProduct:
            EntityModel.getValueFromJson<String?>("idProduct", json, null),
        idOrderService:
            EntityModel.getValueFromJson<String?>("idOrderService", json, null),
        idWarranty: EntityModel.getValueFromJson("idWarranty", json, null),
        code: EntityModel.getValueFromJson<String?>("code", json, null),
        idOrder: EntityModel.getValueFromJson<String?>("idOrder", json, null),
        name: EntityModel.getValueFromJson<String?>("name", json, null),
        description:
            EntityModel.getValueFromJson<String?>("description", json, null),
        shortDescription:
            EntityModel.getValueFromJson<String?>("description", json, null),
        discount: EntityModel.getValueFromJson<double?>("discount", json, null,
            reader: ((key, data, defaultValue) {
          if (data.containsKey(key) && data[key] != null && data[key] != "") {
            return double.parse(data[key]);
          }
          return defaultValue;
        })),
        ifAddedToCart:
            EntityModel.getValueFromJson<bool>("ifAddedToCart", json, false),
        ifItemAvailable:
            EntityModel.getValueFromJson<bool>("ifItemAvailable", json, false),
        quantity: EntityModel.getValueFromJson<int?>("quantity", json, null,
            reader: ((key, data, defaultValue) {
          if (data.containsKey(key) && data[key] != null && data[key] != "") {
            return int.parse(data[key]);
          }
          return defaultValue;
        })),
        regularPrice: EntityModel.getValueFromJson<double?>(
            "regularPrice", json, null, reader: ((key, data, defaultValue) {
          if (data.containsKey(key) && data[key] != null && data[key] != "") {
            return double.parse(data[key]);
          }
          return defaultValue;
        })),
        salePrice: EntityModel.getValueFromJson<double?>(
            "salePrice", json, null, reader: ((key, data, defaultValue) {
          if (data.containsKey(key) && data[key] != null && data[key] != "") {
            return double.parse(data[key]);
          }
          return defaultValue;
        })),
        stockQuantity: EntityModel.getValueFromJson<int?>(
            "stockQuantity", json, null, reader: ((key, data, defaultValue) {
          if (data.containsKey(key) && data[key] != null && data[key] != "") {
            return int.parse(data[key]);
          }
          return defaultValue;
        })),
      );

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {
        "idProduct": idProduct,
        "idWarranty": idWarranty,
        "code": code,
        "idOrder": idOrder,
        "name": name,
        "description": description,
        "idOrderService": idOrderService,
      };
}
