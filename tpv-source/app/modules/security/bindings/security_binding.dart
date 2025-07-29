import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '../../transaction/views/pages/gas_service_page.dart';
import '/app/core/config/app_config.dart';
import '/app/core/services/logger_service.dart';
import '/app/modules/home/views/pages/ez_home_page.dart';
import '/app/modules/security/data/repositories/profile_repository_impl.dart';
import '/app/modules/security/domain/models/profile_model.dart';
import '/app/modules/security/domain/models/token_model.dart';
import '/app/modules/security/views/pages/apk_callback.dart';
import '/app/modules/security/views/pages/ez_profile_configurations_page.dart';
import '/app/modules/security/views/pages/ez_profile_configurations_payment_config_page.dart';
import '/app/modules/security/views/pages/ez_profile_info_page.dart';
import '/app/modules/security/views/pages/ez_profile_page.dart';
import '/app/modules/security/views/pages/profile_page.dart';
import '/app/modules/security/views/pages/security_page.dart';
import '/app/modules/security/views/pages/user_notification_page.dart';
import '/app/modules/transaction/views/pages/electricity_service_page.dart';
import '/app/modules/transaction/views/pages/transaction_page.dart';
import '/app/routes/app_pages.dart';
import '/app/widgets/components/enzona_loguin_page.dart';
import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../controllers/security_controller.dart';
import '../data/datasources/token_datasource.dart';
import '../data/providers/token_provider.dart';
import '../data/repositories/token_repository_impl.dart';
import '../domain/repository/token_repository.dart';
import '../domain/usecases/authenticate_usecase.dart';
import '../domain/usecases/close_session_usecase.dart';
import '../views/pages/ez_profile_destinatarios_page.dart';
import '../views/pages/ez_profile_reset_payment_password.dart';
import '../views/pages/ez_secuity_profile_page.dart';
import '../views/pages/ez_security_profile_totp_page.dart';

class SecurityBinding extends Bindings {
  SecurityBinding() : super() {
    if (!Get.isRegistered<SecurityBinding>()) {
      Get.lazyPut<SecurityBinding>(
        () => this,
      );
      loadPages();
      dependencies();
    }
  }

  @override
  void dependencies() {
    Get.lazyPut<TokenRepositoryImpl<TokenModel>>(
        () => TokenRepositoryImpl<TokenModel>());
    Get.lazyPut<TokenProvider>(() => TokenProvider());
    Get.lazyPut<http.Client>(() => http.Client());
    Get.lazyPut<rest_client.Client>(() => rest_client.Client());
    Get.lazyPut<RemoteTokenDataSourceImpl>(() => RemoteTokenDataSourceImpl());
    Get.lazyPut<LocalTokenDataSourceImpl>(() => LocalTokenDataSourceImpl());
    Get.lazyPut<Repository<TokenModel>>(
      () => TokenRepositoryImpl<TokenModel>(),
    );
    Get.lazyPut<TokenRepository>(() => TokenRepositoryImpl());

    Get.lazyPut<UseCase>(
      () => AuthenticateUseCase<TokenModel>(Get.find()),
    );
    Get.lazyPut<ProfileRepositoryImpl<ProfileModel>>(
        () => ProfileRepositoryImpl<ProfileModel>());
    Get.lazyPut<AuthenticateUseCase<TokenModel>>(
        () => AuthenticateUseCase<TokenModel>(Get.find()));
    Get.lazyPut<CloseSessionUseCase>(
        () => CloseSessionUseCase(Get.find<TokenRepositoryImpl>()));

    //prueba iniciando account controller antes de todo
    //     Get.lazyPut<Repository<AccountModel>>(
    //   () => AccountRepositoryImpl<AccountModel>(),
    // );
    // Get.lazyPut<AccountProvider>(
    //   () => AccountProvider(),
    // );
    // Get.lazyPut<AccountRepository>(() => AccountRepositoryImpl());
    // Get.lazyPut<SecurityBinding>(() => SecurityBinding());
    // Get.lazyPut<AccountBinding>(() => AccountBinding());
    // Get.lazyPut<AccountController>(() => AccountController());
    // Get.lazyPut<TransactionBinding>(() => TransactionBinding());
    Get.lazyPut<SecurityController>(() => SecurityController());
  }

  static loadPages() {
    log("Inicializando páginas del módulo");
    final loginRoute = ConfigApp.getInstance.configModel!.loginRoute;
    AppPages.addAllRouteIfAbsent([
      EnzonaLoguinPageImpl.builder(
          // middlewares: [AuthMidleware()],
          ),
      EzHomeAppPageImpl.builder(
          // middlewares: [AuthMidleware()],
          ),
      EzProfileConfigPageImpl.builder(
          // middlewares: [AuthMidleware()],
          ),
      EzProfilePaymentConfigPageImpl.builder(
          // middlewares: [AuthMidleware()],
          ),
      EzProfileInfoPageImpl.builder(
          // middlewares: [AuthMidleware()],
          ),
      // EzResetPaymentPasswordPageImpl.builder(
      //     // middlewares: [AuthMidleware()],
      //     ),
      EzProfilePageImpl.builder(
          // middlewares: [AuthMidleware()],
          ),
      EzSecurityProfilePageImpl.builder(
          // middlewares: [AuthMidleware()],
          ),
      EzProfileTOTPPageImpl.builder(
          // middlewares: [AuthMidleware()],
          ),
      EzProfileDestinatarioPageImpl.builder(),

      ResetPaymentPasswordPageImpl.builder(),
      // TransactionPageImpl.builder(),
      SecurityAppPageImpl.builder(name: loginRoute),

      //SecurityAppPageImpl.builder(),
      SecurityApkCallBackPageImpl.builder(),
      UserNotificationsPageImpl.builder(),
      ProfilePageImpl.builder(),
      TransactionPageImpl.builder(),
      ElectricityService.builder(),
      GasServicePageImpl.builder()
    ]);
  }
}
