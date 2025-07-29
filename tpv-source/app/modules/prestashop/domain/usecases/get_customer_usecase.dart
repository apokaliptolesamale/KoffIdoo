// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/customer_repository.dart';

GetUseCaseCustomerParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseCustomerParams.fromMap(params);

class GetCustomerUseCase<CustomerModel>
    implements UseCase<CustomerModel, GetUseCaseCustomerParams> {
  final CustomerRepository<CustomerModel> repository;
  late GetUseCaseCustomerParams? parameters;

  GetCustomerUseCase(this.repository);

  @override
  Future<Either<Failure, CustomerModel>> call(
    GetUseCaseCustomerParams? params,
  ) async {
    return await repository.getCustomer((parameters = params)!.id);
  }

  @override
  GetUseCaseCustomerParams? getParams() {
    return parameters = parameters ?? GetUseCaseCustomerParams(id: 0);
  }

  @override
  UseCase<CustomerModel, GetUseCaseCustomerParams> setParams(
      GetUseCaseCustomerParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<CustomerModel, GetUseCaseCustomerParams> setParamsFromMap(
      Map params) {
    parameters = GetUseCaseCustomerParams.fromMap(params);
    return this;
  }
}

class GetUseCaseCustomerParams extends Parametizable {
  final int id;
  GetUseCaseCustomerParams({required this.id}) : super();

  factory GetUseCaseCustomerParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseCustomerParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
