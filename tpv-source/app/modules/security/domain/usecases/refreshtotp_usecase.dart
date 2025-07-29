// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/account_repository.dart';

class GetRefreshTotpUseCase<RefreshTotpModel>
    implements UseCase<RefreshTotpModel, GetUseCaseRefreshTotpParams> {
  final AccountRepository<RefreshTotpModel> repository;
  late GetUseCaseRefreshTotpParams? parameters;

  GetRefreshTotpUseCase(this.repository);

  @override
  Future<Either<Failure, RefreshTotpModel>> call(
    GetUseCaseRefreshTotpParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.getRefreshTotp();
  }

  @override
  GetUseCaseRefreshTotpParams? getParams() {
    return parameters = parameters ?? GetUseCaseRefreshTotpParams(id: 0);
  }

  @override
  UseCase<RefreshTotpModel, GetUseCaseRefreshTotpParams> setParams(
      GetUseCaseRefreshTotpParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<RefreshTotpModel, GetUseCaseRefreshTotpParams> setParamsFromMap(
      Map params) {
    parameters = GetUseCaseRefreshTotpParams.fromMap(params);
    return this;
  }
}

GetUseCaseRefreshTotpParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseRefreshTotpParams.fromMap(params);

class GetUseCaseRefreshTotpParams extends Parametizable {
  final int id;
  GetUseCaseRefreshTotpParams({
    required this.id,
  }) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetUseCaseRefreshTotpParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseRefreshTotpParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
