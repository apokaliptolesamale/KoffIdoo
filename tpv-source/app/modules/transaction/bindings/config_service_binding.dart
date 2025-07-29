import 'dart:developer';

import '/app/modules/transaction/domain/usecases/add_clientinvoice_usecase.dart';

import '/app/modules/transaction/domain/models/client_service_model.dart';

import '/app/modules/transaction/controllers/invoice_controller.dart';
import '/app/modules/transaction/domain/models/invoice_model.dart';
import '/app/modules/transaction/controllers/config_service_controller.dart';
import '/app/modules/transaction/data/datasources/config_service_datasource.dart';
import '/app/modules/transaction/data/providers/config_service_provider.dart';
import '/app/modules/transaction/data/repositories/config_service_repository_impl.dart';
import '/app/modules/transaction/domain/repository/config_service_repository.dart';
import '/app/modules/transaction/domain/usecases/list_client_id_usecase.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;
import '/app/modules/transaction/views/pages/transaction_page.dart';
import '/app/routes/app_pages.dart';
import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../security/data/providers/token_provider.dart';
import '/app/modules/transaction/domain/usecases/get_client_id_usecase.dart';

class ClientServiceBinding extends Bindings {
  ClientServiceBinding() : super() {
    log("Registrando instancia de:${toString()} y sus dependencias.");
    if (!Get.isRegistered<ClientServiceBinding>()) {
      Get.lazyPut<ClientServiceBinding>(
        () => this,
      );
      // loadPages();
      dependencies();
    }
  }

  @override
  void dependencies() {
    Get.lazyPut<ClientServiceBinding>(() => this);
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );
    Get.lazyPut<ClientServiceController>(
      () => ClientServiceController(),
    );
    Get.lazyPut<InvoiceController>(
      () => InvoiceController(),
    );
    /*Get.lazyPut<home_app.HomeController>(
      () => home_app.HomeController(),
    );*/
    Get.lazyPut<http.Client>(
      () => http.Client(),
    );
    Get.lazyPut<rest_client.Client>(
      () => rest_client.Client(),
    );
    Get.lazyPut<ClientServiceProvider>(
      () => ClientServiceProvider(),
    );
    Get.lazyPut<RemoteClientIdDataSourceImpl>(
      () => RemoteClientIdDataSourceImpl(),
    );
    /* Get.lazyPut<LocalTransactionDataSourceImpl>(
      () => LocalTransactionDataSourceImpl(),
    );*/
    Get.lazyPut<Repository<ClientServiceModel>>(
      () => ClientServiceRepositoryImpl<ClientServiceModel>(),
    );
    Get.lazyPut<ClientServiceRepository<ClientServiceModel>>(
      () => ClientServiceRepositoryImpl<ClientServiceModel>(),
    );
    /* Get.lazyPut<UseCase>(
      () => AddTransactionUseCase<ClientServiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteTransactionUseCase<ClientServiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetTransactionUseCase<ClientServiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetTransactionByFieldUseCase<ClientServiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdateTransactionUseCase<ClientServiceModel>(Get.find()),
    );*/
    Get.lazyPut<UseCase>(
      () => ListClientIdUseCase<ClientServiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetClientIdUseCase<InvoiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => AddClientInvoiceUseCase<ClientServiceModel>(Get.find()),
    );
  }

  static loadPages() {
    AppPages.addAllRouteIfAbsent([
      TransactionPageImpl.builder(),
    ]);
  }
}
