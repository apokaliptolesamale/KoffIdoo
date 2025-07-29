// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/models/prestashop_model.dart';
import '../repository/prestashop_repository.dart';

DeleteUseCasePrestaShopParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCasePrestaShopParams.fromMap(params);

class DeletePrestaShopUseCase<PrestaShopModelEntity extends PrestaShopModel>
    implements UseCase<PrestaShopModelEntity, DeleteUseCasePrestaShopParams> {
  final PrestaShopRepository<PrestaShopModelEntity> repository;

  late DeleteUseCasePrestaShopParams? parameters;

  DeletePrestaShopUseCase(this.repository);

  @override
  Future<Either<Failure, PrestaShopModelEntity>> call(
    DeleteUseCasePrestaShopParams? params,
  ) async {
    return await repository.delete((parameters = params)!.id);
  }

  @override
  DeleteUseCasePrestaShopParams? getParams() {
    return parameters = parameters ?? DeleteUseCasePrestaShopParams(id: 0);
  }

  @override
  UseCase<PrestaShopModelEntity, DeleteUseCasePrestaShopParams> setParams(
      DeleteUseCasePrestaShopParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<PrestaShopModelEntity, DeleteUseCasePrestaShopParams>
      setParamsFromMap(Map params) {
    parameters = DeleteUseCasePrestaShopParams.fromMap(params);
    return this;
  }
}

class DeleteUseCasePrestaShopParams extends Parametizable {
  final int id;
  DeleteUseCasePrestaShopParams({required this.id}) : super();

  factory DeleteUseCasePrestaShopParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCasePrestaShopParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
