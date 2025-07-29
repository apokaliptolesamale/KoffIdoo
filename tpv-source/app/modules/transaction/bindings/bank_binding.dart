import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../security/data/providers/token_provider.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../domain/models/bank_model.dart';

import '../domain/usecases/get_bank_usecase.dart';
import '../domain/usecases/getby_bank_usecase.dart';

import '../domain/usecases/list_bank_usecase.dart';
import '../domain/usecases/filter_bank_usecase.dart';
import '../bank_exporting.dart';
import '../data/providers/bank_provider.dart';

class BankBinding extends Bindings {
  BankBinding() : super() {
    log("Registrando instancia de:${toString()} y sus dependencias.");
    dependencies();
  }

  @override
  void dependencies() {
    Get.lazyPut<BankBinding>(() => this);
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );
    Get.lazyPut<BankController>(
      () => BankController(),
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
    Get.lazyPut<BankProvider>(
      () => BankProvider(),
    );
    Get.lazyPut<RemoteBankDataSourceImpl>(
      () => RemoteBankDataSourceImpl(),
    );
    Get.lazyPut<LocalBankDataSourceImpl>(
      () => LocalBankDataSourceImpl(),
    );
    Get.lazyPut<Repository<BankModel>>(
      () => BankRepositoryImpl<BankModel>(),
    );
    Get.lazyPut<BankRepository<BankModel>>(
      () => BankRepositoryImpl<BankModel>(),
    );

    Get.lazyPut<UseCase>(
      () => GetBankUseCase<BankModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetBankByFieldUseCase<BankModel>(Get.find()),
    );

    Get.lazyPut<UseCase>(
      () => ListBankUseCase<BankModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterBankUseCase<BankModel>(Get.find()),
    );
  }
}
