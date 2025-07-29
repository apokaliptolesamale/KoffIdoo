// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/transfer_repository.dart';

class GetTransferUseCase<TransferModel> implements UseCase<TransferModel, GetUseCaseTransferParams> {

  final TransferRepository<TransferModel> repository;
  late GetUseCaseTransferParams? parameters;

  GetTransferUseCase(this.repository);

  @override
  Future<Either<Failure, TransferModel>> call(
    GetUseCaseTransferParams? params,
  ) async {
    return await repository.getTransfer((parameters = params)!.id);
  }

  @override
  GetUseCaseTransferParams? getParams() {
    return parameters=parameters ?? GetUseCaseTransferParams(id:0);
  }

  @override
  UseCase<TransferModel, GetUseCaseTransferParams> setParams(
      GetUseCaseTransferParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<TransferModel, GetUseCaseTransferParams> setParamsFromMap(Map params) {
    parameters = GetUseCaseTransferParams.fromMap(params);
    return this;
  }

}

GetUseCaseTransferParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseTransferParams.fromMap(params);

class GetUseCaseTransferParams extends Parametizable {
  
  final int id;
  GetUseCaseTransferParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetUseCaseTransferParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseTransferParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

