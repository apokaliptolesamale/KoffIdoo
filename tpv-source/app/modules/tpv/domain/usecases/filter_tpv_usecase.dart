// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/tpv_repository.dart';

FilterUseCaseTpvParams filterUseCaseTpvParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseTpvParams.fromMap(params);

class FilterTpvUseCase<TpvModel>
    implements UseCase<EntityModelList<TpvModel>, FilterUseCaseTpvParams> {
  final TpvRepository<TpvModel> repository;
  FilterUseCaseTpvParams? parameters;

  FilterTpvUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<TpvModel>>> call(
    FilterUseCaseTpvParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<TpvModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseTpvParams? getParams() {
    return parameters = parameters ?? FilterUseCaseTpvParams();
  }

  @override
  UseCase<EntityModelList<TpvModel>, FilterUseCaseTpvParams> setParams(
      FilterUseCaseTpvParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<TpvModel>, FilterUseCaseTpvParams> setParamsFromMap(
      Map params) {
    parameters = FilterUseCaseTpvParams.fromMap(params);
    return this;
  }
}

class FilterUseCaseTpvParams extends Parametizable {
  String? id;
  String? imei;
  String? marca;
  String? modelo;
  String? type;
  String? comercio;
  String? status;
  int start = 1;
  int limit = 20;

  FilterUseCaseTpvParams({
    this.id,
    this.imei,
    this.marca,
    this.modelo,
    this.type,
    this.comercio,
    this.status,
  }) : super();

  factory FilterUseCaseTpvParams.fromMap(Map<dynamic, dynamic> json) =>
      FilterUseCaseTpvParams(
        id: EntityModel.getValueFromJson("id", json, ""),
        imei: EntityModel.getValueFromJson("imei", json, ""),
        marca: EntityModel.getValueFromJson("marca", json, ""),
        modelo: EntityModel.getValueFromJson("modelo", json, ""),
        type: EntityModel.getValueFromJson("type", json, ""),
        comercio: EntityModel.getValueFromJson("comercio", json, ""),
      );

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "imei": imei,
        "marca": marca,
        "modelo": modelo,
        "type": type,
        "comercio": comercio,
        "status": status
      };

  bool _validate<T>(T? value) {
    return value != null;
  }
}
