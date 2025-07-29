// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/address_repository.dart';

ListUseCaseAddressParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseAddressParams.fromMap(params);

class ListAddressUseCase<AddressModel>
    implements
        UseCase<EntityModelList<AddressModel>, ListUseCaseAddressParams> {
  final AddressRepository<AddressModel> repository;
  late ListUseCaseAddressParams? parameters;

  ListAddressUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<AddressModel>>> call(
    ListUseCaseAddressParams? params,
  ) async {
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<AddressModel>>> getAll() async {
    return await call(getParams());
  }

  @override
  ListUseCaseAddressParams? getParams() {
    return parameters = parameters ?? ListUseCaseAddressParams();
  }

  @override
  UseCase<EntityModelList<AddressModel>, ListUseCaseAddressParams> setParams(
      ListUseCaseAddressParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<AddressModel>, ListUseCaseAddressParams>
      setParamsFromMap(Map params) {
    parameters = ListUseCaseAddressParams.fromMap(params);
    return this;
  }
}

class ListUseCaseAddressParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseAddressParams({
    this.start = -1,
    this.limit = -1,
    this.getAll = false,
  }) : super() {
    if (start == -1 || limit == -1) getAll = true;
  }

  factory ListUseCaseAddressParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseAddressParams(
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
