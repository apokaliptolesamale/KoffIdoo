// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../domain/models/notify_model.dart';
import '../domain/usecases/add_notify_usecase.dart';
import '../domain/usecases/delete_notify_usecase.dart';
import '../domain/usecases/filter_notify_usecase.dart';
import '../domain/usecases/get_notify_usecase.dart';
import '../domain/usecases/getby_notify_usecase.dart';
import '../domain/usecases/list_notify_usecase.dart';
import '../domain/usecases/update_notify_usecase.dart';

class NotifyController extends GetxController {
  AddNotifyUseCase<NotifyModel> addNotify =
      AddNotifyUseCase<NotifyModel>(Get.find());
  DeleteNotifyUseCase<NotifyModel> deleteNotify =
      DeleteNotifyUseCase<NotifyModel>(Get.find());
  GetNotifyUseCase<NotifyModel> getNotify =
      GetNotifyUseCase<NotifyModel>(Get.find());
  GetNotifyByFieldUseCase<NotifyModel> getNotifyByField =
      GetNotifyByFieldUseCase<NotifyModel>(Get.find());
  UpdateNotifyUseCase<NotifyModel> updateNotify =
      UpdateNotifyUseCase<NotifyModel>(Get.find());
  ListNotifyUseCase<NotifyModel> listNotifyUseNotify =
      ListNotifyUseCase<NotifyModel>(Get.find());
  FilterNotifyUseCase<NotifyModel> filterUseNotify =
      FilterNotifyUseCase<NotifyModel>(Get.find());

  NotifyController() : super();

  Future<Either<Failure, EntityModelList<NotifyModel>>> filterNotifys() =>
      filterUseNotify.filter();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is FilterNotifyUseCase) {
      result = filterNotifys().then((value) => Future.value(value as T));
    } else {
      result = getNotifys().then((value) => Future.value(value as T));
    }
    return result;
  }

  Future<Either<Failure, EntityModelList<NotifyModel>>> getNotifys() =>
      listNotifyUseNotify.getAll();

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
