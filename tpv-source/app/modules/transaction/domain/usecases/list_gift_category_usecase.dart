// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/category_repository.dart';

class ListGiftCategoryUseCase<CategoryGiftModel> implements UseCase<EntityModelList<CategoryGiftModel>, ListUseCaseGiftCategoryParams> {
 
  final CategoryGiftRepository<CategoryGiftModel> repository;
  late ListUseCaseGiftCategoryParams? parameters;

  ListGiftCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<CategoryGiftModel>>> call(
    ListUseCaseGiftCategoryParams? params,
  ) async {
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<CategoryGiftModel>>> getAll() async {
    return await call(getParams());
  }

  @override
  ListUseCaseGiftCategoryParams? getParams() {
    return parameters=parameters ?? ListUseCaseGiftCategoryParams();
  }

  @override
  UseCase<EntityModelList<CategoryGiftModel>, ListUseCaseGiftCategoryParams> setParams(
      ListUseCaseGiftCategoryParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<CategoryGiftModel>, ListUseCaseGiftCategoryParams> setParamsFromMap(Map params) {
    parameters = ListUseCaseGiftCategoryParams.fromMap(params);
    return this;
  }
}

ListUseCaseGiftCategoryParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseGiftCategoryParams.fromMap(params);

class ListUseCaseGiftCategoryParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseGiftCategoryParams({
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

  factory ListUseCaseGiftCategoryParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseGiftCategoryParams(
        start: params.containsKey("start") ? params["start"] : 1,
        limit: params.containsKey("limit") ? params["limit"] : 50,
      );

  @override
  Map<String, dynamic> toJson() => {"start": start ?? 1, "limit": limit ?? 50};
}
