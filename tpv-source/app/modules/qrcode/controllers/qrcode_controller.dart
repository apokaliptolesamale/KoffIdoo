// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../domain/models/qrcode_model.dart';
import '../domain/usecases/add_qrcode_usecase.dart';
import '../domain/usecases/delete_qrcode_usecase.dart';
import '../domain/usecases/filter_qrcode_usecase.dart';
import '../domain/usecases/get_qrcode_usecase.dart';
import '../domain/usecases/getby_qrcode_usecase.dart';
import '../domain/usecases/list_qrcode_usecase.dart';
import '../domain/usecases/update_qrcode_usecase.dart';

class QrCodeController extends GetxController {
  AddQrCodeUseCase<QrCodeModel> addQrCode =
      AddQrCodeUseCase<QrCodeModel>(Get.find());
  DeleteQrCodeUseCase<QrCodeModel> deleteQrCode =
      DeleteQrCodeUseCase<QrCodeModel>(Get.find());
  GetQrCodeUseCase<QrCodeModel> getQrCode =
      GetQrCodeUseCase<QrCodeModel>(Get.find());
  GetQrCodeByFieldUseCase<QrCodeModel> getQrCodeByField =
      GetQrCodeByFieldUseCase<QrCodeModel>(Get.find());
  UpdateQrCodeUseCase<QrCodeModel> updateQrCode =
      UpdateQrCodeUseCase<QrCodeModel>(Get.find());
  ListQrCodeUseCase<QrCodeModel> listQrCodeUseQrCode =
      ListQrCodeUseCase<QrCodeModel>(Get.find());
  FilterQrCodeUseCase<QrCodeModel> filterUseQrCode =
      FilterQrCodeUseCase<QrCodeModel>(Get.find());

  QrCodeController() : super();

  Future<Either<Failure, QrCodeModel>> addQrCodes() => addQrCode.call(null);

  Future<Either<Failure, EntityModelList<QrCodeModel>>> filterQrCodes() =>
      filterUseQrCode.filter();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is FilterQrCodeUseCase) {
      result = filterQrCodes().then((value) => Future.value(value as T));
    } else {
      result = getQrCodes().then((value) => Future.value(value as T));
    }
    return result;
  }

  Future<Either<Failure, EntityModelList<QrCodeModel>>> getQrCodes() =>
      listQrCodeUseQrCode.getAll();

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
