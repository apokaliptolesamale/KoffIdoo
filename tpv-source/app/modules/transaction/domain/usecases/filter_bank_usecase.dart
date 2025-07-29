// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/bank_repository.dart';



class FilterBankUseCase<BankModel> implements UseCase<EntityModelList<BankModel>, FilterUseCaseBankParams> {

  final BankRepository<BankModel> repository;
  FilterUseCaseBankParams? parameters;

  FilterBankUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<BankModel>>> call(
    FilterUseCaseBankParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<BankModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseBankParams? getParams() {
    return parameters= parameters ?? FilterUseCaseBankParams();
  }

  @override
  UseCase<EntityModelList<BankModel>, FilterUseCaseBankParams> setParams(
      FilterUseCaseBankParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<BankModel>, FilterUseCaseBankParams> setParamsFromMap(
      Map params) {
    parameters = FilterUseCaseBankParams.fromMap(params);
    return this;
  }
}

FilterUseCaseBankParams filterUseCaseBankParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseBankParams.fromMap(params);

class FilterUseCaseBankParams extends Parametizable {
  final String? idbank; // id de el caso
  

  int start = 1;
  int limit = 20;

  FilterUseCaseBankParams({
    this.idbank,     
  }) : super();

  bool _validate<T>(T? value) {
    return value != null;
  }

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  factory FilterUseCaseBankParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCaseBankParams(
        idbank: params.containsKey("idbank") ? params["idbank"] : "" 
      );

  @override
  Map<String, dynamic> toJson() => {
        "idbank": idbank
      };
}
