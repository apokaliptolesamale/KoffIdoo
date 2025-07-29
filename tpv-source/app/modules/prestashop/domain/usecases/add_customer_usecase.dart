// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/customer_repository.dart';

AddUseCaseCustomerParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseCustomerParams.fromMap(params);

class AddCustomerUseCase<CustomerModel>
    implements UseCase<CustomerModel, AddUseCaseCustomerParams> {
  final CustomerRepository<CustomerModel> repository;
  late AddUseCaseCustomerParams? parameters;

  AddCustomerUseCase(this.repository);

  @override
  Future<Either<Failure, CustomerModel>> call(
    AddUseCaseCustomerParams? params,
  ) async {
    return await repository.add(parameters = params);
  }

  @override
  AddUseCaseCustomerParams? getParams() {
    return parameters = parameters ?? AddUseCaseCustomerParams(id: 0);
  }

  @override
  UseCase<CustomerModel, AddUseCaseCustomerParams> setParams(
      AddUseCaseCustomerParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<CustomerModel, AddUseCaseCustomerParams> setParamsFromMap(
      Map params) {
    parameters = AddUseCaseCustomerParams.fromMap(params);
    return this;
  }
}

class AddUseCaseCustomerParams extends Parametizable {
  final int id;
  AddUseCaseCustomerParams({required this.id}) : super();

  factory AddUseCaseCustomerParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCaseCustomerParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
