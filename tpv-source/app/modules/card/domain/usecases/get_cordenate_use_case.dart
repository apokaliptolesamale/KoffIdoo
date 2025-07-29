// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/cordenate_repository.dart';

class GetCordenateUseCase<CordenateModel>
    implements UseCase<CordenateModel, GetUseCaseCardParams> {
  final CordenateRepository<CordenateModel> repository;
  late GetUseCaseCardParams? parameters;

  GetCordenateUseCase(this.repository);

  @override
  Future<Either<Failure, CordenateModel>> call(
    GetUseCaseCardParams? params,
  ) async {
    return await repository.getCordenate();
  }

  @override
  GetUseCaseCardParams? getParams() {
    return parameters = parameters ?? GetUseCaseCardParams(id: 0);
  }

  @override
  UseCase<CordenateModel, GetUseCaseCardParams> setParams(
      GetUseCaseCardParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<CordenateModel, GetUseCaseCardParams> setParamsFromMap(Map params) {
    parameters = GetUseCaseCardParams.fromMap(params);
    return this;
  }
}

GetUseCaseCardParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseCardParams.fromMap(params);

class GetUseCaseCardParams extends Parametizable {
  final int id;
  GetUseCaseCardParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetUseCaseCardParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseCardParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
