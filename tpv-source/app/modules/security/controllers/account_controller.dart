// ignore_for_file: unnecessary_overrides
import 'package:dartz/dartz.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '/app/modules/security/data/repositories/account_repository_impl.dart';
import '/app/modules/security/domain/usecases/change_account_password.dart';
import '/remote/basic_utils/basic_utils.dart';
import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../../../core/services/logger_service.dart';
import '../domain/entities/account.dart';
import '../domain/models/account_model.dart';
import '../domain/models/destinatario_model.dart';
import '../domain/usecases/add_account_usecase.dart';
import '../domain/usecases/delete_account_usecase.dart';
import '../domain/usecases/disabletotp_usecase.dart';
import '../domain/usecases/filter_account_usecase.dart';
import '../domain/usecases/get_account_usecase.dart';
import '../domain/usecases/get_destinatarios_usecase.dart';
import '../domain/usecases/get_gettotp_usecase.dart';
import '../domain/usecases/getby_account_usecase.dart';
import '../domain/usecases/list_account_usecase.dart';
import '../domain/usecases/reset_payment_password_usecase.dart';
import '../domain/usecases/update_account_usecase.dart';
import '../domain/usecases/verifytotp_usecase.dart';

class AccountController extends GetxController {
  FlutterSecureStorage storage;
  AddAccountUseCase<AccountModel> addAccount = AddAccountUseCase<AccountModel>(
      Get.put(AccountRepositoryImpl<AccountModel>(FlutterSecureStorage())));
  DeleteAccountUseCase<AccountModel> deleteAccount =
      DeleteAccountUseCase<AccountModel>(Get.find());
  GetAccountUseCase<AccountModel> getAccount =
      GetAccountUseCase<AccountModel>(Get.find());
  GetAccountByFieldUseCase<AccountModel> getAccountByField =
      GetAccountByFieldUseCase<AccountModel>(Get.find());
  UpdateAccountUseCase<AccountModel> updateAccount =
      UpdateAccountUseCase<AccountModel>(Get.find());
  ListAccountUseCase<AccountModel> listAccountUseAccount =
      ListAccountUseCase<AccountModel>(Get.find());
  FilterAccountUseCase<AccountModel> filterUseAccount =
      FilterAccountUseCase<AccountModel>(Get.find());
  ChangeAccountPasswordUseCase<AccountModel> changeAccountPassword =
      ChangeAccountPasswordUseCase<AccountModel>(Get.find());
  GetGetTotpUseCase<AccountModel> getTotp =
      GetGetTotpUseCase<AccountModel>(Get.find());
  GetDisableTotpUseCase<AccountModel> getDisableTotpUseCase =
      GetDisableTotpUseCase<AccountModel>(Get.find());
  GetVerifyTotpUseCase<AccountModel> getVerifyTotpUseCase =
      GetVerifyTotpUseCase<AccountModel>(Get.find());
  GetDestinatariosUseCase<DestinatarioModel> getDestinatariosUseCase =
      GetDestinatariosUseCase<DestinatarioModel>(Get.find());
  ResetPaymentPasswordPasswordUseCase<AccountModel>
      resetPaymentPasswordPasswordUseCase =
      ResetPaymentPasswordPasswordUseCase<AccountModel>(Get.find());

  AccountController(this.storage) : super();

  //respuesta que da el api: {setPassword: {updated: true}}
  Future<Either<Failure, AccountModel>> changePasswordAccount() {
    var resp = changeAccountPassword.call(null);
    update();
    return resp;
  }

  Future<String> cifrar(String texto) async {
    var certPuk = await rootBundle
        .loadString('assets/raw/enzona_assets_config_pubkey.pem');
    final publicKey = encrypt.RSAKeyParser().parse(certPuk) as RSAPublicKey;

    final encrypter = encrypt.Encrypter(encrypt.RSA(
      publicKey: publicKey,
    ));

    final encrypted = encrypter.encrypt(texto);

    texto = encrypted.base64;
    String test = encrypted.base64;

    log("Este es Texto Cifrado>>>>>>>>>>>>>>>>>> $texto");
    log("Este es Texto Cifrado TEST>>>>>>>>>>>>>>>>>> $test");
    return texto;
  }

  Future<String> cifrarBank(var texto) async {
    // var certPuk = cardF.bankCertificate;
    // var baseDecode = base64Decode(certPuk);
    // var str = String.fromCharCodes(baseDecode);
    // log("$str");
    // X509CertificateData pem = X509Utils.x509CertificateFromPem(str);
    // TbsCertificate certificate = pem.tbsCertificate!;
    // var publicKeyInfo = certificate.subjectPublicKeyInfo;

    // final hex = co.hex.decode(publicKeyInfo.bytes!);

    // final publicKey =
    //     CryptoUtils.rsaPublicKeyFromDERBytes(Uint8List.fromList(hex));

    // // final publicKey = encrypt.RSAKeyParser().parse(str) as RSAPublicKey;
    // final encrypter = encrypt.Encrypter(
    //     encrypt.RSA(encoding: encrypt.RSAEncoding.OAEP, publicKey: publicKey));
    // final encrypted = encrypter.encrypt(texto);
    // texto = encrypted.base64;
    return texto;
  }

