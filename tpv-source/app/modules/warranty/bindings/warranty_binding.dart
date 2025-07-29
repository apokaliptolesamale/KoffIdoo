import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '/app/core/interfaces/repository.dart';
import '/app/core/middlewares/auth_middleware.dart';
import '/app/modules/warranty/views/pages/create_account_page.dart';
import '/app/modules/warranty/views/pages/qr_info_warranty_page.dart';
import '/app/modules/warranty/views/pages/start_page.dart';
import '/app/modules/warranty/views/pages/warranty_index_page.dart';
import '/app/modules/warranty/views/pages/warranty_info_page.dart';
import '/app/modules/warranty/views/pages/warranty_login_page.dart';
import '/app/modules/warranty/views/pages/warranty_notification_page.dart';
import '/app/modules/warranty/views/warranty_add_view.dart';
import '/app/routes/app_pages.dart';
import '../../../core/interfaces/use_case.dart';
import '../../../modules/warranty/domain/models/warranty_model.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../../security/data/providers/token_provider.dart';
import '../data/providers/warranty_provider.dart';
import '../domain/usecases/add_warranty_usecase.dart';
import '../domain/usecases/delete_warranty_usecase.dart';
import '../domain/usecases/filter_warranty_usecase.dart';
import '../domain/usecases/get_warranty_usecase.dart';
import '../domain/usecases/getby_warranty_usecase.dart';
import '../domain/usecases/list_warranty_usecase.dart';
import '../domain/usecases/update_warranty_usecase.dart';
import '../warranty_exporting.dart';

class WarrantyBinding extends Bindings {
  WarrantyBinding() : super() {
    if (!Get.isRegistered<WarrantyBinding>()) {
      Get.lazyPut<WarrantyBinding>(
        () => this,
      );
      loadPages();
      dependencies();
    }
  }

  @override
  void dependencies() {
    Get.lazyPut<Map<dynamic, dynamic>>(
      () => {},
    );
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );
    Get.lazyPut<WarrantyController>(
      () => WarrantyController(),
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
    Get.lazyPut<WarrantyProvider>(
      () => WarrantyProvider(),
    );
    Get.lazyPut<RemoteWarrantyDataSourceImpl>(
      () => RemoteWarrantyDataSourceImpl(),
    );
    Get.lazyPut<LocalWarrantyDataSourceImpl>(
      () => LocalWarrantyDataSourceImpl(),
    );
    Get.lazyPut<Repository<WarrantyModel>>(
      () => WarrantyRepositoryImpl<WarrantyModel>(),
    );
    Get.lazyPut<WarrantyRepository<WarrantyModel>>(
      () => WarrantyRepositoryImpl<WarrantyModel>(),
    );
    Get.lazyPut<UseCase>(
      () => AddWarrantyUseCase<WarrantyModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteWarrantyUseCase<WarrantyModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetWarrantyUseCase<WarrantyModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetWarrantyByFieldUseCase<WarrantyModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdateWarrantyUseCase<WarrantyModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ListWarrantyUseCase<WarrantyModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterWarrantyUseCase<WarrantyModel>(Get.find()),
    );
  }

  static loadPages() {
    final middlewares = [AuthMidleware()];

    AppPages.addAllRouteIfAbsent([
      WarrantyCreateAccountPageImpl.builder(),
      WarrantyNotificationPageImpl.builder(
        middlewares: middlewares,
      ),
      WarrantyLoginAppPageImpl.builder(),
      WarrantyIndexAppPageImpl.builder(
        middlewares: middlewares,
      ),
      WarrantyInfoPageImpl.builder(
        middlewares: middlewares,
      ),
      WarrantyAppHomePageImpl.builder(
        middlewares: middlewares,
      ),
      WarrantyQrInfoPageImpl.builder(
        middlewares: middlewares,
      ),
      WarrantyAddPageImpl.builder(
        middlewares: middlewares,
      )
    ]);
  }
}
