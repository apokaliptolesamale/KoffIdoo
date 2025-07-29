// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/interfaces/use_case.dart';

class GetNotifyByFieldUseCase<Entity extends EntityModel>
    implements UseCase<EntityModelList<Entity>, GetNotifyByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetNotifyByFieldUseCaseParams? parameters;
  GetNotifyByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetNotifyByFieldUseCaseParams? params,
  ) async {
    return await repository.getBy((parameters = params)!.toJson());
  }

  @override
  GetNotifyByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetNotifyByFieldUseCaseParams> setParams(
      GetNotifyByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetNotifyByFieldUseCaseParams>
      setParamsFromMap(Map params) {
    return this;
  }
}

class GetNotifyByFieldUseCaseParams extends Parametizable {
  final int id;
  GetNotifyByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
