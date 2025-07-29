import 'dart:developer';

import 'package:get/get.dart';

import '/app/modules/card/data/providers/balance_provider.dart';
import '/app/modules/card/domain/usecases/get_balance_use_case.dart';
import '/app/modules/card/domain/usecases/get_cordenate_use_case.dart';
import '/app/modules/card/domain/usecases/get_operation_use_case.dart';
import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../../core/middlewares/auth_middleware.dart';
import '../../../routes/app_pages.dart';
import '../../security/data/providers/token_provider.dart';
import '../../transaction/controllers/bank_controller.dart';
import '../../transaction/data/datasources/bank_datasource.dart';
import '../../transaction/data/providers/bank_provider.dart';
import '../../transaction/data/repositories/bank_repository_impl.dart';
import '../../transaction/domain/models/bank_model.dart';
import '../../transaction/domain/repository/bank_repository.dart';
import '../../transaction/domain/usecases/list_bank_usecase.dart';
import '../card_exporting.dart';
import '../data/providers/card_provider.dart';
import '../data/providers/cordenate_provider.dart';
import '../data/providers/operation_provider.dart';
import '../data/repositories/balance_repository_impl.dart';
import '../data/repositories/cordenate_repository_impl.dart';
import '../data/repositories/operation_repository_impl.dart';
import '../domain/models/balance_model.dart';
import '../domain/models/card_model.dart';
import '../domain/models/cordenate_model.dart';
import '../domain/models/operation_model.dart';
import '../domain/repository/balance_repository.dart';
import '../domain/repository/cordenate_repository.dart';
import '../domain/repository/operation_repository.dart';
import '../domain/usecases/add_card_usecase.dart';
import '../domain/usecases/delete_card_usecase.dart';
import '../domain/usecases/filter_card_usecase.dart';
import '../domain/usecases/get_card_usecase.dart';
import '../domain/usecases/getby_card_usecase.dart';
import '../domain/usecases/list_card_usecase.dart';
import '../views/pages/card_page.dart';

class CardBinding extends Bindings {
  CardBinding() : super() {
    if (!Get.isRegistered<CardBinding>()) {
      Get.lazyPut<CardBinding>(
        () => this,
      );
      loadPages();
      dependencies();
    }
  }

  @override
  void dependencies() {
    Get.lazyPut<CardBinding>(() => this);
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );
    Get.lazyPut<CardController>(
      () => CardController(),
    );
    //Banco//////////
    Get.lazyPut<BankController>(
      () => BankController(),
    );
    Get.lazyPut<Repository<BankModel>>(
      () => BankRepositoryImpl<BankModel>(),
    );
    Get.lazyPut<BankRepository<BankModel>>(
      () => BankRepositoryImpl<BankModel>(),
    );
    Get.lazyPut<BankProvider>(
      () => BankProvider(),
    );
    Get.lazyPut<BalanceProvider>(
      () => BalanceProvider(),
    );
    Get.lazyPut<RemoteBankDataSourceImpl>(
      () => RemoteBankDataSourceImpl(),
    );
    Get.lazyPut<UseCase>(
      () => ListBankUseCase<BankModel>(Get.find()),
    );
    /////////////////Termina aqui Banco////////////////
    /*  Get.lazyPut<home_app.HomeController>(
      () => home_app.HomeController(),
    );
    Get.lazyPut<http.Client>(
      () => http.Client(),
    );
    Get.lazyPut<rest_client.Client>(
      () => rest_client.Client(),
    ); */
    Get.lazyPut<CardProvider>(
      () => CardProvider(),
    );
    Get.lazyPut<CordenateProvider>(
      () => CordenateProvider(),
    );
    Get.lazyPut<OperationProvider>(
      () => OperationProvider(),
    );
    Get.lazyPut<RemoteCardDataSourceImpl>(
      () => RemoteCardDataSourceImpl(),
    );
    Get.lazyPut<LocalCardDataSourceImpl>(
      () => LocalCardDataSourceImpl(),
    );
    Get.lazyPut<Repository<CardModel>>(
      () => CardRepositoryImpl<CardModel>(),
    );
    Get.lazyPut<CardRepository<CardModel>>(
      () => CardRepositoryImpl<CardModel>(),
    );
    Get.lazyPut<UseCase>(
      () => AddCardUseCase<CardModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteCardUseCase<CardModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetCardUseCase<CardModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetCardByFieldUseCase<CardModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ListCardUseCase<CardModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterCardUseCase<CardModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetCordenateUseCase(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetBalanceUseCase(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetOperationUseCase(Get.find()),
    );
    Get.lazyPut<CordenateRepository<CordenateModel>>(
      () => CordenateRepositoryImpl(),
    );
    Get.lazyPut<BalanceRepository<BalanceModel>>(
      () => BalanceRepositoryImpl(),
    );
    Get.lazyPut<OperationRepository<OperationModel>>(
      () => OperationRepositoryImpl(),
    );
  }

  static loadPages() {
    log("Inicializando páginas del módulo Card");
    //final loginRoute = ConfigApp.getInstance.configModel!.loginRoute;
    AppPages.addAllRouteIfAbsent([
      CardAppPageImpl.builder(middlewares: [AuthMidleware()])
    ]);
  }
}
