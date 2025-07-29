// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/interfaces/use_case.dart';

class GetCustomerByFieldUseCase<Entity extends EntityModel>
    implements
        UseCase<EntityModelList<Entity>, GetCustomerByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetCustomerByFieldUseCaseParams? parameters;
  GetCustomerByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetCustomerByFieldUseCaseParams? params,
  ) async {
    return await repository.getBy((parameters = params)!.toJson());
  }

  @override
  GetCustomerByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetCustomerByFieldUseCaseParams> setParams(
      GetCustomerByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetCustomerByFieldUseCaseParams>
      setParamsFromMap(Map params) {
    return this;
  }
}

class GetCustomerByFieldUseCaseParams extends Parametizable {
  final int id;
  GetCustomerByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
