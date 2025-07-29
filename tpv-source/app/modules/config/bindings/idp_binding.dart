import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../../security/data/providers/token_provider.dart';
import '../data/providers/idp_provider.dart';
import '../domain/models/idp_model.dart';
import '../domain/usecases/add_idp_usecase.dart';
import '../domain/usecases/delete_idp_usecase.dart';
import '../domain/usecases/filter_idp_usecase.dart';
import '../domain/usecases/get_idp_usecase.dart';
import '../domain/usecases/getby_idp_usecase.dart';
import '../domain/usecases/list_idp_usecase.dart';
import '../domain/usecases/update_idp_usecase.dart';
import '../idp_exporting.dart';

class IdpBinding extends Bindings {
  IdpBinding() : super() {
    log("Registrando instancia de:${toString()} y sus dependencias.");
    dependencies();
  }

  @override
  void dependencies() {
    Get.lazyPut<IdpBinding>(() => this);
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );
    Get.lazyPut<IdpController>(
      () => IdpController(),
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
    Get.lazyPut<IdpProvider>(
      () => IdpProvider(),
    );
    Get.lazyPut<RemoteIdpDataSourceImpl>(
      () => RemoteIdpDataSourceImpl(),
    );
    Get.lazyPut<LocalIdpDataSourceImpl>(
      () => LocalIdpDataSourceImpl(),
    );
    Get.lazyPut<Repository<IdpModel>>(
      () => IdpRepositoryImpl<IdpModel>(),
    );
    Get.lazyPut<IdpRepository<IdpModel>>(
      () => IdpRepositoryImpl<IdpModel>(),
    );
    Get.lazyPut<UseCase>(
      () => AddIdpUseCase<IdpModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteIdpUseCase<IdpModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetIdpUseCase<IdpModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetIdpByFieldUseCase<IdpModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdateIdpUseCase<IdpModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ListIdpUseCase<IdpModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterIdpUseCase<IdpModel>(Get.find()),
    );
  }
}
