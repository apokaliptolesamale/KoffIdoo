// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../../qrcode/domain/models/qrcode_model.dart';
import '../../qrcode/domain/usecases/get_vendor_id_code_usecase.dart';
import '../../security/domain/models/account_model.dart';
import '../../security/domain/usecases/get_account_usecase.dart';
import '../domain/models/transfer_model.dart';
import '../domain/usecases/add_transfer_usecase.dart';
import '../domain/usecases/delete_transfer_usecase.dart';
import '../domain/usecases/filter_transfer_usecase.dart';
import '../domain/usecases/get_transfer_usecase.dart';
import '../domain/usecases/getby_transfer_usecase.dart';
import '../domain/usecases/list_transfer_usecase.dart';
import '../domain/usecases/transfer_to_account_usecase.dart';
import '../domain/usecases/transfer_to_card_usecase.dart';
import '../domain/usecases/update_transfer_usecase.dart';

class TransferController extends GetxController {
  AddTransferUseCase<TransferModel> addTransfer =
      AddTransferUseCase<TransferModel>(Get.find());
  DeleteTransferUseCase<TransferModel> deleteTransfer =
      DeleteTransferUseCase<TransferModel>(Get.find());
  GetTransferUseCase<TransferModel> getTransfer =
      GetTransferUseCase<TransferModel>(Get.find());
  GetTransferByFieldUseCase<TransferModel> getTransferByField =
      GetTransferByFieldUseCase<TransferModel>(Get.find());
  UpdateTransferUseCase<TransferModel> updateTransfer =
      UpdateTransferUseCase<TransferModel>(Get.find());
  ListTransferUseCase<TransferModel> listTransferUseTransfer =
      ListTransferUseCase<TransferModel>(Get.find());
  FilterTransferUseCase<TransferModel> filterUseTransfer =
      FilterTransferUseCase<TransferModel>(Get.find());
  GetAccountUseCase<AccountModel> getAccount =
      GetAccountUseCase<AccountModel>(Get.find());
  GetTransferToAccountUseCase<TransferModel> transferToAccountUseCase =
      GetTransferToAccountUseCase<TransferModel>(Get.find());
  GetTransferToCardUseCase<TransferModel> transferToCardUseCase =
      GetTransferToCardUseCase<TransferModel>(Get.find());
  GetVendorIdCodeUseCase<QrCodeModel> getVendorIdCodeUseCase =
      GetVendorIdCodeUseCase<QrCodeModel>(Get.find());

  TransferController() : super();

  Future<Either<Failure, AccountModel>> findAccount() async {
    var account = await getAccount.call(null);
    // final Right resultData = account as Right;
    // final test = resultData.value;
    // final test5 = resultData.value as Account;
    // print(test5.email);
    // log("ESTE ES TEST5>>>>>>>>>>>>>${test5.address}");

    return account;
    // return account.fold((l) => Left(l), (r) {
    //   if (r == AccountModel) {
    //     print(r);
    //     return Right(r);
    //   } else {
    //     throw Exception(
    //         "Error al traer la cuenta de enzona al entrar a la apk.");
    //   }
    // });
  }

  Future<Either<Failure, EntityModelList<TransferModel>>> getTransfers() =>
      listTransferUseTransfer.getAll();

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

  Future<Either<Failure, TransferModel>> transferToAccount() {
    var resp = transferToAccountUseCase.call(null);
    // if (resp == Left<Failure, TransferModel>) {
    //   Get.toNamed("/ezhome");
    //   Get.snackbar("Atención!!!",
    //       "Ha ocurrido un error al encontrar la información de su cuenta, por favor cierre sesión.");
    // }else{
    //   final Right resultData = resp as Right;
    //   final aux = resultData.value as TransferModel;
    //   if(aux)
    // }
    return resp;
  }

  Future<Either<Failure, QrCodeModel>> getVendorIdCode() {
    var resp = getVendorIdCodeUseCase.call(null);
    // if (resp == Left<Failure, TransferModel>) {
    //   Get.toNamed("/ezhome");
    //   Get.snackbar("Atención!!!",
    //       "Ha ocurrido un error al encontrar la información de su cuenta, por favor cierre sesión.");
    // }else{
    //   final Right resultData = resp as Right;
    //   final aux = resultData.value as TransferModel;
    //   if(aux)
    // }
    return resp;
  }

  Future<Either<Failure, TransferModel>> transferToCard() {
    var resp = transferToCardUseCase.call(null);
    // if (resp == Left<Failure, TransferModel>) {
    //   Get.toNamed("/ezhome");
    //   Get.snackbar("Atención!!!",
    //       "Ha ocurrido un error al encontrar la información de su cuenta, por favor cierre sesión.");
    // }else{
    //   final Right resultData = resp as Right;
    //   final aux = resultData.value as TransferModel;
    //   if(aux)
    // }
    return resp;
  }

  Future<Either<Failure, EntityModelList<TransferModel>>> filterTransfers() =>
      filterUseTransfer.filter();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is FilterTransferUseCase) {
      result = filterTransfers().then((value) => Future.value(value as T));
    } else if (uc is GetVendorIdCodeUseCase) {
      result = getVendorIdCode().then((value) => Future.value(value as T));
    } else if (uc is ListTransferUseCase) {
      result = getTransfers().then((value) => Future.value(value as T));
    } else if (uc is GetTransferToAccountUseCase) {
      result = getTransfers().then((value) => Future.value(value as T));
    } else {
      result = findAccount().then((value) => Future.value(value as T));
    }
    return result;
  }
}
