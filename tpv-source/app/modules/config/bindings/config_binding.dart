import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '/app/modules/config/domain/models/nomenclador_model.dart';
import '/app/routes/app_pages.dart';
import '../../../core/interfaces/use_case.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../../security/data/providers/token_provider.dart';
import '../config_exporting.dart';
import '../data/datasources/nomenclador_datasource.dart';
import '../data/providers/config_provider.dart';
import '../data/providers/nomenclador_provider.dart';
import '../data/repositories/nomenclador_repository_impl.dart';
import '../domain/repository/nomenclador_repository.dart';
import '../domain/usecases/add_config_usecase.dart';
import '../domain/usecases/delete_config_usecase.dart';
import '../domain/usecases/get_config_usecase.dart';
import '../domain/usecases/getby_config_usecase.dart';
import '../domain/usecases/list_config_usecase.dart';
import '../domain/usecases/list_nomenclador_usecase.dart';
import '../domain/usecases/update_config_usecase.dart';

class ConfigBinding extends Bindings {
  ConfigBinding() : super() {
    if (!Get.isRegistered<ConfigBinding>()) {
      Get.lazyReplace<ConfigBinding>(
        () => ConfigBinding(),
      );
      //loadPages();
      dependencies();
    }
  }

  @override
  void dependencies() {
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );
    Get.lazyPut<ConfigController>(
      () => ConfigController(),
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
    Get.lazyPut<ConfigProvider>(
      () => ConfigProvider(),
    );
    Get.lazyPut<RemoteConfigDataSourceImpl>(
      () => RemoteConfigDataSourceImpl(),
    );
    Get.lazyPut<LocalConfigDataSourceImpl>(
      () => LocalConfigDataSourceImpl(),
    );
    Get.lazyPut<ConfigRepository<Object?>>(
      () => ConfigRepositoryImpl<Object?>(),
    );

    Get.lazyPut<UseCase>(
      () => AddConfig(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteConfig(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetConfig(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetByFieldConfig(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdateConfig(Get.find()),
    );

    Get.lazyPut<UseCase>(
      () => ListConfig(Get.find()),
    );

    //Nomenclador
    Get.lazyPut<NomencladorProvider>(
      () => NomencladorProvider(),
    );
    Get.lazyPut<RemoteNomencladorDataSourceImpl>(
      () => RemoteNomencladorDataSourceImpl(),
    );
    Get.lazyPut<LocalNomencladorDataSourceImpl>(
      () => LocalNomencladorDataSourceImpl(),
    );
    Get.lazyPut<NomencladorRepository<NomencladorModel>>(
      () => NomencladorRepositoryImpl<NomencladorModel>(),
    );
    Get.lazyPut<NomencladorRepository<NomencladorList<NomencladorModel>>>(
      () => NomencladorRepositoryImpl<NomencladorList<NomencladorModel>>(),
    );

    Get.lazyPut<UseCase>(
      () => ListNomencladorUseCase<NomencladorModel>(Get.find()),
    );
  }

  static loadPages() {
    AppPages.addAllRouteIfAbsent([
      // Adiciona aquí todas las páginas relacionadas con el binding actual.
    ]);
  }
}
