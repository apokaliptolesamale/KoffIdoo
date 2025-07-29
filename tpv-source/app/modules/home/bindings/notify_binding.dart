import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rest_client/rest_client.dart' as rest_client;

import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../../security/data/providers/token_provider.dart';
import '../../home/controllers/home_controller.dart' as home_app;
import '../domain/models/notify_model.dart';
import '../domain/usecases/add_notify_usecase.dart';
import '../domain/usecases/delete_notify_usecase.dart';
import '../domain/usecases/get_notify_usecase.dart';
import '../domain/usecases/getby_notify_usecase.dart';
import '../domain/usecases/update_notify_usecase.dart';
import '../domain/usecases/list_notify_usecase.dart';
import '../domain/usecases/filter_notify_usecase.dart';
import '../notify_exporting.dart';
import '../data/providers/notify_provider.dart';



class NotifyBinding extends Bindings 
{

  NotifyBinding() : super() {
    log("Registrando instancia de:${toString()} y sus dependencias.");
    dependencies();
  }

  @override
  void dependencies() 
  {
    Get.lazyPut<NotifyBinding>(() => this);
    Get.lazyPut<TokenProvider>(
      () => TokenProvider(),
    );   
    Get.lazyPut<NotifyController>(
      () => NotifyController(),
    );
    Get.lazyPut<home_app.HomeController>(() => home_app.HomeController(),
    );
    Get.lazyPut<http.Client>(
      () => http.Client(),
    );
    Get.lazyPut<rest_client.Client>(
      () => rest_client.Client(),
    );
     Get.lazyPut<NotifyProvider>(
      () => NotifyProvider(),
    );
    Get.lazyPut<RemoteNotifyDataSourceImpl>(
      () => RemoteNotifyDataSourceImpl(),
    );
    Get.lazyPut<LocalNotifyDataSourceImpl>(
      () => LocalNotifyDataSourceImpl(),
    );
    Get.lazyPut<Repository<NotifyModel>>(
      () => NotifyRepositoryImpl<NotifyModel>(),
    );
    Get.lazyPut<NotifyRepository<NotifyModel>>(
      () => NotifyRepositoryImpl<NotifyModel>(),
    );
    Get.lazyPut<UseCase>(
      () => AddNotifyUseCase<NotifyModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => DeleteNotifyUseCase<NotifyModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetNotifyUseCase<NotifyModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => GetNotifyByFieldUseCase<NotifyModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => UpdateNotifyUseCase<NotifyModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => ListNotifyUseCase<NotifyModel>(Get.find()),
    );
    Get.lazyPut<UseCase>(
      () => FilterNotifyUseCase<NotifyModel>(Get.find()),
    );
    

  }
  
}
