// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/interfaces/entity_model.dart';
import '../../../../core/interfaces/repository.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

class GetDonationByFieldUseCase<Entity extends EntityModel>
    implements UseCase<EntityModelList<Entity>, GetDonationByFieldUseCaseParams> {
  final Repository<Entity> repository;
  late GetDonationByFieldUseCaseParams? parameters;
  GetDonationByFieldUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<Entity>>> call(
    GetDonationByFieldUseCaseParams? params,
  ) async {
    return await repository.getBy((parameters = params)!.toJson());
  }

  @override
  GetDonationByFieldUseCaseParams? getParams() {
    return parameters;
  }

  @override
  UseCase<EntityModelList<Entity>, GetDonationByFieldUseCaseParams> setParams(
      GetDonationByFieldUseCaseParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<Entity>, GetDonationByFieldUseCaseParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class GetDonationByFieldUseCaseParams extends Parametizable {
  final int id;
  GetDonationByFieldUseCaseParams({required this.id}) : super();

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
