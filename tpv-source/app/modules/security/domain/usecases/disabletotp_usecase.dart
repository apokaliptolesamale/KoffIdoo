// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/account_repository.dart';

class GetDisableTotpUseCase<AccountModel>
    implements UseCase<AccountModel, GetUseCaseDisableTotpParams> {
  final AccountRepository<AccountModel> repository;
  late GetUseCaseDisableTotpParams? parameters;

  GetDisableTotpUseCase(this.repository);

  @override
  Future<Either<Failure, AccountModel>> call(
    GetUseCaseDisableTotpParams? params,
  ) async {
    return await repository.getDisableTotp();
    // (params == null && parameters == null)
    //     ? Left(NulleableFailure(
    //         message:
    //             "Ha ocurrido un error relacionado a los parámetros de la operación."))
    //     : await repository.getDisableTotp();
  }

  @override
  GetUseCaseDisableTotpParams? getParams() {
    return parameters = parameters ?? GetUseCaseDisableTotpParams(id: 0);
  }

  @override
  UseCase<AccountModel, GetUseCaseDisableTotpParams> setParams(
      GetUseCaseDisableTotpParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<AccountModel, GetUseCaseDisableTotpParams> setParamsFromMap(
      Map params) {
    parameters = GetUseCaseDisableTotpParams.fromMap(params);
    return this;
  }
}

GetUseCaseDisableTotpParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseDisableTotpParams.fromMap(params);

class GetUseCaseDisableTotpParams extends Parametizable {
  int? id;
  GetUseCaseDisableTotpParams({
    this.id,
  }) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetUseCaseDisableTotpParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseDisableTotpParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
