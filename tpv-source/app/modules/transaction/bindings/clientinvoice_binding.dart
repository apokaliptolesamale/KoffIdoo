import '/app/modules/transaction/views/pages/onat_service_page.dart';

import '../domain/models/etecsa_invoice_model.dart';
import '../domain/usecases/get_factura_mensual_etecsa_usecase.dart';
import '../views/pages/etecsa_client_id_page.dart';
import '../views/pages/etecsa_find_client_id_page.dart';
import '../views/pages/gas_client_id_add_page.dart';
import '../views/pages/gas_client_id_page.dart';
import '../views/pages/gas_historical_page.dart';
import '../views/pages/gas_service_page.dart';
import '../views/pages/onat_rc_05_add_page.dart';
import '../views/pages/onat_rc_05_page.dart';
import '/app/modules/transaction/domain/usecases/update_clientinvoice_usecase.dart';

import '/app/modules/transaction/bindings/invoice_binding.dart';

import '/app/modules/transaction/domain/models/client_service_model.dart';

import '/app/modules/transaction/views/pages/electricity_pay_service_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '../views/pages/etecsa_service_page.dart';
import '/app/modules/transaction/data/repositories/config_service_repository_impl.dart';
import '/app/modules/transaction/domain/repository/config_service_repository.dart';
import '/app/modules/transaction/domain/usecases/get_client_id_usecase.dart';
import '/app/modules/transaction/views/pages/electricity_client_id_add_page.dart';
import '/app/modules/transaction/views/pages/electricity_client_id_page.dart';
import '/app/modules/transaction/views/pages/electricity_historical_page.dart';
import '/app/routes/app_pages.dart';
import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../../security/data/providers/token_provider.dart';
import '../clientinvoice_exporting.dart';
import '../data/providers/clientinvoice_provider.dart';
import '../domain/models/clientinvoice_model.dart';
import '../domain/usecases/add_clientinvoice_usecase.dart';
import '../domain/usecases/delete_clientinvoice_usecase.dart';
import '../domain/usecases/filter_clientinvoice_usecase.dart';
import '../domain/usecases/get_clientinvoice_usecase.dart';
import '../domain/usecases/getby_clientinvoice_usecase.dart';
import '../domain/usecases/list_clientinvoice_usecase.dart';
import '../../card/bindings/card_binding.dart';

class ClientInvoiceBinding extends Bindings {
  ClientInvoiceBinding() : super() {
    if (!Get.isRegistered<ClientInvoiceBinding>()) {
      Get.lazyPut<ClientInvoiceBinding>(
        () => this,
      );
      loadPages();
      dependencies();
    }
  }

  @override
  void dependencies() {
    InvoiceBinding().dependencies();
    CardBinding().dependencies();
    Get.lazyPut<ClientInvoiceBinding>(() => this);
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );
    Get.lazyPut<ClientInvoiceController>(
      () => ClientInvoiceController(),
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
    Get.lazyPut<ClientInvoiceProvider>(
      () => ClientInvoiceProvider(),
    );
    Get.lazyPut<RemoteClientInvoiceDataSourceImpl>(
      () => RemoteClientInvoiceDataSourceImpl(),
    );
    Get.lazyPut<LocalClientInvoiceDataSourceImpl>(
      () => LocalClientInvoiceDataSourceImpl(),
    );
    Get.lazyPut<ClientInvoiceRepository<ClientInvoiceModel>>(
      () => ClientInvoiceRepositoryImpl<ClientInvoiceModel, EtecsaModel>(),
    );
    Get.lazyPut<Repository<ClientInvoiceModel>>(
      () => ClientInvoiceRepositoryImpl<ClientInvoiceModel, EtecsaModel>(),
    );
    Get.lazyPut<ClientServiceRepository<ClientServiceModel>>(
      () => ClientServiceRepositoryImpl<ClientServiceModel>(),
    );
    Get.lazyPut<Repository<ClientServiceModel>>(
      () => ClientServiceRepositoryImpl<ClientServiceModel>(),
    );

    Get.lazyPut<UseCase>(
      () => AddClientInvoiceUseCase<ClientServiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteClientInvoiceUseCase<ClientInvoiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetClientInvoiceUseCase<ClientInvoiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetClientInvoiceByFieldUseCase<ClientInvoiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdateClientInvoiceUseCase<ClientInvoiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ListClientInvoiceUseCase<ClientInvoiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterClientInvoiceUseCase<ClientInvoiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
        () => GetClientIdUseCase<ClientInvoiceModel>(Get.find()));
    Get.lazyPut<UseCase>(
      () => GetFactMensualEtecsaUseCase(Get.find()),
    );
  }

  static loadPages() {
    AppPages.addAllRouteIfAbsent([
      ElectricityServiceAddClientIdPage.builder(),
    ]);
    AppPages.addAllRouteIfAbsent([ElectricityServiceClientIdPage.builder()]);
    AppPages.addAllRouteIfAbsent([ElectricityPayServicePage.builder()]);
    AppPages.addAllRouteIfAbsent([GasClientIdPage.builder()]);
    AppPages.addAllRouteIfAbsent([GasServicePageImpl.builder()]);
    AppPages.addAllRouteIfAbsent([GasClientIdAddPage.builder()]);
    AppPages.addAllRouteIfAbsent([GasHistoricalPage.builder()]);
    AppPages.addAllRouteIfAbsent([OnatRc05Page.builder()]);
    AppPages.addAllRouteIfAbsent([OnatRc05AddPage.builder()]);
    AppPages.addAllRouteIfAbsent([
      ElectricityHistoricalPage.builder(),
      EtecsaService.builder(),
      EtecsaServiceClientIdPage.builder(),
      EtecsaFindClientIdPage.builder(),
      OnatServicePageImpl.builder()
    ]);
  }
}
