// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/balance_repository.dart';

class GetBalanceUseCase<BalanceModel>
    implements UseCase<BalanceModel, GetBalanceUseCaseCardParams> {
  final BalanceRepository<BalanceModel> repository;
  late GetBalanceUseCaseCardParams? parameters;

  GetBalanceUseCase(this.repository);

  @override
  Future<Either<Failure, BalanceModel>> call(
    GetBalanceUseCaseCardParams? params,
  ) async {
    return await repository.getBalance((parameters = params)!.id);
  }

  @override
  GetBalanceUseCaseCardParams? getParams() {
    return parameters = parameters ?? GetBalanceUseCaseCardParams(id: '');
  }

  @override
  UseCase<BalanceModel, GetBalanceUseCaseCardParams> setParams(
      GetBalanceUseCaseCardParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<BalanceModel, GetBalanceUseCaseCardParams> setParamsFromMap(
      Map params) {
    parameters = GetBalanceUseCaseCardParams.fromMap(params);
    return this;
  }
}

GetBalanceUseCaseCardParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetBalanceUseCaseCardParams.fromMap(params);

class GetBalanceUseCaseCardParams extends Parametizable {
  final String id;
  GetBalanceUseCaseCardParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetBalanceUseCaseCardParams.fromMap(Map<dynamic, dynamic> params) =>
      GetBalanceUseCaseCardParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
