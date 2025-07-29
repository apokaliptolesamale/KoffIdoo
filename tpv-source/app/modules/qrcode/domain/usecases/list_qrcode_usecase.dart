// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/qrcode_repository.dart';

ListUseCaseQrCodeParams getByFieldUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    ListUseCaseQrCodeParams.fromMap(params);

class ListQrCodeUseCase<QrCodeModel>
    implements UseCase<EntityModelList<QrCodeModel>, ListUseCaseQrCodeParams> {
  final QrCodeRepository<QrCodeModel> repository;
  late ListUseCaseQrCodeParams? parameters;

  ListQrCodeUseCase(this.repository);

  @override
  Future<Either<Failure, EntityModelList<QrCodeModel>>> call(
    ListUseCaseQrCodeParams? params,
  ) async {
    return await repository.getAll();
  }

  Future<Either<Failure, EntityModelList<QrCodeModel>>> getAll() async {
    return await call(getParams());
  }

  @override
  ListUseCaseQrCodeParams? getParams() {
    return parameters = parameters ?? ListUseCaseQrCodeParams();
  }

  @override
  UseCase<EntityModelList<QrCodeModel>, ListUseCaseQrCodeParams> setParams(
      ListUseCaseQrCodeParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<EntityModelList<QrCodeModel>, ListUseCaseQrCodeParams>
      setParamsFromMap(Map params) {
    parameters = ListUseCaseQrCodeParams.fromMap(params);
    return this;
  }
}

class ListUseCaseQrCodeParams extends Parametizable {
  final int? start;
  final int? limit;
  late bool? getAll;

  ListUseCaseQrCodeParams({
    this.start = -1,
    this.limit = -1,
    this.getAll = false,
  }) : super() {
    if (start == -1 || limit == -1) getAll = true;
  }

  factory ListUseCaseQrCodeParams.fromMap(Map<dynamic, dynamic> params) =>
      ListUseCaseQrCodeParams(
        start: params.containsKey("start") ? params["start"] : 1,
        limit: params.containsKey("limit") ? params["limit"] : 50,
      );

  @override
  bool isValid() {
    return start! > 0 && start! < limit!;
  }

  @override
  Map<String, dynamic> toJson() => {"start": start ?? 1, "limit": limit ?? 50};
}
