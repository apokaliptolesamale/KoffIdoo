import 'dart:developer';
import '../../../core/config/app_config.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/ez_home_controller.dart';
import '../domain/models/destinatario_model.dart';
import '../domain/usecases/get_destinatarios_usecase.dart';
import '../domain/usecases/reset_payment_password_usecase.dart';
import '../views/pages/ez_profile_configurations_page.dart';
import '../views/pages/ez_profile_configurations_payment_config_page.dart';
import '../views/pages/ez_profile_destinatarios_page.dart';
import '../views/pages/ez_profile_info_page.dart';
import '../views/pages/ez_profile_page.dart';
import '../views/pages/ez_profile_reset_payment_password.dart';
import '../views/pages/ez_secuity_profile_page.dart';
import '../views/pages/ez_security_profile_totp_page.dart';
import '/app/modules/security/domain/usecases/disabletotp_usecase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../../security/data/providers/token_provider.dart';
import '../account_exporting.dart';
import '../data/providers/account_provider.dart';
import '../domain/models/account_model.dart';
import '../domain/usecases/add_account_usecase.dart';
import '../domain/usecases/change_account_password.dart';
import '../domain/usecases/delete_account_usecase.dart';
import '../domain/usecases/filter_account_usecase.dart';
import '../domain/usecases/get_account_usecase.dart';
import '../domain/usecases/get_gettotp_usecase.dart';
import '../domain/usecases/getby_account_usecase.dart';
import '../domain/usecases/list_account_usecase.dart';
import '../domain/usecases/update_account_usecase.dart';

class AccountBinding extends Bindings {
  AccountBinding() : super() {
    if (!Get.isRegistered<AccountBinding>()) {
      Get.lazyPut<AccountBinding>(
        () => this,
      );
      // loadPages();
      dependencies();
    }
    log("Registrando instancia de:${toString()} y sus dependencias.");
  }

  @override
  void dependencies() {
    Get.lazyPut<AccountBinding>(() => this);
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );

    Get.lazyPut<home_app.HomeController>(
      () => home_app.HomeController(),
    );
    Get.lazyPut<EzHomeController>(
      () => EzHomeController(),
    );
    Get.lazyPut<http.Client>(
      () => http.Client(),
    );
    Get.lazyPut<rest_client.Client>(
      () => rest_client.Client(),
    );
    Get.lazyPut<AccountProvider>(
      () => AccountProvider(),
    );
    Get.lazyPut<FlutterSecureStorage>(
      () => FlutterSecureStorage(),
    );
    Get.lazyPut<RemoteAccountDataSourceImpl>(
      () => RemoteAccountDataSourceImpl(),
    );
    Get.lazyPut<LocalAccountDataSourceImpl>(
      () => LocalAccountDataSourceImpl(),
    );
    Get.lazyPut<Repository<AccountModel>>(
      () => AccountRepositoryImpl<AccountModel>(FlutterSecureStorage()),
    );
    Get.lazyPut<AccountRepository<AccountModel>>(
      () => AccountRepositoryImpl<AccountModel>(FlutterSecureStorage()),
    );

    Get.lazyPut<UseCase>(
      () => AddAccountUseCase<AccountModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteAccountUseCase<AccountModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetAccountUseCase<AccountModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetAccountByFieldUseCase<AccountModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdateAccountUseCase<AccountModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ListAccountUseCase<AccountModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterAccountUseCase<AccountModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ChangeAccountPasswordUseCase<AccountModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ResetPaymentPasswordPasswordUseCase<AccountModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetGetTotpUseCase<AccountModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetDisableTotpUseCase<AccountModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetDestinatariosUseCase<DestinatarioModel>(Get.find()),
    );
    Get.lazyPut<AccountController>(
        () => AccountController(FlutterSecureStorage()));
  }

  // static loadPages() {
  //   log("Inicializando páginas del módulo");
  //   // final loginRoute = ConfigApp.instance.configModel!.loginRoute;
  //   AppPages.addAllRouteIfAbsent([
  //     EzProfileConfigPageImpl.builder(
  //         // middlewares: [AuthMidleware()],
  //         ),
  //     EzProfilePaymentConfigPageImpl.builder(
  //         // middlewares: [AuthMidleware()],
  //         ),
  //     EzProfileInfoPageImpl.builder(
  //         // middlewares: [AuthMidleware()],
  //         ),
  //     // EzResetPaymentPasswordPageImpl.builder(
  //     //     // middlewares: [AuthMidleware()],
  //     //     ),
  //     EzProfilePageImpl.builder(
  //         // middlewares: [AuthMidleware()],
  //         ),
  //     EzSecurityProfilePageImpl.builder(
  //         // middlewares: [AuthMidleware()],
  //         ),
  //     EzProfileTOTPPageImpl.builder(
  //         // middlewares: [AuthMidleware()],
  //         ),
  //     EzProfileDestinatarioPageImpl.builder(),

  //     ResetPaymentPasswordPageImpl.builder(),
  //     // TransactionPageImpl.builder(),
  //     // SecurityAppPageImpl.builder(name: loginRoute),

  //     //SecurityAppPageImpl.builder(),
  //     // SecurityApkCallBackPageImpl.builder(),
  //     // UserNotificationsPageImpl.builder(),
  //     // ProfilePageImpl.builder(),
  //     // TransactionPageImpl.builder(),
  //     // ElectricityService.builder()
  //   ]);
  // }
}
