// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/account_repository.dart';

class AddAccountUseCase<AccountModel> implements UseCase<AccountModel, AddUseCaseAccountParams> {

  final AccountRepository<AccountModel> repository;
  late AddUseCaseAccountParams? parameters;

  AddAccountUseCase(this.repository);

  @override
  Future<Either<Failure, AccountModel>> call(
    AddUseCaseAccountParams? params,
  ) async {
    return await repository.add(parameters=params);
  }

  @override
  AddUseCaseAccountParams? getParams() {
    return parameters=parameters ?? AddUseCaseAccountParams(id:0);
  }

  @override
  UseCase<AccountModel, AddUseCaseAccountParams> setParams(AddUseCaseAccountParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<AccountModel, AddUseCaseAccountParams> setParamsFromMap(Map params) {
    parameters = AddUseCaseAccountParams.fromMap(params);
    return this;
  }

}

AddUseCaseAccountParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseAccountParams.fromMap(params);

class AddUseCaseAccountParams extends Parametizable {

  final int id;
  AddUseCaseAccountParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory AddUseCaseAccountParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCaseAccountParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

