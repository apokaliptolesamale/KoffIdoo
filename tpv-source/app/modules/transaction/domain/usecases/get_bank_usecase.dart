// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/bank_repository.dart';

class GetBankUseCase<BankModel> implements UseCase<BankModel, GetUseCaseBankParams> {

  final BankRepository<BankModel> repository;
  late GetUseCaseBankParams? parameters;

  GetBankUseCase(this.repository);

  @override
  Future<Either<Failure, BankModel>> call(
    GetUseCaseBankParams? params,
  ) async {
    return await repository.getBank((params??parameters)!.id);
  }

  @override
  GetUseCaseBankParams? getParams() {
    return parameters=parameters ?? GetUseCaseBankParams(id:0);
  }

  @override
  UseCase<BankModel, GetUseCaseBankParams> setParams(
      GetUseCaseBankParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<BankModel, GetUseCaseBankParams> setParamsFromMap(Map params) {
    parameters = GetUseCaseBankParams.fromMap(params);
    return this;
  }

}

GetUseCaseBankParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseBankParams.fromMap(params);

class GetUseCaseBankParams extends Parametizable {
  
  final int id;
  GetUseCaseBankParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetUseCaseBankParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseBankParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

