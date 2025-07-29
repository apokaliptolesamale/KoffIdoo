// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/interfaces/use_case.dart';

class GetOrderDetailByFieldUseCase<Entity extends EntityModel>
    implements
        UseCase<EntityModelList<Entity>, GetOrderDetailByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetOrderDetailByFieldUseCaseParams? parameters;
  GetOrderDetailByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetOrderDetailByFieldUseCaseParams? params,
  ) async {
    return await repository.getBy((parameters = params)!.toJson());
  }

  @override
  GetOrderDetailByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetOrderDetailByFieldUseCaseParams>
      setParams(GetOrderDetailByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetOrderDetailByFieldUseCaseParams>
      setParamsFromMap(Map params) {
    return this;
  }
}

class GetOrderDetailByFieldUseCaseParams extends Parametizable {
  final int id;
  GetOrderDetailByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
