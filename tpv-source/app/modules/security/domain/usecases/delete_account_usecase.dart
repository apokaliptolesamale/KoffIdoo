// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/models/account_model.dart';
import '../repository/account_repository.dart';

class DeleteAccountUseCase<AccountModelEntity extends AccountModel> implements UseCase<AccountModelEntity, DeleteUseCaseAccountParams> {

  final AccountRepository<AccountModelEntity> repository;
  
  late DeleteUseCaseAccountParams? parameters;

  DeleteAccountUseCase(this.repository);

  @override
  Future<Either<Failure, AccountModelEntity>> call(
    DeleteUseCaseAccountParams? params,
  ) async {
    return await repository.delete((parameters = params)!.id);
  }

  @override
  DeleteUseCaseAccountParams? getParams() {
    return parameters=parameters ?? DeleteUseCaseAccountParams(id:0);
  }

  @override
  UseCase<AccountModelEntity, DeleteUseCaseAccountParams> setParams(
      DeleteUseCaseAccountParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<AccountModelEntity, DeleteUseCaseAccountParams> setParamsFromMap(Map params) {
    parameters = DeleteUseCaseAccountParams.fromMap(params);
    return this;
  }

}

DeleteUseCaseAccountParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseAccountParams.fromMap(params);

class DeleteUseCaseAccountParams extends Parametizable {

  final int id;
  DeleteUseCaseAccountParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory DeleteUseCaseAccountParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCaseAccountParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

