// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/interfaces/use_case.dart';

class GetOrderByFieldUseCase<Entity extends EntityModel>
    implements UseCase<EntityModelList<Entity>, GetOrderByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetOrderByFieldUseCaseParams? parameters;
  GetOrderByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetOrderByFieldUseCaseParams? params,
  ) async {
    return await repository.getBy((parameters = params)!.toJson());
  }

  @override
  GetOrderByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetOrderByFieldUseCaseParams> setParams(
      GetOrderByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetOrderByFieldUseCaseParams>
      setParamsFromMap(Map params) {
    return this;
  }
}

class GetOrderByFieldUseCaseParams extends Parametizable {
  final int id;
  GetOrderByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
