// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/payment_repository.dart';



class FilterPaymentUseCase<PaymentModel> implements UseCase<EntityModelList<PaymentModel>, FilterUseCasePaymentParams> {

  final PaymentRepository<PaymentModel> repository;
  FilterUseCasePaymentParams? parameters;

  FilterPaymentUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<PaymentModel>>> call(
    FilterUseCasePaymentParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<PaymentModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCasePaymentParams? getParams() {
    return parameters= parameters ?? FilterUseCasePaymentParams();
  }

  @override
  UseCase<EntityModelList<PaymentModel>, FilterUseCasePaymentParams> setParams(
      FilterUseCasePaymentParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<PaymentModel>, FilterUseCasePaymentParams> setParamsFromMap(
      Map params) {
    parameters = FilterUseCasePaymentParams.fromMap(params);
    return this;
  }
}

FilterUseCasePaymentParams filterUseCasePaymentParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCasePaymentParams.fromMap(params);

class FilterUseCasePaymentParams extends Parametizable {
  final String? idpayment; // id de el caso
  

  int start = 1;
  int limit = 20;

  FilterUseCasePaymentParams({
    this.idpayment,     
  }) : super();

  bool _validate<T>(T? value) {
    return value != null;
  }

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  factory FilterUseCasePaymentParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCasePaymentParams(
        idpayment: params.containsKey("idpayment") ? params["idpayment"] : "" 
      );

  @override
  Map<String, dynamic> toJson() => {
        "idpayment": idpayment
      };
}
