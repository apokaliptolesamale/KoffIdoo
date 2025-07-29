// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

class GetPaymentByFieldUseCase<Entity extends EntityModel>
    implements UseCase<EntityModelList<Entity>, GetPaymentByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetPaymentByFieldUseCaseParams? parameters;
  GetPaymentByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetPaymentByFieldUseCaseParams? params,
  ) async {
    return await repository.getBy((parameters = params)!.toJson());
  }

  @override
  GetPaymentByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetPaymentByFieldUseCaseParams> setParams(
      GetPaymentByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetPaymentByFieldUseCaseParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class GetPaymentByFieldUseCaseParams extends Parametizable {
  final int id;
  GetPaymentByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
