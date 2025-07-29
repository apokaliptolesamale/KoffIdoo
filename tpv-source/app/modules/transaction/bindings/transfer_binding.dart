import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '/app/modules/home/bindings/home_binding.dart';
import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../../routes/app_pages.dart';
import '../../card/bindings/card_binding.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../../qrcode/bindings/qrcode_binding.dart';
import '../../security/data/providers/account_provider.dart';
import '../../security/data/providers/token_provider.dart';
import '../data/providers/transfer_provider.dart';
import '../domain/models/transfer_model.dart';
import '../domain/usecases/add_transfer_usecase.dart';
import '../domain/usecases/delete_transfer_usecase.dart';
import '../domain/usecases/filter_transfer_usecase.dart';
import '../domain/usecases/get_transfer_usecase.dart';
import '../domain/usecases/getby_transfer_usecase.dart';
import '../domain/usecases/list_transfer_usecase.dart';
import '../domain/usecases/transfer_to_account_usecase.dart';
import '../domain/usecases/transfer_to_card_usecase.dart';
import '../domain/usecases/update_transfer_usecase.dart';
import '../transfer_exporting.dart';
import '../views/pages/find_account_page.dart';
import '../views/pages/transfer_account_page.dart';
import '../views/pages/transfer_card_page.dart';
import '../views/pages/transfer_my_cards_page.dart';

class TransferBinding extends Bindings {
  TransferBinding() : super() {
    if (!Get.isRegistered<TransferBinding>()) {
      log("Registrando instancia de:${toString()} y sus dependencias.");
      Get.lazyPut<TransferBinding>(
        () => this,
      );
      loadPages();
      dependencies();
    }
  }

  @override
  void dependencies() {
    CardBinding().dependencies();
    QrCodeBinding().dependencies();
    Get.lazyPut<HomeBinding>(
      () => HomeBinding(),
    );
    // final card = CardBinding();
    // Get.lazyPut<CardBinding>(() => card);
    Get.lazyPut<TransferBinding>(() => this);
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );
    Get.lazyPut<AccountProvider>(
      () => AccountProvider(),
    );
    Get.lazyPut<TransferController>(
      () => TransferController(),
    );
    // Get.lazyPut<CardController>(
    //   () => CardController(),
    // );

    Get.lazyPut<home_app.HomeController>(
      () => home_app.HomeController(),
    );
    Get.lazyPut<http.Client>(
      () => http.Client(),
    );
    Get.lazyPut<rest_client.Client>(
      () => rest_client.Client(),
    );
    // Get.lazyPut<Repository<CardModel>>(
    //   () => CardRepositoryImpl<CardModel>(),
    // );
    // Get.lazyPut<CardRepository<CardModel>>(
    //   () => CardRepositoryImpl<CardModel>(),
    // );
    // Get.lazyPut<Repository<CordenateModel>>(
    //   () => CordenateRepositoryImpl<CordenateModel>(),
    // );
    // Get.lazyPut<CordenateRepository<CordenateModel>>(
    //   () => CordenateRepositoryImpl<CordenateModel>(),
    // );
    // Get.lazyPut<BalanceRepository<BalanceModel>>(
    //   () => BalanceRepositoryImpl(),
    // );
    Get.lazyPut<TransferProvider>(
      () => TransferProvider(),
    );
    Get.lazyPut<RemoteTransferDataSourceImpl>(
      () => RemoteTransferDataSourceImpl(),
    );
    Get.lazyPut<LocalTransferDataSourceImpl>(
      () => LocalTransferDataSourceImpl(),
    );
    Get.lazyPut<Repository<TransferModel>>(
      () => TransferRepositoryImpl<TransferModel>(),
    );
    Get.lazyPut<TransferRepository<TransferModel>>(
      () => TransferRepositoryImpl<TransferModel>(),
    );
    Get.lazyPut<UseCase>(
      () => AddTransferUseCase<TransferModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteTransferUseCase<TransferModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetTransferUseCase<TransferModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetTransferByFieldUseCase<TransferModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdateTransferUseCase<TransferModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ListTransferUseCase<TransferModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterTransferUseCase<TransferModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetTransferToAccountUseCase<TransferModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetTransferToCardUseCase<TransferModel>(Get.find()),
    );
  }

  static loadPages() {
    AppPages.addAllRouteIfAbsent([
      FindAccountPageImpl.builder(),
      TransferCardPageImpl.builder(),
      TransferAccountPageImpl.builder(),
      TransferMyCardPageImpl.builder()
    ]);
  }
}
