// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/tpv_repository.dart';

AddProductToCartUseCaseTpvParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddProductToCartUseCaseTpvParams.fromMap(params);

class AddProductToCartUseCase<TpvModel>
    implements UseCase<TpvModel, AddProductToCartUseCaseTpvParams> {
  final TpvRepository<TpvModel> repository;
  late AddProductToCartUseCaseTpvParams? parameters;

  AddProductToCartUseCase(this.repository);

  @override
  Future<Either<Failure, TpvModel>> call(
    AddProductToCartUseCaseTpvParams? params,
  ) async {
    return await repository.add(parameters = params);
  }

  @override
  AddProductToCartUseCaseTpvParams? getParams() {
    return parameters = parameters ?? AddProductToCartUseCaseTpvParams(id: 0);
  }

  @override
  UseCase<TpvModel, AddProductToCartUseCaseTpvParams> setParams(
      AddProductToCartUseCaseTpvParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<TpvModel, AddProductToCartUseCaseTpvParams> setParamsFromMap(
      Map params) {
    parameters = AddProductToCartUseCaseTpvParams.fromMap(params);
    return this;
  }
}

class AddProductToCartUseCaseTpvParams extends Parametizable {
  final int id;
  AddProductToCartUseCaseTpvParams({required this.id}) : super();

  factory AddProductToCartUseCaseTpvParams.fromMap(
          Map<dynamic, dynamic> params) =>
      AddProductToCartUseCaseTpvParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
