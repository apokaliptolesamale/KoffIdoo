import 'package:dartz/dartz.dart';

import '/app/modules/order/domain/repository/product_repository.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/filter_model.dart';

// GetAllProductsByFilterUseCaseParams filterUseCaseTpvParamsFromMap(
//         Map<dynamic, dynamic> params) =>
//     GetAllProductsByFilterUseCaseParams.fromMap(params);

class GetAllProductsByFilterUseCase<ProductModel>
    implements
        UseCase<EntityModelList<ProductModel>,
            GetAllProductsByFilterUseCaseParams> {
  final ProductRepository<ProductModel> repository;
  late GetAllProductsByFilterUseCaseParams? parameters;

  GetAllProductsByFilterUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<ProductModel>>> call(
    GetAllProductsByFilterUseCaseParams? params,
  ) async {
    params = params ?? getParams();
    return await repository.filter(params!.params);
    // return (parameters = params)!.isValid()
    //     ? await repository.getAll(parameters!.toJson())
    //     : await Future.value(Left(InvalidParamsFailure(
    //         message:
    //             "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<ProductModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  GetAllProductsByFilterUseCaseParams? getParams() {
    return parameters = parameters ??
        GetAllProductsByFilterUseCaseParams(params: FilterModel());
  }

  @override
  UseCase<EntityModelList<ProductModel>, GetAllProductsByFilterUseCaseParams>
      setParams(GetAllProductsByFilterUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<ProductModel>, GetAllProductsByFilterUseCaseParams>
      setParamsFromMap(Map params) {
    // parameters = GetAllProductsByFilterUseCaseParams.fromMap(params);
    parameters = GetAllProductsByFilterUseCaseParams(
      params: FilterModel.fromJson(
          params.map((key, value) => MapEntry(key.toString(), value))),
    );
    return this;
  }
}

class GetAllProductsByFilterUseCaseParams extends Parametizable {
  final dynamic params;
  // String? id;
  // String? imei;
  // String? marca;
  // String? modelo;
  // String? type;
  // String? comercio;
  // String? status;
  // int start = 1;
  // int limit = 20;

  GetAllProductsByFilterUseCaseParams(
      {
      // this.id,
      // this.imei,
      // this.marca,
      // this.modelo,
      // this.type,
      // this.comercio,
      // this.status,
      required this.params})
      : super();

  // factory GetAllProductsByFilterUseCaseParams.fromMap(Map<dynamic, dynamic> json) =>
  //     GetAllProductsByFilterUseCaseParams(
  //       // id: EntityModel.getValueFromJson("id", json, ""),
  //       // imei: EntityModel.getValueFromJson("imei", json, ""),
  //       // marca: EntityModel.getValueFromJson("marca", json, ""),
  //       // modelo: EntityModel.getValueFromJson("modelo", json, ""),
  //       // type: EntityModel.getValueFromJson("type", json, ""),
  //       // comercio: EntityModel.getValueFromJson("comercio", json, ""),
  //     );

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  // @override
  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "imei": imei,
  //       "marca": marca,
  //       "modelo": modelo,
  //       "type": type,
  //       "comercio": comercio,
  //       "status": status
  //     };

  // bool _validate<T>(T? value) {
  //   return value != null;
  // }
}
