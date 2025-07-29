import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '/app/modules/warranty/views/pages/create_account_page.dart';
import '/app/modules/warranty/views/pages/qr_info_warranty_page.dart';
import '/app/modules/warranty/views/pages/start_page.dart';
import '/app/modules/warranty/views/pages/warranty_info_page.dart';
import '/app/modules/warranty/views/pages/warranty_login_page.dart';
import '/app/modules/warranty/views/pages/warranty_notification_page.dart';
import '/app/modules/warranty/views/warranty_add_view.dart';
import '/app/routes/app_pages.dart';
import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../../security/data/providers/token_provider.dart';
import '../data/providers/status_provider.dart';
import '../domain/models/status_model.dart';
import '../domain/usecases/add_status_usecase.dart';
import '../domain/usecases/delete_status_usecase.dart';
import '../domain/usecases/filter_status_usecase.dart';
import '../domain/usecases/get_status_usecase.dart';
import '../domain/usecases/getby_status_usecase.dart';
import '../domain/usecases/list_status_usecase.dart';
import '../domain/usecases/update_status_usecase.dart';
import '../status_exporting.dart';

class StatusBinding extends Bindings {
  StatusBinding() : super() {
    log("Registrando instancia de:${toString()} y sus dependencias.");
    dependencies();
  }

  @override
  void dependencies() {
    Get.lazyPut<StatusBinding>(() => this);
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );
    Get.lazyPut<StatusController>(
      () => StatusController(),
    );
    Get.lazyPut<home_app.HomeController>(
      () => home_app.HomeController(),
    );
    Get.lazyPut<http.Client>(
      () => http.Client(),
    );
    Get.lazyPut<rest_client.Client>(
      () => rest_client.Client(),
    );
    Get.lazyPut<StatusProvider>(
      () => StatusProvider(),
    );
    Get.lazyPut<RemoteStatusDataSourceImpl>(
      () => RemoteStatusDataSourceImpl(),
    );
    Get.lazyPut<LocalStatusDataSourceImpl>(
      () => LocalStatusDataSourceImpl(),
    );
    Get.lazyPut<Repository<StatusModel>>(
      () => StatusRepositoryImpl<StatusModel>(),
    );
    Get.lazyPut<StatusRepository<StatusModel>>(
      () => StatusRepositoryImpl<StatusModel>(),
    );
    Get.lazyPut<UseCase>(
      () => AddStatusUseCase<StatusModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteStatusUseCase<StatusModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetStatusUseCase<StatusModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetStatusByFieldUseCase<StatusModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdateStatusUseCase<StatusModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ListStatusUseCase<StatusModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterStatusUseCase<StatusModel>(Get.find()),
    );
  }

  static loadPages() {
    AppPages.addAllRouteIfAbsent([
      WarrantyCreateAccountPageImpl.builder(),
      WarrantyNotificationPageImpl.builder(),
      WarrantyLoginAppPageImpl.builder(),
      WarrantyInfoPageImpl.builder(),
      WarrantyAppHomePageImpl.builder(),
      WarrantyQrInfoPageImpl.builder(),
      WarrantyAddPageImpl.builder()
    ]);
  }
}
