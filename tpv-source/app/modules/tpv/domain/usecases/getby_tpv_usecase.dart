// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

class GetTpvByFieldUseCase<Entity extends EntityModel>
    implements UseCase<EntityModelList<Entity>, GetTpvByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetTpvByFieldUseCaseParams? parameters;
  GetTpvByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetTpvByFieldUseCaseParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.getBy((params ?? parameters)!.toJson());
  }

  @override
  GetTpvByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetTpvByFieldUseCaseParams> setParams(
      GetTpvByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetTpvByFieldUseCaseParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class GetTpvByFieldUseCaseParams extends Parametizable {
  final int id;
  GetTpvByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