  Future<Either<Failure, AccountModel>> disableToTPCode() async {
    var resp = await getDisableTotpUseCase.call(null);
    return resp;
  }

  Future<Either<Failure, Account>> editAccount(
      AccountModel accountModel) async {
    var resp =
        await updateAccount.setParamsFromMap(accountModel.toJson()).call(null);

    return resp;
  }

  Future<Either<Failure, EntityModelList<AccountModel>>> filterAccounts() =>
      filterUseAccount.filter();

  Future<Either<Failure, EntityModelList<DestinatarioModel>>>
      getDestinatarios() async {
    var aux = await getDestinatariosUseCase.call(null);
    return aux;
  }

  // Future<Either<Failure, Account>> getAccountModel() async {
  //   var account = await getAccount.call(null);
  //   final dartz.Right resultData = account as dartz.Right;
  //   final test = resultData.value;
  //   final test5 = resultData.value as Account;
  //   print(test5.email);
  //   log("ESTE ES TEST5>>>>>>>>>>>>>${test5.address}");

  //   return test;
  //   // return account.fold((l) => Left(l), (r) {
  //   //   if (r == AccountModel) {
  //   //     print(r);
  //   //     return Right(r);
  //   //   } else {
  //   //     throw Exception(
  //   //         "Error al traer la cuenta de enzona al entrar a la apk.");
  //   //   }
  //   // });
  // }

  // getProfileModel() async {
  //   SecurityController securityController = Get.find<SecurityController>();
  //   final service = ManagerAuthorizationService().get(defaultIdpKey);
  //   final session = service?.getUserSession();
  //   final idToken = session?.getToken;
  //   var profile = await securityController.getProfile(idToken!);
  //   return profile;
  // }

  // getProfileModel() async {
  //   SecurityController securityController = Get.find<SecurityController>();
  //   final service = ManagerAuthorizationService().get(defaultIdpKey);
  //   final session = service?.getUserSession();
  //   final idToken = session?.getToken;
  //   var profile = await securityController.getProfile(idToken!);
  //   return profile;
  // }

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is FilterAccountUseCase<AccountModel>) {
      filterUseAccount = uc;
      result = filterAccounts().then((value) => Future.value(value as T));
    } else if (uc is UpdateAccountUseCase<AccountModel>) {
      updateAccount = uc;
      result = updateAccounts().then((value) => Future.value(value as T));
    } else if (uc is ChangeAccountPasswordUseCase<AccountModel>) {
      changeAccountPassword = uc;
      result =
          changePasswordAccount().then((value) => Future.value(value as T));
    } else if (uc is ResetPaymentPasswordPasswordUseCase<AccountModel>) {
      resetPaymentPasswordPasswordUseCase = uc;
      result = resetPaymentPassword().then((value) => Future.value(value as T));
    } else if (uc is GetVerifyTotpUseCase<AccountModel>) {
      getVerifyTotpUseCase = uc;
      result = getVerifyTotpCode().then((value) => Future.value(value as T));
    } else {
      result = listAccounts().then((value) => Future.value(value as T));
    }
    return result;
  }

  Future<Either<Failure, AccountModel>> getToTPCode() {
    var resp = getTotp.call(null);

    return resp;
  }

  Future<Either<Failure, AccountModel>> getVerifyTotpCode() {
    var resp = getVerifyTotpUseCase.call(null);
    return resp;
  }

  Future<Either<Failure, EntityModelList<AccountModel>>> listAccounts() =>
      listAccountUseAccount.getAll();

  Future<dynamic> loadAsset() async {
    var file = await rootBundle.loadString('assets/config/pubkey.pem');
    return file;
  }

  /*"resetpaymentpassword": {"reseted":true,"funding_source_uuid":null,"status":3,"last4":null,"cardholder":null}*/
  Future<Either<Failure, AccountModel>> resetPaymentPassword() {
    var resp = resetPaymentPasswordPasswordUseCase.call(null);

    return resp;
  }

  Future<Either<Failure, AccountModel>> updateAccounts() {
    var resp = updateAccount.call(null);
    update();
    return resp;
  }

  // resetPaymentPassword(
  //     String fundingSourceUuid, String cadenaEncript, String? cm) async {
  //   // await resetPaymentPasswordUseCase.resetPaymentPassword(
  //   //     fundingSourceUuid, cadenaEncript, cm, accessToken);
  //   // refresh();
  //   // Get.back();
  // }

  updatePaymentPassword(AccountModel accountModel) async {
    // await updatePaymentPasswordUseCase.updatePaymentPassword(
    //     accountModel);
    // refresh();
    // Get.back();
  }
}
