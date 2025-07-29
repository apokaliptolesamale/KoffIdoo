// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/interfaces/use_case.dart';

class GetPrestaShopByFieldUseCase<Entity extends EntityModel>
    implements
        UseCase<EntityModelList<Entity>, GetPrestaShopByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetPrestaShopByFieldUseCaseParams? parameters;
  GetPrestaShopByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetPrestaShopByFieldUseCaseParams? params,
  ) async {
    return await repository.getBy((parameters = params)!.toJson());
  }

  @override
  GetPrestaShopByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetPrestaShopByFieldUseCaseParams> setParams(
      GetPrestaShopByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetPrestaShopByFieldUseCaseParams>
      setParamsFromMap(Map params) {
    return this;
  }
}

class GetPrestaShopByFieldUseCaseParams extends Parametizable {
  final int id;
  GetPrestaShopByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
