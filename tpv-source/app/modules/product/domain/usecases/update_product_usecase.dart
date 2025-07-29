// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '/app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/product_model.dart';
import '../repository/product_repository.dart';

class UpdateProductUseCase<ProductModelEntity extends ProductModel>
    implements UseCase<ProductModelEntity, UpdateUseCaseProductParams> {
  final ProductRepository<ProductModelEntity> repository;
  late UpdateUseCaseProductParams? parameters;
  UpdateProductUseCase(this.repository);

  @override
  Future<Either<Failure, ProductModelEntity>> call(
    UpdateUseCaseProductParams? params,
  ) async {
    parameters = params ?? parameters;
    return await repository.update(parameters!.id, parameters!.entity);
  }

  @override
  UpdateUseCaseProductParams? getParams() {
    return parameters = parameters ??
        UpdateUseCaseProductParams(
            id: 0, entity: ProductModel(name: "", idOrderService: ""));
  }

  @override
  UseCase<ProductModelEntity, UpdateUseCaseProductParams> setParams(
      UpdateUseCaseProductParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<ProductModelEntity, UpdateUseCaseProductParams> setParamsFromMap(
      Map params) {
    parameters = UpdateUseCaseProductParams.fromMap(params);
    return this;
  }
}

class UpdateUseCaseProductParams extends Parametizable {
  final dynamic id;
  final dynamic code;
  final ProductModel entity;
  UpdateUseCaseProductParams({
    required this.id,
    required this.entity,
    this.code,
  }) : super();

  factory UpdateUseCaseProductParams.fromMap(Map<dynamic, dynamic> params) =>
      UpdateUseCaseProductParams(
        id: getValueFrom("id", params, ""),
        code: getValueFrom("code", params, ""),
        entity: getValueFrom(
          "entity",
          params,
          ProductModel.fromJson({}),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              if (data[key] is ProductModel) {
                return data[key];
              } else if (data[key] is Map) {
                return ProductModel.fromJson(data[key]);
              }
            }
            return defaultValue;
          },
        ),
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "entity": entity.toJson(),
      };

  static T getValueFrom<T>(
      String key, Map<dynamic, dynamic> json, T defaultValue,
      {JsonReader<T>? reader}) {
    return EntityModel.getValueFromJson<T>(key, json, defaultValue,
        reader: reader);
  }
}
