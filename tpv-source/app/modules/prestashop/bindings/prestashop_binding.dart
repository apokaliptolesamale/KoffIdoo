import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../../security/data/providers/token_provider.dart';
import '../data/providers/prestashop_provider.dart';
import '../domain/models/prestashop_model.dart';
import '../domain/usecases/add_prestashop_usecase.dart';
import '../domain/usecases/delete_prestashop_usecase.dart';
import '../domain/usecases/filter_prestashop_usecase.dart';
import '../domain/usecases/get_prestashop_usecase.dart';
import '../domain/usecases/getby_prestashop_usecase.dart';
import '../domain/usecases/list_prestashop_usecase.dart';
import '../domain/usecases/update_prestashop_usecase.dart';
import '../prestashop_exporting.dart';

class PrestaShopBinding extends Bindings {
  PrestaShopBinding() : super() {
    if (!Get.isRegistered<PrestaShopBinding>()) {
      Get.lazyPut<PrestaShopBinding>(
        () => this,
      );
    }
    dependencies();
  }

  @override
  void dependencies() {
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );
    Get.lazyPut<PrestaShopController>(
      () => PrestaShopController(),
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
    Get.lazyPut<PrestaShopProvider>(
      () => PrestaShopProvider(),
    );
    Get.lazyPut<RemotePrestaShopDataSourceImpl>(
      () => RemotePrestaShopDataSourceImpl(),
    );
    Get.lazyPut<LocalPrestaShopDataSourceImpl>(
      () => LocalPrestaShopDataSourceImpl(),
    );
    Get.lazyPut<Repository<PrestaShopModel>>(
      () => PrestaShopRepositoryImpl<PrestaShopModel>(),
    );
    Get.lazyPut<PrestaShopRepository<PrestaShopModel>>(
      () => PrestaShopRepositoryImpl<PrestaShopModel>(),
    );
    Get.lazyPut<UseCase>(
      () => AddPrestaShopUseCase<PrestaShopModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeletePrestaShopUseCase<PrestaShopModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetPrestaShopUseCase<PrestaShopModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetPrestaShopByFieldUseCase<PrestaShopModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdatePrestaShopUseCase<PrestaShopModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ListPrestaShopUseCase<PrestaShopModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterPrestaShopUseCase<PrestaShopModel>(Get.find()),
    );
  }
}
