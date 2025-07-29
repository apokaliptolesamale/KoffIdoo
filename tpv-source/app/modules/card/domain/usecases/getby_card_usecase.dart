// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

class GetCardByFieldUseCase<Entity extends EntityModel>
    implements UseCase<EntityModelList<Entity>, GetCardByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetCardByFieldUseCaseParams? parameters;
  GetCardByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetCardByFieldUseCaseParams? params,
  ) async {
    return await repository.getBy((parameters = params)!.toJson());
  }

  @override
  GetCardByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetCardByFieldUseCaseParams> setParams(
      GetCardByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetCardByFieldUseCaseParams>
      setParamsFromMap(Map params) {
    return this;
  }
}

class GetCardByFieldUseCaseParams extends Parametizable {
  final int id;
  GetCardByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
