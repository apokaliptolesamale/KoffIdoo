// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/account_repository.dart';

class GetAccountUseCase<AccountModel>
    implements UseCase<AccountModel, GetUseCaseAccountParams> {
  final AccountRepository<AccountModel> repository;
  late GetUseCaseAccountParams? parameters;

  GetAccountUseCase(this.repository);

  @override
  Future<Either<Failure, AccountModel>> call(
    GetUseCaseAccountParams? params,
  ) async {
    params = params ?? getParams();
    return await repository.getAccountModel(params.data);

    // return await repository.getAccountModel();
    // final tmp = (params ?? getParams()).toJson();
    // return tmp.containsKey("id")
    //     ? await repository.getAccount(tmp["id"])
    //     : await repository.getAccountModel();
  }

  @override
  GetUseCaseAccountParams getParams() {
    return parameters =
        parameters ?? GetUseCaseAccountParams(id: 0, data: parameters);
  }

  @override
  UseCase<AccountModel, GetUseCaseAccountParams> setParams(
      GetUseCaseAccountParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<AccountModel, GetUseCaseAccountParams> setParamsFromMap(Map params) {
    parameters = GetUseCaseAccountParams.fromMap(params);
    return this;
  }
}

GetUseCaseAccountParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseAccountParams.fromMap(params);

class GetUseCaseAccountParams extends Parametizable {
  final int? id;
  dynamic data;
  GetUseCaseAccountParams({this.id, this.data}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetUseCaseAccountParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseAccountParams(
          id: params.containsKey("id") ? params["id"] : 0,
          data: params.containsKey("username") ? params["username"] : "");

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
