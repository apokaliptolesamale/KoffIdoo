// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/address_repository.dart';

FilterUseCaseAddressParams filterUseCaseAddressParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseAddressParams.fromMap(params);

class FilterAddressUseCase<AddressModel>
    implements
        UseCase<EntityModelList<AddressModel>, FilterUseCaseAddressParams> {
  final AddressRepository<AddressModel> repository;
  FilterUseCaseAddressParams? parameters;

  FilterAddressUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<AddressModel>>> call(
    FilterUseCaseAddressParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<AddressModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseAddressParams? getParams() {
    return parameters = parameters ?? FilterUseCaseAddressParams();
  }

  @override
  UseCase<EntityModelList<AddressModel>, FilterUseCaseAddressParams> setParams(
      FilterUseCaseAddressParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<AddressModel>, FilterUseCaseAddressParams>
      setParamsFromMap(Map params) {
    parameters = FilterUseCaseAddressParams.fromMap(params);
    return this;
  }
}

class FilterUseCaseAddressParams extends Parametizable {
  final String? idaddress; // id de el caso

  int start = 1;
  int limit = 20;

  FilterUseCaseAddressParams({
    this.idaddress,
  }) : super();

  factory FilterUseCaseAddressParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCaseAddressParams(
          idaddress:
              params.containsKey("idaddress") ? params["idaddress"] : "");

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"idaddress": idaddress};

  bool _validate<T>(T? value) {
    return value != null;
  }
}
