// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/product_repository.dart';

AddUseCaseProductParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseProductParams.fromMap(params);

class AddProductUseCase<ProductModel>
    implements UseCase<ProductModel, AddUseCaseProductParams> {
  final ProductRepository<ProductModel> repository;
  late AddUseCaseProductParams? parameters;

  AddProductUseCase(this.repository);

  @override
  Future<Either<Failure, ProductModel>> call(
    AddUseCaseProductParams? params,
  ) async {
    return await repository.add(parameters = params);
  }

  @override
  AddUseCaseProductParams? getParams() {
    return parameters = parameters ?? AddUseCaseProductParams(id: 0);
  }

  @override
  UseCase<ProductModel, AddUseCaseProductParams> setParams(
      AddUseCaseProductParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<ProductModel, AddUseCaseProductParams> setParamsFromMap(Map params) {
    parameters = AddUseCaseProductParams.fromMap(params);
    return this;
  }
}

class AddUseCaseProductParams extends Parametizable {
  final int id;
  AddUseCaseProductParams({required this.id}) : super();

  factory AddUseCaseProductParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCaseProductParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
