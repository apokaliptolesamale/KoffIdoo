// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/interfaces/use_case.dart';

class GetWarrantyByFieldUseCase<Entity extends EntityModel>
    implements
        UseCase<EntityModelList<Entity>, GetWarrantyByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetWarrantyByFieldUseCaseParams? parameters;
  GetWarrantyByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetWarrantyByFieldUseCaseParams? params,
  ) async {
    return await repository.getBy((parameters = params)!.toJson());
  }

  @override
  GetWarrantyByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetWarrantyByFieldUseCaseParams> setParams(
      GetWarrantyByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetWarrantyByFieldUseCaseParams>
      setParamsFromMap(Map params) {
    return this;
  }
}

class GetWarrantyByFieldUseCaseParams extends Parametizable {
  final int id;
  GetWarrantyByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
