// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/card_repository.dart';

class GetCardUseCase<CardModel>
    implements UseCase<CardModel, GetUseCaseCardParams> {
  final CardRepository<CardModel> repository;
  late GetUseCaseCardParams? parameters;

  GetCardUseCase(this.repository);

  @override
  Future<Either<Failure, CardModel>> call(
    GetUseCaseCardParams? params,
  ) async {
    return await repository.getCard((parameters = params)!.id);
  }

  @override
  GetUseCaseCardParams? getParams() {
    return parameters = parameters ?? GetUseCaseCardParams(id: 0);
  }

  @override
  UseCase<CardModel, GetUseCaseCardParams> setParams(
      GetUseCaseCardParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<CardModel, GetUseCaseCardParams> setParamsFromMap(Map params) {
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
