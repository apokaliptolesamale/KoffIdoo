// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/interfaces/use_case.dart';

class GetOrderHistoryByFieldUseCase<Entity extends EntityModel>
    implements
        UseCase<EntityModelList<Entity>, GetOrderHistoryByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetOrderHistoryByFieldUseCaseParams? parameters;
  GetOrderHistoryByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetOrderHistoryByFieldUseCaseParams? params,
  ) async {
    return await repository.getBy((parameters = params)!.toJson());
  }

  @override
  GetOrderHistoryByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetOrderHistoryByFieldUseCaseParams>
      setParams(GetOrderHistoryByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetOrderHistoryByFieldUseCaseParams>
      setParamsFromMap(Map params) {
    return this;
  }
}

class GetOrderHistoryByFieldUseCaseParams extends Parametizable {
  final int id;
  GetOrderHistoryByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
