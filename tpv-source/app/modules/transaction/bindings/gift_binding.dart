import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '/app/modules/card/bindings/card_binding.dart';
import '/app/modules/transaction/domain/repository/card_gift_repository.dart';
import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../../security/data/providers/token_provider.dart';
import '../data/datasources/card_gift_datasource.dart';
import '../data/datasources/category_gift_datasource.dart';
import '../data/providers/card_gift_provider.dart';
import '../data/providers/category_provider.dart';
import '../data/providers/gift_provider.dart';
import '../data/repositories/card_gift_repository_impl.dart';
import '../data/repositories/category_gift_repository_impl.dart';
import '../domain/models/cardGift_model.dart';
import '../domain/models/category_model.dart';
import '../domain/models/gift_model.dart';
import '../domain/repository/category_repository.dart';
import '../domain/usecases/add_gift_usecase.dart';
import '../domain/usecases/delete_gift_usecase.dart';
import '../domain/usecases/filter_card_gift_category_use_case.dart';
import '../domain/usecases/filter_gift_usecase.dart';
import '../domain/usecases/get_gift_usecase.dart';
import '../domain/usecases/getby_gift_usecase.dart';
import '../domain/usecases/list_gift_category_usecase.dart';
import '../domain/usecases/list_gift_usecase.dart';
import '../gift_exporting.dart';

class GiftBinding extends Bindings {
  GiftBinding() : super() {
    log("Registrando instancia de:${toString()} y sus dependencias.");
    dependencies();
  }

  @override
  void dependencies() {
    Get.lazyPut<GiftBinding>(() => this);
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );

    Get.lazyPut(
      () => CardBinding().dependencies(),
    );
    Get.lazyPut<GiftController>(
      () => GiftController(),
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
    Get.lazyPut<GiftProvider>(
      () => GiftProvider(),
    );
    Get.lazyPut<CategoryProvider>(
      () => CategoryProvider(),
    );
    Get.lazyPut<CardGiftProvider>(
      () => CardGiftProvider(),
    );
    Get.lazyPut<RemoteGiftDataSourceImpl>(
      () => RemoteGiftDataSourceImpl(),
    );
    Get.lazyPut<RemoteCardGiftDataSourceImpl>(
      () => RemoteCardGiftDataSourceImpl(),
    );
    Get.lazyPut<RemoteCategoryGiftDataSourceImpl>(
      () => RemoteCategoryGiftDataSourceImpl(),
    );
    Get.lazyPut<LocalGiftDataSourceImpl>(
      () => LocalGiftDataSourceImpl(),
    );
    Get.lazyPut<LocalCardGiftDataSourceImpl>(
      () => LocalCardGiftDataSourceImpl(),
    );
    Get.lazyPut<LocalCategoryDataSourceImpl>(
      () => LocalCategoryDataSourceImpl(),
    );
    Get.lazyPut<Repository<GiftModel>>(
      () => GiftRepositoryImpl<GiftModel>(),
    );
    Get.lazyPut<CardGiftRepository<CardGiftModel>>(
      () => CardGiftRepositoryImpl<CardGiftModel>(),
    );

    Get.lazyPut<GiftRepository<GiftModel>>(
      () => GiftRepositoryImpl<GiftModel>(),
    );
    Get.lazyPut<CategoryGiftRepository<CategoryGiftModel>>(
      () => CategoryGiftRepositoryImpl<CategoryGiftModel>(),
    );
    Get.lazyPut<UseCase>(
      () => AddGiftUseCase<GiftModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteGiftUseCase<GiftModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetGiftUseCase<GiftModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetGiftByFieldUseCase<GiftModel>(Get.find()),
    );

    Get.lazyPut<UseCase>(
      () => ListGiftUseCase<GiftModel>(Get.find()),
    );

    Get.lazyPut<UseCase>(
      () => FilterGiftUseCase<GiftModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterCardGiftCategoryUseCase<CardGiftModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ListGiftCategoryUseCase<CategoryGiftModel>(Get.find()),
    );
  }
}
