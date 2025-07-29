// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/interfaces/use_case.dart';

class GetStatusByFieldUseCase<Entity extends EntityModel>
    implements UseCase<EntityModelList<Entity>, GetStatusByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetStatusByFieldUseCaseParams? parameters;
  GetStatusByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetStatusByFieldUseCaseParams? params,
  ) async {
    return await repository.getBy((params ?? parameters)!.toJson());
  }

  @override
  GetStatusByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetStatusByFieldUseCaseParams> setParams(
      GetStatusByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetStatusByFieldUseCaseParams>
      setParamsFromMap(Map params) {
    parameters = GetStatusByFieldUseCaseParams.fromMap(params);
    return this;
  }
}

class GetStatusByFieldUseCaseParams extends Parametizable {
  dynamic field, value;

  GetStatusByFieldUseCaseParams({
    required this.field,
    required this.value,
  }) : super();

  factory GetStatusByFieldUseCaseParams.fromMap(Map params) {
    return GetStatusByFieldUseCaseParams(
      field: params.containsKey("field") ? params['field'] : null,
      value: params.containsKey("value") ? params['value'] : null,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "field": field,
        "value": value,
      };
}
