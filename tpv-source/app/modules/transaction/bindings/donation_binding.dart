import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '/app/modules/transaction/views/donationViews/donationPages/donation_page.dart';
import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../../routes/app_pages.dart';
import '../../card/bindings/card_binding.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../../security/data/providers/token_provider.dart';
import '../data/providers/donation_provider.dart';
import '../domain/models/donation_model.dart';
import '../domain/usecases/add_donation_usecase.dart';
import '../domain/usecases/delete_donation_usecase.dart';
import '../domain/usecases/filter_donation_usecase.dart';
import '../domain/usecases/get_donation_usecase.dart';
import '../domain/usecases/getby_donation_usecase.dart';
import '../domain/usecases/list_donation_usecase.dart';
import '../donation_exporting.dart';
import '../views/donationViews/donationPages/donar_page.dart';

class DonationBinding extends Bindings {
  DonationBinding() : super() {
    if (!Get.isRegistered<DonationBinding>()) {
      Get.lazyPut<DonationBinding>(
        () => this,
      );
      loadPages();
      dependencies();
    }
  }

  @override
  void dependencies() {
    CardBinding().dependencies();
    Get.lazyPut<DonationBinding>(() => this);
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );
    Get.lazyPut<DonationController>(
      () => DonationController(),
    );
    /* Get.lazyPut(
      () => CardBinding().dependencies(),
    ); */
    /* Get.lazyPut<CardController>(
      () => CardController(),
    ); */
    Get.lazyPut<home_app.HomeController>(
      () => home_app.HomeController(),
    );
    Get.lazyPut<http.Client>(
      () => http.Client(),
    );
    Get.lazyPut<rest_client.Client>(
      () => rest_client.Client(),
    );
    Get.lazyPut<DonationProvider>(
      () => DonationProvider(),
    );
    Get.lazyPut<RemoteDonationDataSourceImpl>(
      () => RemoteDonationDataSourceImpl(),
    );
    Get.lazyPut<LocalDonationDataSourceImpl>(
      () => LocalDonationDataSourceImpl(),
    );
    Get.lazyPut<Repository<DonationModel>>(
      () => DonationRepositoryImpl<DonationModel>(),
    );
    Get.lazyPut<DonationRepository<DonationModel>>(
      () => DonationRepositoryImpl<DonationModel>(),
    );
    Get.lazyPut<UseCase>(
      () => AddDonationUseCase<DonationModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteDonationUseCase<DonationModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetDonationUseCase<DonationModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetDonationByFieldUseCase<DonationModel>(Get.find()),
    );

    Get.lazyPut<UseCase>(
      () => ListDonationUseCase<DonationModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterDonationUseCase<DonationModel>(Get.find()),
    );
  }

  static loadPages() {
    AppPages.addAllRouteIfAbsent([
      DonationPageImpl.builder(),
      DonarPageImpl.builder(),
    ]);
  }
}
