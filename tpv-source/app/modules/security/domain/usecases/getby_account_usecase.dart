// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

class GetAccountByFieldUseCase<Entity extends EntityModel>
    implements UseCase<EntityModelList<Entity>, GetAccountByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetAccountByFieldUseCaseParams? parameters;
  GetAccountByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetAccountByFieldUseCaseParams? params,
  ) async {
    return await repository.getBy((parameters = params)!.toJson());
  }

  @override
  GetAccountByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetAccountByFieldUseCaseParams> setParams(
      GetAccountByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetAccountByFieldUseCaseParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class GetAccountByFieldUseCaseParams extends Parametizable {
  final int id;
  GetAccountByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
