// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../../domain/models/card_model.dart';
import '../repository/card_repository.dart';

class DeleteCardUseCase<CardModelEntity extends CardModel>
    implements UseCase<CardModelEntity, DeleteUseCaseCardParams> {
  final CardRepository<CardModelEntity> repository;

  late DeleteUseCaseCardParams? parameters;

  DeleteCardUseCase(this.repository);

  @override
  Future<Either<Failure, CardModelEntity>> call(
    DeleteUseCaseCardParams? params,
  ) async {
    return await repository.delete((parameters = params)!.id);
  }

  @override
  DeleteUseCaseCardParams? getParams() {
    return parameters = parameters ?? DeleteUseCaseCardParams(id: '');
  }

  @override
  UseCase<CardModelEntity, DeleteUseCaseCardParams> setParams(
      DeleteUseCaseCardParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<CardModelEntity, DeleteUseCaseCardParams> setParamsFromMap(
      Map params) {
    parameters = DeleteUseCaseCardParams.fromMap(params);
    return this;
  }
}

DeleteUseCaseCardParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseCardParams.fromMap(params);

class DeleteUseCaseCardParams extends Parametizable {
  final String id;
  DeleteUseCaseCardParams({required this.id}) : super();

  @override
  bool isValid() {
    return true;
  }

  factory DeleteUseCaseCardParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCaseCardParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
