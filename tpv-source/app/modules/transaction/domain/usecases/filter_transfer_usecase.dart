// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/transfer_repository.dart';



class FilterTransferUseCase<TransferModel> implements UseCase<EntityModelList<TransferModel>, FilterUseCaseTransferParams> {

  final TransferRepository<TransferModel> repository;
  FilterUseCaseTransferParams? parameters;

  FilterTransferUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<TransferModel>>> call(
    FilterUseCaseTransferParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<TransferModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseTransferParams? getParams() {
    return parameters= parameters ?? FilterUseCaseTransferParams();
  }

  @override
  UseCase<EntityModelList<TransferModel>, FilterUseCaseTransferParams> setParams(
      FilterUseCaseTransferParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<TransferModel>, FilterUseCaseTransferParams> setParamsFromMap(
      Map params) {
    parameters = FilterUseCaseTransferParams.fromMap(params);
    return this;
  }
}

FilterUseCaseTransferParams filterUseCaseTransferParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseTransferParams.fromMap(params);

class FilterUseCaseTransferParams extends Parametizable {
  final String? idtransfer; // id de el caso
  

  int start = 1;
  int limit = 20;

  FilterUseCaseTransferParams({
    this.idtransfer,     
  }) : super();

  bool _validate<T>(T? value) {
    return value != null;
  }

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  factory FilterUseCaseTransferParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCaseTransferParams(
        idtransfer: params.containsKey("idtransfer") ? params["idtransfer"] : "" 
      );

  @override
  Map<String, dynamic> toJson() => {
        "idtransfer": idtransfer
      };
}
