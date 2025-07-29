// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/warranty_model.dart';
import '../repository/warranty_repository.dart';

class UpdateUseCaseWarrantyParams extends Parametizable {
  final dynamic id;
  final WarrantyModel entity;
  UpdateUseCaseWarrantyParams({required this.id, required this.entity})
      : super();
}

class UpdateWarrantyUseCase<WarrantyModelEntity extends WarrantyModel>
    implements UseCase<WarrantyModelEntity, UpdateUseCaseWarrantyParams> {
  final WarrantyRepository<WarrantyModelEntity> repository;
  late UpdateUseCaseWarrantyParams? parameters;
  UpdateWarrantyUseCase(this.repository);

  @override
  Future<Either<Failure, WarrantyModelEntity>> call(
    UpdateUseCaseWarrantyParams? params,
  ) async {
    return await repository.update((parameters = params)!.id, params!.entity);
  }

  @override
  UpdateUseCaseWarrantyParams? getParams() {
    return parameters = parameters ??
        UpdateUseCaseWarrantyParams(
            id: -1, entity: WarrantyModel(createdAt: DateTime.now()));
  }

  @override
  UseCase<WarrantyModelEntity, UpdateUseCaseWarrantyParams> setParams(
      UpdateUseCaseWarrantyParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<WarrantyModelEntity, UpdateUseCaseWarrantyParams> setParamsFromMap(
      Map params) {
    return this;
  }
}
