// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/qrcode_repository.dart';

FilterUseCaseQrCodeParams filterUseCaseQrCodeParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseQrCodeParams.fromMap(params);

class FilterQrCodeUseCase<QrCodeModel>
    implements
        UseCase<EntityModelList<QrCodeModel>, FilterUseCaseQrCodeParams> {
  final QrCodeRepository<QrCodeModel> repository;
  FilterUseCaseQrCodeParams? parameters;

  FilterQrCodeUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<QrCodeModel>>> call(
    FilterUseCaseQrCodeParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<QrCodeModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseQrCodeParams? getParams() {
    return parameters = parameters ?? FilterUseCaseQrCodeParams();
  }

  @override
  UseCase<EntityModelList<QrCodeModel>, FilterUseCaseQrCodeParams> setParams(
      FilterUseCaseQrCodeParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<QrCodeModel>, FilterUseCaseQrCodeParams>
      setParamsFromMap(Map params) {
    parameters = FilterUseCaseQrCodeParams.fromMap(params);
    return this;
  }
}

class FilterUseCaseQrCodeParams extends Parametizable {
  final String? idqrcode; // id de el caso

  int start = 1;
  int limit = 20;

  FilterUseCaseQrCodeParams({
    this.idqrcode,
  }) : super();

  factory FilterUseCaseQrCodeParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCaseQrCodeParams(
          idqrcode: params.containsKey("idqrcode") ? params["idqrcode"] : "");

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"idqrcode": idqrcode};

  bool _validate<T>(T? value) {
    return value != null;
  }
}
