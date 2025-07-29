// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/prestashop_repository.dart';

AddUseCasePrestaShopParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCasePrestaShopParams.fromMap(params);

class AddPrestaShopUseCase<PrestaShopModel>
    implements UseCase<PrestaShopModel, AddUseCasePrestaShopParams> {
  final PrestaShopRepository<PrestaShopModel> repository;
  late AddUseCasePrestaShopParams? parameters;

  AddPrestaShopUseCase(this.repository);

  @override
  Future<Either<Failure, PrestaShopModel>> call(
    AddUseCasePrestaShopParams? params,
  ) async {
    return await repository.add(parameters = params);
  }

  @override
  AddUseCasePrestaShopParams? getParams() {
    return parameters = parameters ?? AddUseCasePrestaShopParams(id: 0);
  }

  @override
  UseCase<PrestaShopModel, AddUseCasePrestaShopParams> setParams(
      AddUseCasePrestaShopParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<PrestaShopModel, AddUseCasePrestaShopParams> setParamsFromMap(
      Map params) {
    parameters = AddUseCasePrestaShopParams.fromMap(params);
    return this;
  }
}

class AddUseCasePrestaShopParams extends Parametizable {
  final int id;
  AddUseCasePrestaShopParams({required this.id}) : super();

  factory AddUseCasePrestaShopParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCasePrestaShopParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
