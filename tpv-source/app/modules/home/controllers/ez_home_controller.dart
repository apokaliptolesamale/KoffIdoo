import 'package:dartz/dartz.dart' as dartz;

import 'package:get/get.dart';

import '../../../../app/core/services/logger_service.dart';
import '../../../core/config/errors/errors.dart';
import '../../security/controllers/security_controller.dart';

import '../../security/domain/models/account_model.dart';
import '../../security/domain/usecases/get_account_usecase.dart';

class EzHomeController extends GetxController {
  final security = Get.find<SecurityController>();
// AuthenticateUseCase<TokenModel> authenticateUseCase =
//       AuthenticateUseCase<TokenModel>(
//           Get.put(TokenRepositoryImpl<TokenModel>()));
  GetAccountUseCase<AccountModel> getAccount =
      GetAccountUseCase<AccountModel>(Get.find());

  // GetItemsUseCase getItemsUseCase = GetItemsUseCase(Get.find());
  // final _getItemsUseCase = Get.find<GetItemsUseCase>();
  late int _currentIndex;
  EzHomeController() {
    // this.profileLocalDataSource;
    _currentIndex = 0;
  }

  int get currentindex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    update();
  }

  Future<dartz.Either<Failure, AccountModel>> getAccountModel() async {
    getAccount.setParamsFromMap({"username": ""});
    var aux = await getAccount.call(null);
    return aux;
    // return await controller.getFutureByUseCase(controller.getAccount);
    // if (account == dartz.Left<Failure, AccountModel>) {
    //   Get.snackbar("Atención!!!",
    //       "Ha ocurrido un error al encontrar la información de su cuenta, por favor cierre sesión.");
    // }

    // final dartz.Right resultData = account as dartz.Right;
    // if (!Get.isRegistered<AccountModel>()) {
    //   Get.put<AccountModel>(resultData.value);
    // }
    // final aux = resultData.value as Account;
    // return aux;

    // Get.put<AccountModel>(resultData.value);

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

  // Future<T> getFutureByUseCase<T>(UseCase uc) {
  //   Future<T> result;

  //   if (uc is GetAccountUseCase) {
  //     result = getAccountModel().then((value) => Future.value(value as T));
  //   }
  //   return result;
  // }

  @override
  void onClose() {}

  @override
  void onInit() {
    log('inciando EZ home view');

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    log('EZ home view iniciado');
    // getAccountModel();
  }
}
