// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/qrcode_model.dart';
import '../repository/qrcode_repository.dart';

class UpdateQrCodeUseCase<QrCodeModelEntity extends QrCodeModel>
    implements UseCase<QrCodeModelEntity, UpdateUseCaseQrCodeParams> {
  final QrCodeRepository<QrCodeModelEntity> repository;
  late UpdateUseCaseQrCodeParams? parameters;
  UpdateQrCodeUseCase(this.repository);

  @override
  Future<Either<Failure, QrCodeModelEntity>> call(
    UpdateUseCaseQrCodeParams? params,
  ) async {
    return await repository.update((parameters = params)!.id, params!.entity);
  }

  @override
  UpdateUseCaseQrCodeParams? getParams() {
    return parameters = parameters ??
        UpdateUseCaseQrCodeParams(
            id: 0, entity: QrCodeModel(userName: "", information: ""));
  }

  @override
  UseCase<QrCodeModelEntity, UpdateUseCaseQrCodeParams> setParams(
      UpdateUseCaseQrCodeParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<QrCodeModelEntity, UpdateUseCaseQrCodeParams> setParamsFromMap(
      Map params) {
    return this;
  }
}

class UpdateUseCaseQrCodeParams extends Parametizable {
  final dynamic id;
  final QrCodeModel entity;
  UpdateUseCaseQrCodeParams({required this.id, required this.entity}) : super();
}
