// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/product_model.dart';
import '../repository/product_repository.dart';

class UpdateProductUseCase<ProductModelEntity extends ProductModel>
    implements UseCase<ProductModelEntity, UpdateUseCaseProductParams> {
  final ProductRepository<ProductModelEntity> repository;
  late UpdateUseCaseProductParams? parameters;
  UpdateProductUseCase(this.repository);

  @override
  Future<Either<Failure, ProductModelEntity>> call(
    UpdateUseCaseProductParams? params,
  ) async {
    return await repository.update((parameters = params)!.id, params!.entity);
  }

  @override
  UpdateUseCaseProductParams? getParams() {
    return parameters = parameters ??
        UpdateUseCaseProductParams(
            id: 0, entity: ProductModel(idProduct: "0", idOrderService: ""));
  }

  @override
  UseCase<ProductModelEntity, UpdateUseCaseProductParams> setParams(
      UpdateUseCaseProductParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<ProductModelEntity, UpdateUseCaseProductParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class UpdateUseCaseProductParams extends Parametizable {
  final dynamic id;
  final ProductModel entity;
  UpdateUseCaseProductParams({required this.id, required this.entity})
      : super();
}
