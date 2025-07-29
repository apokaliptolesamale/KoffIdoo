// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/address_repository.dart';

GetUseCaseAddressParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseAddressParams.fromMap(params);

class GetAddressUseCase<AddressModel>
    implements UseCase<AddressModel, GetUseCaseAddressParams> {
  final AddressRepository<AddressModel> repository;
  late GetUseCaseAddressParams? parameters;

  GetAddressUseCase(this.repository);

  @override
  Future<Either<Failure, AddressModel>> call(
    GetUseCaseAddressParams? params,
  ) async {
    return await repository.getAddress((parameters = params)!.id);
  }

  @override
  GetUseCaseAddressParams? getParams() {
    return parameters = parameters ?? GetUseCaseAddressParams(id: 0);
  }

  @override
  UseCase<AddressModel, GetUseCaseAddressParams> setParams(
      GetUseCaseAddressParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<AddressModel, GetUseCaseAddressParams> setParamsFromMap(Map params) {
    parameters = GetUseCaseAddressParams.fromMap(params);
    return this;
  }
}

class GetUseCaseAddressParams extends Parametizable {
  final int id;
  GetUseCaseAddressParams({required this.id}) : super();

  factory GetUseCaseAddressParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseAddressParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
