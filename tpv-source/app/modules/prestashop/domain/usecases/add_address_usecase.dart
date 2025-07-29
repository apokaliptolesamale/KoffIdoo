// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/address_repository.dart';

AddUseCaseAddressParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseAddressParams.fromMap(params);

class AddAddressUseCase<AddressModel>
    implements UseCase<AddressModel, AddUseCaseAddressParams> {
  final AddressRepository<AddressModel> repository;
  late AddUseCaseAddressParams? parameters;

  AddAddressUseCase(this.repository);

  @override
  Future<Either<Failure, AddressModel>> call(
    AddUseCaseAddressParams? params,
  ) async {
    return await repository.add(parameters = params);
  }

  @override
  AddUseCaseAddressParams? getParams() {
    return parameters = parameters ?? AddUseCaseAddressParams(id: 0);
  }

  @override
  UseCase<AddressModel, AddUseCaseAddressParams> setParams(
      AddUseCaseAddressParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<AddressModel, AddUseCaseAddressParams> setParamsFromMap(Map params) {
    parameters = AddUseCaseAddressParams.fromMap(params);
    return this;
  }
}

class AddUseCaseAddressParams extends Parametizable {
  final int id;
  AddUseCaseAddressParams({required this.id}) : super();

  factory AddUseCaseAddressParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCaseAddressParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
