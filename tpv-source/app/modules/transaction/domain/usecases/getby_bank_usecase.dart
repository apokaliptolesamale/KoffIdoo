// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

class GetBankByFieldUseCase<Entity extends EntityModel>
    implements UseCase<EntityModelList<Entity>, GetBankByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetBankByFieldUseCaseParams? parameters;
  GetBankByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetBankByFieldUseCaseParams? params,
  ) async {
    return await repository.getBy((parameters = params)!.toJson());
  }

  @override
  GetBankByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetBankByFieldUseCaseParams> setParams(
      GetBankByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetBankByFieldUseCaseParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class GetBankByFieldUseCaseParams extends Parametizable {
  final int id;
  GetBankByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
