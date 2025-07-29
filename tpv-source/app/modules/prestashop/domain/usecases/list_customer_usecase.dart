// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/customer_repository.dart';

ListUseCaseCustomerParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseCustomerParams.fromMap(params);

class ListCustomerUseCase<CustomerModel>
    implements
        UseCase<EntityModelList<CustomerModel>, ListUseCaseCustomerParams> {
  final CustomerRepository<CustomerModel> repository;
  late ListUseCaseCustomerParams? parameters;

  ListCustomerUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<CustomerModel>>> call(
    ListUseCaseCustomerParams? params,
  ) async {
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<CustomerModel>>> getAll() async {
    return await call(getParams());
  }

  @override
  ListUseCaseCustomerParams? getParams() {
    return parameters = parameters ?? ListUseCaseCustomerParams();
  }

  @override
  UseCase<EntityModelList<CustomerModel>, ListUseCaseCustomerParams> setParams(
      ListUseCaseCustomerParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<CustomerModel>, ListUseCaseCustomerParams>
      setParamsFromMap(Map params) {
    parameters = ListUseCaseCustomerParams.fromMap(params);
    return this;
  }
}

class ListUseCaseCustomerParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseCustomerParams({
    this.start = -1,
    this.limit = -1,
    this.getAll = false,
  }) : super() {
    if (start == -1 || limit == -1) getAll = true;
  }

  factory ListUseCaseCustomerParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseCustomerParams(
        start: params.containsKey("start") ? params["start"] : 1,
        limit: params.containsKey("limit") ? params["limit"] : 50,
      );

  @override
  bool isValid() {
    return start! > 0 && start! < limit!;
  }

  @override
  Map<String, dynamic> toJson() => {"start": start ?? 1, "limit": limit ?? 50};
}
