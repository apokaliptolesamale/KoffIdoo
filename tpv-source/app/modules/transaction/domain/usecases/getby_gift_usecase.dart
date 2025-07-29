// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

class GetGiftByFieldUseCase<Entity extends EntityModel>
    implements UseCase<EntityModelList<Entity>, GetGiftByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetGiftByFieldUseCaseParams? parameters;
  GetGiftByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetGiftByFieldUseCaseParams? params,
  ) async {
    return await repository.getBy((parameters = params)!.toJson());
  }

  @override
  GetGiftByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetGiftByFieldUseCaseParams> setParams(
      GetGiftByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetGiftByFieldUseCaseParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class GetGiftByFieldUseCaseParams extends Parametizable {
  final int id;
  GetGiftByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
