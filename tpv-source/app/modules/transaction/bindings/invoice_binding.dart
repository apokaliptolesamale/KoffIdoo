import 'dart:developer';
import '/app/modules/transaction/domain/models/invoice_by_client_model.dart';
import '/app/modules/transaction/domain/usecases/get_invoice_by_client_id_usecase.dart';

import '../domain/usecases/pay_service_usecase.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../../security/data/providers/token_provider.dart';
import '../data/providers/invoice_provider.dart';
import '../domain/models/invoice_model.dart';
import '../domain/usecases/add_invoice_usecase.dart';
import '../domain/usecases/delete_invoice_usecase.dart';
import '../domain/usecases/filter_invoice_usecase.dart';
import '../domain/usecases/get_invoice_at_month_usecase.dart';
import '../domain/usecases/getby_invoice_usecase.dart';
import '../domain/usecases/list_invoice_usecase.dart';
import '../domain/usecases/update_invoice_usecase.dart';
import '../invoice_exporting.dart';

class InvoiceBinding extends Bindings {
  InvoiceBinding() : super() {
    log("Registrando instancia de:${toString()} y sus dependencias.");
    dependencies();
    // loadPages();
  }

  @override
  void dependencies() 
  {
    
    Get.lazyPut<InvoiceBinding>(() => this);
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );
    Get.lazyPut<InvoiceController>(
      () => InvoiceController(),
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
    Get.lazyPut<InvoiceProvider>(
      () => InvoiceProvider(),
    );
    Get.lazyPut<RemoteInvoiceDataSourceImpl>(
      () => RemoteInvoiceDataSourceImpl(),
    );
    Get.lazyPut<LocalInvoiceDataSourceImpl>(
      () => LocalInvoiceDataSourceImpl(),
    );
    Get.lazyPut<Repository<InvoiceModel>>(
      () => InvoiceRepositoryImpl<InvoiceModel>(),
    );
    Get.lazyPut<InvoiceRepository<InvoiceModel>>(
      () => InvoiceRepositoryImpl<InvoiceModel>(),
    );
    Get.lazyPut<UseCase>(
      () => AddInvoiceUseCase<InvoiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteInvoiceUseCase<InvoiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetMonthlyInvoiceUseCase<InvoiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetInvoiceByFieldUseCase<InvoiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdateInvoiceUseCase<InvoiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ListInvoiceUseCase<InvoiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterInvoiceUseCase<InvoiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => PayServiceUseCase<InvoiceModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetInvoiceByClientIdUseCase<InvoiceByClientModel>(Get.find()),
    );
    

  }

  static loadPages() {
    // AppPages.addAllRouteIfAbsent([ElectricityServiceAddClientIdPage.builder(),]);
    // AppPages.addAllRouteIfAbsent([ElectricityHistoricalPage.builder(),]);
  }
}
