import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;
import '/app/core/middlewares/auth_middleware.dart';
import '/app/modules/tpv/views/pages/tpv_login.dart';
import '/app/modules/tpv/views/pages/tpv_main_page.dart';
import '/app/routes/app_pages.dart';
import '../../../core/interfaces/repository.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../../security/data/providers/token_provider.dart';
import '../data/providers/tpv_provider.dart';
import '../domain/models/tpv_model.dart';
import '../tpv_exporting.dart';
import '../views/pages/first_time_config_page.dart';
import '../views/pages/tpv_home_page.dart';
import '../views/pages/tpv_sales_history_page.dart';
import '../views/pages/tpv_invoice_page.dart';
import '../views/pages/tpv_all_products_page.dart';
import '../views/pages/tpv_opening_page.dart';

class TpvBinding extends Bindings {
  TpvBinding() : super() {
    if (!Get.isRegistered<TpvBinding>()) {
      Get.lazyPut<TpvBinding>(
        () => this,
      );
      init();
    }
  }
  @override
  void dependencies() {
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );
    Get.lazyPut<TpvController>(
      () => TpvController(),
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
    Get.lazyPut<TpvProvider>(
      () => TpvProvider(),
    );
    Get.lazyPut<RemoteTpvDataSourceImpl>(
      () => RemoteTpvDataSourceImpl(),
    );
    Get.lazyPut<LocalTpvDataSourceImpl>(
      () => LocalTpvDataSourceImpl(),
    );
    Get.lazyPut<Repository<TpvModel>>(
      () => TpvRepositoryImpl<TpvModel>(),
    );
    Get.lazyPut<TpvRepository<TpvModel>>(
      () => TpvRepositoryImpl<TpvModel>(),
    );
  }

  TpvBinding init() {
    loadPages();
    dependencies();
    return this;
  }

  loadPages() {
    AppPages.addAllRouteIfAbsent([
      TpvMainPageImpl.builder(
        middlewares: [AuthMidleware()],
      ),
      TpvLoginPageImpl.builder(),
      TpvMainPageImpl.builder(),
      FirstTimeConfigPageImpl.builder(),
      TpvOpeningPageImpl.builder(),
      TpvHomePageImpl.builder(),
      TpvMainPageImpl.builder(),
      TpvSalesHistoryPageImpl.builder(),
      FirstTimeConfigPageImpl.builder(),
      TpvInvoicePageImpl.builder(),
      TpvAllProductsPageImpl.builder(),
    ]);
  }
}
