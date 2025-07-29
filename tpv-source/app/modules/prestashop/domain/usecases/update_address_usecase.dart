// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '/app/modules/prestashop/domain/models/customer_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/address_model.dart';
import '../repository/address_repository.dart';

class UpdateAddressUseCase<AddressModelEntity extends AddressModel>
    implements UseCase<AddressModelEntity, UpdateUseCaseAddressParams> {
  final AddressRepository<AddressModelEntity> repository;
  late UpdateUseCaseAddressParams? parameters;
  UpdateAddressUseCase(this.repository);

  @override
  Future<Either<Failure, AddressModelEntity>> call(
    UpdateUseCaseAddressParams? params,
  ) async {
    return await repository.update((parameters = params)!.id, params!.entity);
  }

  @override
  UpdateUseCaseAddressParams? getParams() {
    return parameters = parameters ??
        UpdateUseCaseAddressParams(
            id: 0,
            entity: AddressModel(
              idAddress: "0",
              custormer: CustomerModel.fromJson({}),
              address: "",
              city: "",
              alias: "",
              createAt: DateTime.now(),
            ));
  }

  @override
  UseCase<AddressModelEntity, UpdateUseCaseAddressParams> setParams(
      UpdateUseCaseAddressParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<AddressModelEntity, UpdateUseCaseAddressParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class UpdateUseCaseAddressParams extends Parametizable {
  final dynamic id;
  final AddressModel entity;
  UpdateUseCaseAddressParams({required this.id, required this.entity})
      : super();
}
