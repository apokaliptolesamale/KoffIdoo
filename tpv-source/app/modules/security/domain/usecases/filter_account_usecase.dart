// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/account_repository.dart';



class FilterAccountUseCase<AccountModel> implements UseCase<EntityModelList<AccountModel>, FilterUseCaseAccountParams> {

  final AccountRepository<AccountModel> repository;
  FilterUseCaseAccountParams? parameters;

  FilterAccountUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<AccountModel>>> call(
    FilterUseCaseAccountParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<AccountModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseAccountParams? getParams() {
    return parameters= parameters ?? FilterUseCaseAccountParams();
  }

  @override
  UseCase<EntityModelList<AccountModel>, FilterUseCaseAccountParams> setParams(
      FilterUseCaseAccountParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<AccountModel>, FilterUseCaseAccountParams> setParamsFromMap(
      Map params) {
    parameters = FilterUseCaseAccountParams.fromMap(params);
    return this;
  }
}

FilterUseCaseAccountParams filterUseCaseAccountParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseAccountParams.fromMap(params);

class FilterUseCaseAccountParams extends Parametizable {
  final String? idaccount; // id de el caso
  

  int start = 1;
  int limit = 20;

  FilterUseCaseAccountParams({
    this.idaccount,     
  }) : super();

  bool _validate<T>(T? value) {
    return value != null;
  }

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  factory FilterUseCaseAccountParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCaseAccountParams(
        idaccount: params.containsKey("idaccount") ? params["idaccount"] : "" 
      );

  @override
  Map<String, dynamic> toJson() => {
        "idaccount": idaccount
      };
}
