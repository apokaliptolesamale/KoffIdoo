// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/account_repository.dart';

class GetVerifyTotpUseCase<AccountModel>
    implements UseCase<AccountModel, GetUseCaseVerifyTotpParams> {
  final AccountRepository<AccountModel> repository;
  late GetUseCaseVerifyTotpParams? parameters;

  GetVerifyTotpUseCase(this.repository);

  @override
  Future<Either<Failure, AccountModel>> call(
    GetUseCaseVerifyTotpParams? params,
  ) async {
    params = params ?? getParams();
    return await repository.getVerifyTotp(params!.entity);

    // (params == null && parameters == null)
    //     ? Left(NulleableFailure(
    //         message:
    //             "Ha ocurrido un error relacionado a los parámetros de la operación."))
    //     : await repository
    //         .getVerifyTotp(params == null ? parameters : parameters!.entity);
  }

  @override
  GetUseCaseVerifyTotpParams? getParams() {
    return parameters =
        parameters ?? GetUseCaseVerifyTotpParams(entity: parameters);
    // return parameters =
    //     parameters ?? GetUseCaseVerifyTotpParams(id: 0, entity: null);
  }

  @override
  UseCase<AccountModel, GetUseCaseVerifyTotpParams> setParams(
      GetUseCaseVerifyTotpParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<AccountModel, GetUseCaseVerifyTotpParams> setParamsFromMap(
      Map params) {
    parameters = GetUseCaseVerifyTotpParams(entity: params);
    return this;
  }
}

GetUseCaseVerifyTotpParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseVerifyTotpParams.fromMap(params);

class GetUseCaseVerifyTotpParams extends Parametizable {
  int? id;
  final dynamic entity;
  GetUseCaseVerifyTotpParams({this.id, required this.entity}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetUseCaseVerifyTotpParams.fromMap(dynamic params) {
    if (params is Map) {
      return GetUseCaseVerifyTotpParams(
          id: params.containsKey("id") ? params["id"] : 0,
          entity: params.containsKey("entiy") ? params["entity"] : null);
    } else {
      return GetUseCaseVerifyTotpParams(entity: params);
    }
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
