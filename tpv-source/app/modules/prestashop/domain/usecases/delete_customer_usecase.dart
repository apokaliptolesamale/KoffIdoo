// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/models/customer_model.dart';
import '../repository/customer_repository.dart';

DeleteUseCaseCustomerParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseCustomerParams.fromMap(params);

class DeleteCustomerUseCase<CustomerModelEntity extends CustomerModel>
    implements UseCase<CustomerModelEntity, DeleteUseCaseCustomerParams> {
  final CustomerRepository<CustomerModelEntity> repository;

  late DeleteUseCaseCustomerParams? parameters;

  DeleteCustomerUseCase(this.repository);

  @override
  Future<Either<Failure, CustomerModelEntity>> call(
    DeleteUseCaseCustomerParams? params,
  ) async {
    return await repository.delete((parameters = params)!.id);
  }

  @override
  DeleteUseCaseCustomerParams? getParams() {
    return parameters = parameters ?? DeleteUseCaseCustomerParams(id: 0);
  }

  @override
  UseCase<CustomerModelEntity, DeleteUseCaseCustomerParams> setParams(
      DeleteUseCaseCustomerParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<CustomerModelEntity, DeleteUseCaseCustomerParams> setParamsFromMap(
      Map params) {
    parameters = DeleteUseCaseCustomerParams.fromMap(params);
    return this;
  }
}

class DeleteUseCaseCustomerParams extends Parametizable {
  final int id;
  DeleteUseCaseCustomerParams({required this.id}) : super();

  factory DeleteUseCaseCustomerParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCaseCustomerParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
