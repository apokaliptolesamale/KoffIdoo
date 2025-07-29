import '/app/modules/security/controllers/security_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '/app/core/services/logger_service.dart';
import '/app/modules/security/controllers/account_controller.dart';
import '/app/modules/security/data/providers/account_provider.dart';
import '/app/modules/security/domain/models/account_model.dart';
import '/app/modules/security/domain/repository/account_repository.dart';
import '../../../../app/modules/security/bindings/security_binding.dart';
import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../../routes/app_pages.dart';
import '../../security/bindings/account_binding.dart';
import '../../security/data/datasources/account_datasource.dart';
import '../../security/data/repositories/account_repository_impl.dart';
import '../../security/domain/usecases/get_account_usecase.dart';
import '../controllers/ez_home_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  HomeBinding() : super() {
    if (!Get.isRegistered<HomeBinding>()) {
      Get.lazyPut<HomeBinding>(
        () => this,
      );
      loadPages();
      dependencies();
    }
  }
  @override
  void dependencies() {
    Get.lazyPut<AccountProvider>(
      () => AccountProvider(),
    );
    Get.lazyPut<RemoteAccountDataSourceImpl>(
      () => RemoteAccountDataSourceImpl(),
    );
    Get.lazyPut<FlutterSecureStorage>(
      () => FlutterSecureStorage(),
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
      () => GetAccountUseCase<AccountModel>(Get.find()),
    );

    Get.lazyPut<AccountRepository>(
        () => AccountRepositoryImpl(FlutterSecureStorage()));
    Get.lazyPut<SecurityBinding>(() => SecurityBinding());

    Get.lazyPut<AccountBinding>(() => AccountBinding());

    Get.lazyPut<AccountController>(
        () => AccountController(FlutterSecureStorage()));
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<EzHomeController>(() => EzHomeController());
    Get.lazyPut<SecurityBinding>(() => SecurityBinding());
    Get.lazyPut<SecurityController>(() => SecurityController());
  }

  static loadPages() {
    log("Inicializando páginas del módulo HomeBinding");
    AppPages.addAllRouteIfAbsent([
      // EzHomeAppPage.builder(),
      // EzHomeAppPage.builder(),
      // EzHomeAppPage.builder(),
      // SecurityAppPageImpl.builder(),
      // SecurityApkCallBackPageImpl.builder(),
      // UserNotificationsPageImpl.builder(),
      // ProfilePageImpl.builder(),
    ]);
  }
}
