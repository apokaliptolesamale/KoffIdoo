// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/donation_repository.dart';



class FilterDonationUseCase<DonationModel> implements UseCase<EntityModelList<DonationModel>, FilterUseCaseDonationParams> {

  final DonationRepository<DonationModel> repository;
  FilterUseCaseDonationParams? parameters;

  FilterDonationUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<DonationModel>>> call(
    FilterUseCaseDonationParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<DonationModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseDonationParams? getParams() {
    return parameters= parameters ?? FilterUseCaseDonationParams();
  }

  @override
  UseCase<EntityModelList<DonationModel>, FilterUseCaseDonationParams> setParams(
      FilterUseCaseDonationParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<DonationModel>, FilterUseCaseDonationParams> setParamsFromMap(
      Map params) {
    parameters = FilterUseCaseDonationParams.fromMap(params);
    return this;
  }
}

FilterUseCaseDonationParams filterUseCaseDonationParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseDonationParams.fromMap(params);

class FilterUseCaseDonationParams extends Parametizable {
  final String? iddonation; // id de el caso
  

  int start = 1;
  int limit = 20;

  FilterUseCaseDonationParams({
    this.iddonation,     
  }) : super();

  bool _validate<T>(T? value) {
    return value != null;
  }

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  factory FilterUseCaseDonationParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCaseDonationParams(
        iddonation: params.containsKey("iddonation") ? params["iddonation"] : "" 
      );

  @override
  Map<String, dynamic> toJson() => {
        "iddonation": iddonation
      };
}
