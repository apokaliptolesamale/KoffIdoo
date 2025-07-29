// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';

import '../repository/account_repository.dart';

class GetGetTotpUseCase<AccountModel>
    implements UseCase<AccountModel, GetUseCaseGetTotpParams> {
  final AccountRepository<AccountModel> repository;
  late GetUseCaseGetTotpParams? parameters;

  GetGetTotpUseCase(this.repository);

  @override
  Future<Either<Failure, AccountModel>> call(
    GetUseCaseGetTotpParams? params,
  ) async {
    return await repository.getTotp();
    // return (params == null && parameters == null)
    //     ? Left(NulleableFailure(
    //         message:
    //             "Ha ocurrido un error relacionado a los parámetros de la operación."))
    //     : await repository.getTotp();
  }

  @override
  GetUseCaseGetTotpParams? getParams() {
    return parameters = parameters ?? GetUseCaseGetTotpParams(id: 0);
  }

  @override
  UseCase<AccountModel, GetUseCaseGetTotpParams> setParams(
      GetUseCaseGetTotpParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<AccountModel, GetUseCaseGetTotpParams> setParamsFromMap(Map params) {
    parameters = GetUseCaseGetTotpParams.fromMap(params);
    return this;
  }
}

GetUseCaseGetTotpParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseGetTotpParams.fromMap(params);

class GetUseCaseGetTotpParams extends Parametizable {
  int? id;
  GetUseCaseGetTotpParams({
    this.id,
  }) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetUseCaseGetTotpParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseGetTotpParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
