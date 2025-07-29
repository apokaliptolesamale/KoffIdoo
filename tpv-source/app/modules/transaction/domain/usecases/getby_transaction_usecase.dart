// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

class GetTransactionByFieldUseCase<Entity extends EntityModel>
    implements UseCase<EntityModelList<Entity>, GetTransactionByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetTransactionByFieldUseCaseParams? parameters;
  GetTransactionByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetTransactionByFieldUseCaseParams? params,
  ) async {
    return await repository.getBy((parameters = params)!.toJson());
  }

  @override
  GetTransactionByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetTransactionByFieldUseCaseParams> setParams(
      GetTransactionByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetTransactionByFieldUseCaseParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class GetTransactionByFieldUseCaseParams extends Parametizable {
  final int id;
  GetTransactionByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
