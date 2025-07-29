// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/models/gift_model.dart';
import '../repository/gift_repository.dart';

class DeleteGiftUseCase<GiftModelEntity extends GiftModel> implements UseCase<GiftModelEntity, DeleteUseCaseGiftParams> {

  final GiftRepository<GiftModelEntity> repository;
  
  late DeleteUseCaseGiftParams? parameters;

  DeleteGiftUseCase(this.repository);

  @override
  Future<Either<Failure, GiftModelEntity>> call(
    DeleteUseCaseGiftParams? params,
  ) async {
    return await repository.delete((parameters = params)!.id);
  }

  @override
  DeleteUseCaseGiftParams? getParams() {
    return parameters=parameters ?? DeleteUseCaseGiftParams(id:0);
  }

  @override
  UseCase<GiftModelEntity, DeleteUseCaseGiftParams> setParams(
      DeleteUseCaseGiftParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<GiftModelEntity, DeleteUseCaseGiftParams> setParamsFromMap(Map params) {
    parameters = DeleteUseCaseGiftParams.fromMap(params);
    return this;
  }

}

DeleteUseCaseGiftParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseGiftParams.fromMap(params);

class DeleteUseCaseGiftParams extends Parametizable {

  final int id;
  DeleteUseCaseGiftParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory DeleteUseCaseGiftParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCaseGiftParams(
        id: params.containsKey("id") ? params["id"] : 0 
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id
      };
   
}

