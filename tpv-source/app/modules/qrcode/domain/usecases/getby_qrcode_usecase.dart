// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/interfaces/use_case.dart';

class GetQrCodeByFieldUseCase<Entity extends EntityModel>
    implements UseCase<EntityModelList<Entity>, GetQrCodeByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetQrCodeByFieldUseCaseParams? parameters;
  GetQrCodeByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetQrCodeByFieldUseCaseParams? params,
  ) async {
    return await repository.getBy((parameters = params)!.toJson());
  }

  @override
  GetQrCodeByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetQrCodeByFieldUseCaseParams> setParams(
      GetQrCodeByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetQrCodeByFieldUseCaseParams>
      setParamsFromMap(Map params) {
    return this;
  }
}

class GetQrCodeByFieldUseCaseParams extends Parametizable {
  final int id;
  GetQrCodeByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
