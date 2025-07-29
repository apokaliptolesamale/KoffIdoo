// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/prestashop_repository.dart';

FilterUseCasePrestaShopParams filterUseCasePrestaShopParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCasePrestaShopParams.fromMap(params);

class FilterPrestaShopUseCase<PrestaShopModel>
    implements
        UseCase<EntityModelList<PrestaShopModel>,
            FilterUseCasePrestaShopParams> {
  final PrestaShopRepository<PrestaShopModel> repository;
  FilterUseCasePrestaShopParams? parameters;

  FilterPrestaShopUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<PrestaShopModel>>> call(
    FilterUseCasePrestaShopParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<PrestaShopModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCasePrestaShopParams? getParams() {
    return parameters = parameters ?? FilterUseCasePrestaShopParams();
  }

  @override
  UseCase<EntityModelList<PrestaShopModel>, FilterUseCasePrestaShopParams>
      setParams(FilterUseCasePrestaShopParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<PrestaShopModel>, FilterUseCasePrestaShopParams>
      setParamsFromMap(Map params) {
    parameters = FilterUseCasePrestaShopParams.fromMap(params);
    return this;
  }
}

class FilterUseCasePrestaShopParams extends Parametizable {
  final String? idprestashop; // id de el caso

  int start = 1;
  int limit = 20;

  FilterUseCasePrestaShopParams({
    this.idprestashop,
  }) : super();

  factory FilterUseCasePrestaShopParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCasePrestaShopParams(
          idprestashop:
              params.containsKey("idprestashop") ? params["idprestashop"] : "");

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"idprestashop": idprestashop};

  bool _validate<T>(T? value) {
    return value != null;
  }
}
