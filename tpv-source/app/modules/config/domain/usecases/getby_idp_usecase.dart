// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

class GetIdpByFieldUseCase<Entity extends EntityModel>
    implements UseCase<EntityModelList<Entity>, GetIdpByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetIdpByFieldUseCaseParams? parameters;
  GetIdpByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetIdpByFieldUseCaseParams? params,
  ) async {
    return (params==null && parameters==null)?Left(NulleableFailure(
        message: "Ha ocurrido un error relacionado a los parámetros de la operación.")): await repository.getBy((params??parameters)!.toJson());
  }

  @override
  GetIdpByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetIdpByFieldUseCaseParams> setParams(
      GetIdpByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetIdpByFieldUseCaseParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class GetIdpByFieldUseCaseParams extends Parametizable {
  final int id;
  GetIdpByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
