// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/tpv_repository.dart';

class ListTpvUseCase<TpvModel>
    implements UseCase<EntityModelList<TpvModel>, ListUseCaseTpvParams> {
  final TpvRepository<TpvModel> repository;
  late ListUseCaseTpvParams? parameters;

  ListTpvUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<TpvModel>>> call(
    ListUseCaseTpvParams? params,
  ) async {
    return (params == null && parameters == null)
        ? Left(NulleableFailure(
            message:
                "Ha ocurrido un error relacionado a los parámetros de la operación."))
        : await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<TpvModel>>> getAll() async {
    return await call(getParams());
  }

  @override
  ListUseCaseTpvParams? getParams() {
    return parameters = parameters ?? ListUseCaseTpvParams();
  }

  @override
  UseCase<EntityModelList<TpvModel>, ListUseCaseTpvParams> setParams(
      ListUseCaseTpvParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<TpvModel>, ListUseCaseTpvParams> setParamsFromMap(
      Map params) {
    parameters = ListUseCaseTpvParams.fromMap(params);
    return this;
  }
}

ListUseCaseTpvParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseTpvParams.fromMap(params);

class ListUseCaseTpvParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseTpvParams({
    this.start = -1,
    this.limit = -1,
    this.getAll = false,
  }) : super() {
    if (start == -1 || limit == -1) getAll = true;
  }

  @override
  bool isValid() {
    return start! > 0 && start! < limit!;
  }

  factory ListUseCaseTpvParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseTpvParams(
        start: params.containsKey("start") ? params["start"] : 1,
        limit: params.containsKey("limit") ? params["limit"] : 50,
      );

  @override
  Map<String, dynamic> toJson() => {"start": start ?? 1, "limit": limit ?? 50};
}
