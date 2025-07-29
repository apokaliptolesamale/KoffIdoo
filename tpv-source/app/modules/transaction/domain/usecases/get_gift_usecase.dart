// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/gift_repository.dart';

class GetGiftUseCase<GiftModel> implements UseCase<GiftModel, GetUseCaseGiftParams> {

  final GiftRepository<GiftModel> repository;
  late GetUseCaseGiftParams? parameters;

  GetGiftUseCase(this.repository);

  @override
  Future<Either<Failure, GiftModel>> call(
    GetUseCaseGiftParams? params,
  ) async {
    return await repository.getGift((parameters = params)!.id);
  }

  @override
  GetUseCaseGiftParams? getParams() {
    return parameters=parameters ?? GetUseCaseGiftParams(id:0);
  }

  @override
  UseCase<GiftModel, GetUseCaseGiftParams> setParams(
      GetUseCaseGiftParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<GiftModel, GetUseCaseGiftParams> setParamsFromMap(Map params) {
    parameters = GetUseCaseGiftParams.fromMap(params);
    return this;
  }

}

GetUseCaseGiftParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseGiftParams.fromMap(params);

class GetUseCaseGiftParams extends Parametizable {
  
  final int id;
  GetUseCaseGiftParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory GetUseCaseGiftParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseGiftParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

