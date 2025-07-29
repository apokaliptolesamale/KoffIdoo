// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/gift_repository.dart';

class ListGiftUseCase<GiftModel> implements UseCase<EntityModelList<GiftModel>, ListUseCaseGiftParams> {
 
  final GiftRepository<GiftModel> repository;
  late ListUseCaseGiftParams? parameters;

  ListGiftUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<GiftModel>>> call(
    ListUseCaseGiftParams? params,
  ) async {
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<GiftModel>>> getAll() async {
    return await call(getParams());
  }

  @override
  ListUseCaseGiftParams? getParams() {
    return parameters=parameters ?? ListUseCaseGiftParams();
  }

  @override
  UseCase<EntityModelList<GiftModel>, ListUseCaseGiftParams> setParams(
      ListUseCaseGiftParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<GiftModel>, ListUseCaseGiftParams> setParamsFromMap(Map params) {
    parameters = ListUseCaseGiftParams.fromMap(params);
    return this;
  }
}

ListUseCaseGiftParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseGiftParams.fromMap(params);

class ListUseCaseGiftParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseGiftParams({
    this.start=-1,
    this.limit=-1,
    this.getAll=false,
  }) : super() {
    if(start==-1||limit==-1) getAll = true;
  }

  @override
  bool isValid() {
    return start! > 0 && start! < limit!;
  }

  factory ListUseCaseGiftParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseGiftParams(
        start: params.containsKey("start") ? params["start"] : 1,
        limit: params.containsKey("limit") ? params["limit"] : 50,
      );

  @override
  Map<String, dynamic> toJson() => {"start": start ?? 1, "limit": limit ?? 50};
}
