// ignore_for_file: must_be_immutable
import 'package:dartz/dartz.dart';

import '../../../../core/config/errors/errors.dart';
import '../../../../core/interfaces/use_case.dart';
import '../repository/qrcode_repository.dart';

AddUseCaseQrCodeParams filterUseCaseUserParamsFromMap(
        Map<dynamic, dynamic> params) =>
    AddUseCaseQrCodeParams.fromMap(params);

class AddQrCodeUseCase<QrCodeModel>
    implements UseCase<QrCodeModel, AddUseCaseQrCodeParams> {
  final QrCodeRepository<QrCodeModel> repository;
  late AddUseCaseQrCodeParams? parameters;

  AddQrCodeUseCase(this.repository);

  @override
  Future<Either<Failure, QrCodeModel>> call(
    AddUseCaseQrCodeParams? params,
  ) async {
    return await repository
        .add(params != null ? params.toJson() : getParams()!.toJson());
  }

  @override
  AddUseCaseQrCodeParams? getParams() {
    return parameters =
        parameters ?? AddUseCaseQrCodeParams(userName: "", information: "");
  }

  @override
  UseCase<QrCodeModel, AddUseCaseQrCodeParams> setParams(
      AddUseCaseQrCodeParams params) {
    parameters = params;
    return this;
  }

  @override
  UseCase<QrCodeModel, AddUseCaseQrCodeParams> setParamsFromMap(Map params) {
    parameters = AddUseCaseQrCodeParams.fromMap(params);
    return this;
  }
}

class AddUseCaseQrCodeParams extends Parametizable {
  final String? uuid, userName, information;
  final DateTime? expirationDate;
  final int cheekCount;

  AddUseCaseQrCodeParams({
    required this.userName,
    this.uuid,
    required this.information,
    this.expirationDate,
    this.cheekCount = 0,
  }) : super();

  factory AddUseCaseQrCodeParams.fromMap(Map<dynamic, dynamic> params) =>
      AddUseCaseQrCodeParams(
        uuid: params.containsKey("uuid") ? params["uuid"] : null,
        information:
            params.containsKey("information") ? params["information"] : null,
        userName: params.containsKey("userName") ? params["userName"] : null,
        cheekCount: params.containsKey("cheekCount") ? params["cheekCount"] : 0,
        expirationDate: params.containsKey("uuexpirationDateid")
            ? params["expirationDate"]
            : null,
      );

  @override
  bool isValid() {
    return userName != null &&
        userName!.isNotEmpty &&
        information != null &&
        information!.isNotEmpty;
  }

  @override
  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "information": information,
        "userName": userName,
        "cheekCount": cheekCount,
        "expirationDate": expirationDate
      };
}
