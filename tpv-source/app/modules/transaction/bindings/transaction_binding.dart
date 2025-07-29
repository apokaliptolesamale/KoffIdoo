import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '/app/modules/transaction/views/pages/transaction_page.dart';
import '/app/routes/app_pages.dart';
import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../security/data/providers/token_provider.dart';
import '../data/providers/transaction_provider.dart';
import '../domain/models/transaction_model.dart';
import '../domain/usecases/filter_transaction_usecase.dart';
import '../domain/usecases/list_transaction_usecase.dart';
import '../transaction_exporting.dart';

class TransactionBinding extends Bindings {
  TransactionBinding() : super() {
    log("Registrando instancia de:${toString()} y sus dependencias.");
    if (!Get.isRegistered<TransactionBinding>()) {
      Get.lazyPut<TransactionBinding>(
        () => this,
      );
      loadPages();
      dependencies();
    }
  }

  @override
  void dependencies() {
    Get.lazyPut<TransactionBinding>(() => this);
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );
    Get.lazyPut<TransactionController>(
      () => TransactionController(),
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
    Get.lazyPut<TransactionProvider>(
      () => TransactionProvider(),
    );
    Get.lazyPut<RemoteTransactionDataSourceImpl>(
      () => RemoteTransactionDataSourceImpl(),
    );
    Get.lazyPut<LocalTransactionDataSourceImpl>(
      () => LocalTransactionDataSourceImpl(),
    );
    Get.lazyPut<Repository<TransactionModel>>(
      () => TransactionRepositoryImpl<TransactionModel>(),
    );
    Get.lazyPut<TransactionRepository<TransactionModel>>(
      () => TransactionRepositoryImpl<TransactionModel>(),
    );
    /* Get.lazyPut<UseCase>(
      () => AddTransactionUseCase<TransactionModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteTransactionUseCase<TransactionModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetTransactionUseCase<TransactionModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetTransactionByFieldUseCase<TransactionModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdateTransactionUseCase<TransactionModel>(Get.find()),
    );*/
    Get.lazyPut<UseCase>(
      () => ListTransactionUseCase<TransactionModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterTransactionUseCase<TransactionModel>(Get.find()),
    );
  }

  static loadPages() {
    AppPages.addAllRouteIfAbsent([
      TransactionPageImpl.builder(),
    ]);
  }
}
