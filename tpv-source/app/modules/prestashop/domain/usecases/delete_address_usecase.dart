// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/models/address_model.dart';
import '../repository/address_repository.dart';

DeleteUseCaseAddressParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseAddressParams.fromMap(params);

class DeleteAddressUseCase<AddressModelEntity extends AddressModel>
    implements UseCase<AddressModelEntity, DeleteUseCaseAddressParams> {
  final AddressRepository<AddressModelEntity> repository;

  late DeleteUseCaseAddressParams? parameters;

  DeleteAddressUseCase(this.repository);

  @override
  Future<Either<Failure, AddressModelEntity>> call(
    DeleteUseCaseAddressParams? params,
  ) async {
    return await repository.delete((parameters = params)!.id);
  }

  @override
  DeleteUseCaseAddressParams? getParams() {
    return parameters = parameters ?? DeleteUseCaseAddressParams(id: 0);
  }

  @override
  UseCase<AddressModelEntity, DeleteUseCaseAddressParams> setParams(
      DeleteUseCaseAddressParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<AddressModelEntity, DeleteUseCaseAddressParams> setParamsFromMap(
      Map params) {
    parameters = DeleteUseCaseAddressParams.fromMap(params);
    return this;
  }
}

class DeleteUseCaseAddressParams extends Parametizable {
  final int id;
  DeleteUseCaseAddressParams({required this.id}) : super();

  factory DeleteUseCaseAddressParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCaseAddressParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
