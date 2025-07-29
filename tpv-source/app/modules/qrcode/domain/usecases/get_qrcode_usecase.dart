// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/qrcode_repository.dart';

GetUseCaseQrCodeParams getUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    GetUseCaseQrCodeParams.fromMap(params);

class GetQrCodeUseCase<QrCodeModel>
    implements UseCase<QrCodeModel, GetUseCaseQrCodeParams> {
  final QrCodeRepository<QrCodeModel> repository;
  late GetUseCaseQrCodeParams? parameters;

  GetQrCodeUseCase(this.repository);

  @override
  Future<Either<Failure, QrCodeModel>> call(
    GetUseCaseQrCodeParams? params,
  ) async {
    return await repository.getQrCode((parameters = params)!.id);
  }

  @override
  GetUseCaseQrCodeParams? getParams() {
    return parameters = parameters ?? GetUseCaseQrCodeParams(id: 0);
  }

  @override
  UseCase<QrCodeModel, GetUseCaseQrCodeParams> setParams(
      GetUseCaseQrCodeParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<QrCodeModel, GetUseCaseQrCodeParams> setParamsFromMap(Map params) {
    parameters = GetUseCaseQrCodeParams.fromMap(params);
    return this;
  }
}

class GetUseCaseQrCodeParams extends Parametizable {
  final int id;
  GetUseCaseQrCodeParams({required this.id}) : super();

  factory GetUseCaseQrCodeParams.fromMap(Map<dynamic, dynamic> params) =>
      GetUseCaseQrCodeParams(id: params.containsKey("id") ? params["id"] : 0);

  @override
  bool isValid() {
    return true;
  }

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
