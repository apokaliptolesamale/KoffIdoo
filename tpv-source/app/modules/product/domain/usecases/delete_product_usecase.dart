// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/models/product_model.dart';
import '../repository/product_repository.dart';

DeleteUseCaseProductParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseProductParams.fromMap(params);

class DeleteProductUseCase<ProductModelEntity extends ProductModel>
    implements UseCase<ProductModelEntity, DeleteUseCaseProductParams> {
  final ProductRepository<ProductModelEntity> repository;

  late DeleteUseCaseProductParams? parameters;

  DeleteProductUseCase(this.repository);

  @override
  Future<Either<Failure, ProductModelEntity>> call(
    DeleteUseCaseProductParams? params,
  ) async {
    return await repository.delete((parameters = params)!.id);
  }

  @override
  DeleteUseCaseProductParams? getParams() {
    return parameters = parameters ?? DeleteUseCaseProductParams(id: 0);
  }

  @override
  UseCase<ProductModelEntity, DeleteUseCaseProductParams> setParams(
      DeleteUseCaseProductParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<ProductModelEntity, DeleteUseCaseProductParams> setParamsFromMap(
      Map params) {
    parameters = DeleteUseCaseProductParams.fromMap(params);
    return this;
  }
}

class DeleteUseCaseProductParams extends Parametizable {
  final int id;
  DeleteUseCaseProductParams({required this.id}) : super();

  factory DeleteUseCaseProductParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCaseProductParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
