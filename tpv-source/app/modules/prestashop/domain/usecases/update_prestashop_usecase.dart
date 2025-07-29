// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/prestashop_model.dart';
import '../repository/prestashop_repository.dart';

class UpdatePrestaShopUseCase<PrestaShopModelEntity extends PrestaShopModel>
    implements UseCase<PrestaShopModelEntity, UpdateUseCasePrestaShopParams> {
  final PrestaShopRepository<PrestaShopModelEntity> repository;
  late UpdateUseCasePrestaShopParams? parameters;
  UpdatePrestaShopUseCase(this.repository);

  @override
  Future<Either<Failure, PrestaShopModelEntity>> call(
    UpdateUseCasePrestaShopParams? params,
  ) async {
    return await repository.update((parameters = params)!.id, params!.entity);
  }

  @override
  UpdateUseCasePrestaShopParams? getParams() {
    return parameters = parameters ??
        UpdateUseCasePrestaShopParams(
            id: 0, entity: PrestaShopModel(idPrestaShop: "0"));
  }

  @override
  UseCase<PrestaShopModelEntity, UpdateUseCasePrestaShopParams> setParams(
      UpdateUseCasePrestaShopParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<PrestaShopModelEntity, UpdateUseCasePrestaShopParams>
      setParamsFromMap(Map params) {
    return this;
  }
}

class UpdateUseCasePrestaShopParams extends Parametizable {
  final dynamic id;
  final PrestaShopModel entity;
  UpdateUseCasePrestaShopParams({required this.id, required this.entity})
      : super();
}
