// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../models/qrcode_model.dart';
import '../repository/qrcode_repository.dart';

DeleteUseCaseQrCodeParams deleteUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    DeleteUseCaseQrCodeParams.fromMap(params);

class DeleteQrCodeUseCase<QrCodeModelEntity extends QrCodeModel>
    implements UseCase<QrCodeModelEntity, DeleteUseCaseQrCodeParams> {
  final QrCodeRepository<QrCodeModelEntity> repository;

  late DeleteUseCaseQrCodeParams? parameters;

  DeleteQrCodeUseCase(this.repository);

  @override
  Future<Either<Failure, QrCodeModelEntity>> call(
    DeleteUseCaseQrCodeParams? params,
  ) async {
    return await repository.delete((parameters = params)!.id);
  }

  @override
  DeleteUseCaseQrCodeParams? getParams() {
    return parameters = parameters ?? DeleteUseCaseQrCodeParams(id: 0);
  }

  @override
  UseCase<QrCodeModelEntity, DeleteUseCaseQrCodeParams> setParams(
      DeleteUseCaseQrCodeParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<QrCodeModelEntity, DeleteUseCaseQrCodeParams> setParamsFromMap(
      Map params) {
    parameters = DeleteUseCaseQrCodeParams.fromMap(params);
    return this;
  }
}

class DeleteUseCaseQrCodeParams extends Parametizable {
  final int id;
  DeleteUseCaseQrCodeParams({required this.id}) : super();

  factory DeleteUseCaseQrCodeParams.fromMap(Map<dynamic, dynamic> params) =>
      DeleteUseCaseQrCodeParams(
          id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
