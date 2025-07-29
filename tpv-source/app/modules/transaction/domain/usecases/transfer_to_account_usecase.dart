// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/transfer_repository.dart';

class GetTransferToAccountUseCase<TransferModel>
    implements UseCase<TransferModel, GetUseCaseTransferToAccountParams> {
  final TransferRepository<TransferModel> repository;
  late GetUseCaseTransferToAccountParams? parameters;

  GetTransferToAccountUseCase(this.repository);

  @override
  Future<Either<Failure, TransferModel>> call(
    GetUseCaseTransferToAccountParams? params,
  ) async {
    params = params ?? getParams();
    return await repository.transferToAccount(
        (parameters = params)!.id, params!.entity);
    // return (params==null && parameters==null)?Left(NulleableFailure(
    //     message: "Ha ocurrido un error relacionado a los parámetros de la operación.")): await repository.transferToAccount((params??parameters)!.id);
  }

  @override
  GetUseCaseTransferToAccountParams? getParams() {
    return parameters =
        parameters ?? GetUseCaseTransferToAccountParams(entity: parameters);
  }

  @override
  UseCase<TransferModel, GetUseCaseTransferToAccountParams> setParams(
      GetUseCaseTransferToAccountParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<TransferModel, GetUseCaseTransferToAccountParams> setParamsFromMap(
      Map params) {
    parameters = GetUseCaseTransferToAccountParams(entity: params);
    return this;
  }
}

GetUseCaseTransferToAccountParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseTransferToAccountParams.fromMap(params);

class GetUseCaseTransferToAccountParams extends Parametizable {
  dynamic id;
  final dynamic entity;
  GetUseCaseTransferToAccountParams({this.id, required this.entity}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetUseCaseTransferToAccountParams.fromMap(
          Map<dynamic, dynamic> params) =>
      GetUseCaseTransferToAccountParams(
          id: params.containsKey("id") ? params["id"] : 0,
          entity: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
