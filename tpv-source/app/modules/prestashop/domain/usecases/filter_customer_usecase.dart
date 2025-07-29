// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/repository/customer_repository.dart';

FilterUseCaseCustomerParams filterUseCaseCustomerParamsFromMap(
        Map<dynamic, dynamic> params) =>
    FilterUseCaseCustomerParams.fromMap(params);

class FilterCustomerUseCase<CustomerModel>
    implements
        UseCase<EntityModelList<CustomerModel>, FilterUseCaseCustomerParams> {
  final CustomerRepository<CustomerModel> repository;
  FilterUseCaseCustomerParams? parameters;

  FilterCustomerUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<CustomerModel>>> call(
    FilterUseCaseCustomerParams? params,
  ) async {
    return (parameters = params)!.isValid()
        ? await repository.filter(parameters!.toJson())
        : await Future.value(Left(InvalidParamsFailure(
            message:
                "Los parámetros de la búsqueda son vacíos o incorrectos.")));
  }

  Future<Either<Failure, EntityModelList<CustomerModel>>> filter() async {
    return call(getParams()!);
  }

  @override
  FilterUseCaseCustomerParams? getParams() {
    return parameters = parameters ?? FilterUseCaseCustomerParams();
  }

  @override
  UseCase<EntityModelList<CustomerModel>, FilterUseCaseCustomerParams>
      setParams(FilterUseCaseCustomerParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<CustomerModel>, FilterUseCaseCustomerParams>
      setParamsFromMap(Map params) {
    parameters = FilterUseCaseCustomerParams.fromMap(params);
    return this;
  }
}

class FilterUseCaseCustomerParams extends Parametizable {
  final String? idcustomer; // id de el caso

  int start = 1;
  int limit = 20;

  FilterUseCaseCustomerParams({
    this.idcustomer,
  }) : super();

  factory FilterUseCaseCustomerParams.fromMap(Map<dynamic, dynamic> params) =>
      FilterUseCaseCustomerParams(
          idcustomer:
              params.containsKey("idcustomer") ? params["idcustomer"] : "");

  @override
  bool isValid() {
    //TODO implementar la validación de cada campo del filtro
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"idcustomer": idcustomer};

  bool _validate<T>(T? value) {
    return value != null;
  }
}
