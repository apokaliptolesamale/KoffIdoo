// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/gift_repository.dart';

class AddGiftUseCase<GiftModel> implements UseCase<GiftModel, AddUseCaseGiftParams> {

  final GiftRepository<GiftModel> repository;
  late AddUseCaseGiftParams? parameters;

  AddGiftUseCase(this.repository);

  @override
  Future<Either<Failure, GiftModel>> call(
    AddUseCaseGiftParams? params,
  ) async {
    return await repository.add(parameters=params);
  }

  @override
  AddUseCaseGiftParams? getParams() {
    return parameters=parameters ?? AddUseCaseGiftParams(id:0);
  }

  @override
  UseCase<GiftModel, AddUseCaseGiftParams> setParams(AddUseCaseGiftParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<GiftModel, AddUseCaseGiftParams> setParamsFromMap(Map params) {
    parameters = AddUseCaseGiftParams.fromMap(params);
    return this;
  }

}

AddUseCaseGiftParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseGiftParams.fromMap(params);

class AddUseCaseGiftParams extends Parametizable {

  final int id;
  AddUseCaseGiftParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory AddUseCaseGiftParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCaseGiftParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

