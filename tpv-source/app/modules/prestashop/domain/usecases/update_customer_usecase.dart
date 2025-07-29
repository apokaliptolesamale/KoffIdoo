// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/customer_model.dart';
import '../repository/customer_repository.dart';

class UpdateCustomerUseCase<CustomerModelEntity extends CustomerModel>
    implements UseCase<CustomerModelEntity, UpdateUseCaseCustomerParams> {
  final CustomerRepository<CustomerModelEntity> repository;
  late UpdateUseCaseCustomerParams? parameters;
  UpdateCustomerUseCase(this.repository);

  @override
  Future<Either<Failure, CustomerModelEntity>> call(
    UpdateUseCaseCustomerParams? params,
  ) async {
    return await repository.update((parameters = params)!.id, params!.entity);
  }

  @override
  UpdateUseCaseCustomerParams? getParams() {
    return parameters = parameters ??
        UpdateUseCaseCustomerParams(
            id: 0,
            entity: CustomerModel(
                id: "0", email: "", firstName: "", lastName: "", userName: ""));
  }

  @override
  UseCase<CustomerModelEntity, UpdateUseCaseCustomerParams> setParams(
      UpdateUseCaseCustomerParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<CustomerModelEntity, UpdateUseCaseCustomerParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class UpdateUseCaseCustomerParams extends Parametizable {
  final dynamic id;
  final CustomerModel entity;
  UpdateUseCaseCustomerParams({required this.id, required this.entity})
      : super();
}
