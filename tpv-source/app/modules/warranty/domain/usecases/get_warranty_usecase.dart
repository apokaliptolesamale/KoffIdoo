// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/warranty_repository.dart';

GetUseCaseWarrantyParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseWarrantyParams.fromMap(params);

class GetUseCaseWarrantyParams extends Parametizable {
  final dynamic id;
  GetUseCaseWarrantyParams({required this.id}) : super();

  factory GetUseCaseWarrantyParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseWarrantyParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}

class GetWarrantyUseCase<WarrantyModel>
    implements UseCase<WarrantyModel, GetUseCaseWarrantyParams> {
  final WarrantyRepository<WarrantyModel> repository;
  late GetUseCaseWarrantyParams? parameters;

  GetWarrantyUseCase(this.repository);

  @override
  Future<Either<Failure, WarrantyModel>> call(
    GetUseCaseWarrantyParams? params,
  ) async {
    parameters = params ?? getParams();
    return await repository.getWarranty(parameters!.id);
  }

  @override
  GetUseCaseWarrantyParams? getParams() {
    return parameters = parameters ?? GetUseCaseWarrantyParams(id: 0);
  }

  @override
  UseCase<WarrantyModel, GetUseCaseWarrantyParams> setParams(
      GetUseCaseWarrantyParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<WarrantyModel, GetUseCaseWarrantyParams> setParamsFromMap(
      Map params) {
    parameters = GetUseCaseWarrantyParams.fromMap(params);
    return this;
  }
}
