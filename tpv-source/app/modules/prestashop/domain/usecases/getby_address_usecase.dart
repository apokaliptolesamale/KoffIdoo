// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/interfaces/use_case.dart';

class GetAddressByFieldUseCase<Entity extends EntityModel>
    implements
        UseCase<EntityModelList<Entity>, GetAddressByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetAddressByFieldUseCaseParams? parameters;
  GetAddressByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetAddressByFieldUseCaseParams? params,
  ) async {
    return await repository.getBy((parameters = params)!.toJson());
  }

  @override
  GetAddressByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetAddressByFieldUseCaseParams> setParams(
      GetAddressByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetAddressByFieldUseCaseParams>
      setParamsFromMap(Map params) {
    return this;
  }
}

class GetAddressByFieldUseCaseParams extends Parametizable {
  final int id;
  GetAddressByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
