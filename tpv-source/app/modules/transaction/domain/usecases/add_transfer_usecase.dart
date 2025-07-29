// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/transfer_repository.dart';

class AddTransferUseCase<TransferModel>
    implements UseCase<TransferModel, AddUseCaseTransferParams> {
  final TransferRepository<TransferModel> repository;
  late AddUseCaseTransferParams? parameters;

  AddTransferUseCase(this.repository);

  @override
  Future<Either<Failure, TransferModel>> call(
    AddUseCaseTransferParams? params,
  ) async {
    return await repository.add(parameters = params);
  }

  @override
  AddUseCaseTransferParams? getParams() {
    return parameters = parameters ?? AddUseCaseTransferParams(id: 0);
  }

  @override
  UseCase<TransferModel, AddUseCaseTransferParams> setParams(
      AddUseCaseTransferParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<TransferModel, AddUseCaseTransferParams> setParamsFromMap(
      Map params) {
    parameters = AddUseCaseTransferParams.fromMap(params);
    return this;
  }
}

AddUseCaseTransferParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseTransferParams.fromMap(params);

class AddUseCaseTransferParams extends Parametizable {
  final int id;
  AddUseCaseTransferParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory AddUseCaseTransferParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCaseTransferParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
