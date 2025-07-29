// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/transfer_repository.dart';

class GetTransferToCardUseCase<TransferModel>
    implements UseCase<TransferModel, GetUseCaseTransferToCardParams> {
  final TransferRepository<TransferModel> repository;
  late GetUseCaseTransferToCardParams? parameters;

  GetTransferToCardUseCase(this.repository);

  @override
  Future<Either<Failure, TransferModel>> call(
    GetUseCaseTransferToCardParams? params,
  ) async {
    params = params ?? getParams();
    return await repository.transferToCard(
        (parameters = params)!.id, params!.entity);
    // return (params==null && parameters==null)?Left(NulleableFailure(
    //     message: "Ha ocurrido un error relacionado a los parámetros de la operación.")): await repository.transferToAccount((params??parameters)!.id);
  }

  @override
  GetUseCaseTransferToCardParams? getParams() {
    return parameters =
        parameters ?? GetUseCaseTransferToCardParams(entity: parameters);
  }

  @override
  UseCase<TransferModel, GetUseCaseTransferToCardParams> setParams(
      GetUseCaseTransferToCardParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<TransferModel, GetUseCaseTransferToCardParams> setParamsFromMap(
      Map params) {
    parameters = GetUseCaseTransferToCardParams(entity: params);
    // parameters = GetUseCaseTransferToCardParams.fromMap(params);
    return this;
  }
}

GetUseCaseTransferToCardParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseTransferToCardParams.fromMap(params);

class GetUseCaseTransferToCardParams extends Parametizable {
  dynamic id;
  final dynamic entity;
  GetUseCaseTransferToCardParams({this.id, required this.entity}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetUseCaseTransferToCardParams.fromMap(
          Map<dynamic, dynamic> params) =>
      GetUseCaseTransferToCardParams(
          id: params.containsKey("id") ? params["id"] : 0,
          entity: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
