// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/card_model.dart';
import '../repository/card_repository.dart';

AddUseCaseCardParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseCardParams.fromMap(params);

class AddCardUseCase<CardModel>
    implements UseCase<CardModel, AddUseCaseCardParams> {
  final CardRepository<CardModel> repository;
  late AddUseCaseCardParams? parameters;

  AddCardUseCase(this.repository);

  @override
  Future<Either<Failure, CardModel>> call(
    AddUseCaseCardParams? params,
  ) async {
    return params != null
        ? await repository.add((parameters = params).id)
        : Left(NulleableFailure(message: "Sin parámetros"));
  }

  @override
  AddUseCaseCardParams? getParams() {
    return parameters = parameters ??
        AddUseCaseCardParams(
            id: AddCardModel(
                pan: '', cardholder: '', expdate: '', cadenaEncript: ''));
  }

  @override
  UseCase<CardModel, AddUseCaseCardParams> setParams(
      AddUseCaseCardParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<CardModel, AddUseCaseCardParams> setParamsFromMap(Map params) {
    parameters = AddUseCaseCardParams.fromMap(params);
    return this;
  }
}

class AddUseCaseCardParams extends Parametizable {
  final AddCardModel id;
  AddUseCaseCardParams({required this.id}) : super();

  factory AddUseCaseCardParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCaseCardParams(
          id: params.containsKey("id")
              ? params["id"]
              : AddCardModel(
                  cadenaEncript: '', pan: '', expdate: '', cardholder: ''));

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
