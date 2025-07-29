// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '/app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/tpv_repository.dart';

AddUseCaseTpvParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseTpvParams.fromMap(params);

class AddTpvUseCase<TpvModel>
    implements UseCase<TpvModel, AddUseCaseTpvParams> {
  final TpvRepository<TpvModel> repository;
  late AddUseCaseTpvParams? parameters;

  AddTpvUseCase(this.repository);

  @override
  Future<Either<Failure, TpvModel>> call(
    AddUseCaseTpvParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.add(params ?? parameters);
  }

  @override
  AddUseCaseTpvParams? getParams() {
    return parameters = parameters ?? AddUseCaseTpvParams();
  }

  @override
  UseCase<TpvModel, AddUseCaseTpvParams> setParams(AddUseCaseTpvParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<TpvModel, AddUseCaseTpvParams> setParamsFromMap(Map params) {
    parameters = AddUseCaseTpvParams.fromMap(params);
    return this;
  }
}

class AddUseCaseTpvParams extends Parametizable {
  String? id;
  String? imei;
  String? marca;
  String? modelo;
  String? type;
  String? comercio;
  String? status;
  AddUseCaseTpvParams({
    this.id,
    this.imei,
    this.marca,
    this.modelo,
    this.type,
    this.comercio,
    this.status,
  });

  factory AddUseCaseTpvParams.fromMap(Map<dynamic, dynamic> json) =>
      AddUseCaseTpvParams(
        id: EntityModel.getValueFromJson("id", json, ""),
        imei: EntityModel.getValueFromJson("imei", json, ""),
        marca: EntityModel.getValueFromJson("marca", json, ""),
        modelo: EntityModel.getValueFromJson("modelo", json, ""),
        type: EntityModel.getValueFromJson("type", json, ""),
        comercio: EntityModel.getValueFromJson("comercio", json, ""),
        status: EntityModel.getValueFromJson("status", json, ""),
      );

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
