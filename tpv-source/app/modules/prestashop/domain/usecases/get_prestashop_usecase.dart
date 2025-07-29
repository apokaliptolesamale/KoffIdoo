// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/prestashop_repository.dart';

GetUseCasePrestaShopParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCasePrestaShopParams.fromMap(params);

class GetPrestaShopUseCase<PrestaShopModel>
    implements UseCase<PrestaShopModel, GetUseCasePrestaShopParams> {
  final PrestaShopRepository<PrestaShopModel> repository;
  late GetUseCasePrestaShopParams? parameters;

  GetPrestaShopUseCase(this.repository);

  @override
  Future<Either<Failure, PrestaShopModel>> call(
    GetUseCasePrestaShopParams? params,
  ) async {
    return await repository.getPrestaShop((parameters = params)!.id);
  }

  @override
  GetUseCasePrestaShopParams? getParams() {
    return parameters = parameters ?? GetUseCasePrestaShopParams(id: 0);
  }

  @override
  UseCase<PrestaShopModel, GetUseCasePrestaShopParams> setParams(
      GetUseCasePrestaShopParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<PrestaShopModel, GetUseCasePrestaShopParams> setParamsFromMap(
      Map params) {
    parameters = GetUseCasePrestaShopParams.fromMap(params);
    return this;
  }
}

class GetUseCasePrestaShopParams extends Parametizable {
  final int id;
  GetUseCasePrestaShopParams({required this.id}) : super();

  factory GetUseCasePrestaShopParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCasePrestaShopParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
