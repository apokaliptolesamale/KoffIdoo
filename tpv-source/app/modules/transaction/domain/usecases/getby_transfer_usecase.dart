// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

class GetTransferByFieldUseCase<Entity extends EntityModel>
    implements UseCase<EntityModelList<Entity>, GetTransferByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetTransferByFieldUseCaseParams? parameters;
  GetTransferByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetTransferByFieldUseCaseParams? params,
  ) async {
    return await repository.getBy((parameters = params)!.toJson());
  }

  @override
  GetTransferByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetTransferByFieldUseCaseParams> setParams(
      GetTransferByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetTransferByFieldUseCaseParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class GetTransferByFieldUseCaseParams extends Parametizable {
  final int id;
  GetTransferByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
