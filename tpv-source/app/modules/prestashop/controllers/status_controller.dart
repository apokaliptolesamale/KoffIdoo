// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../domain/models/status_model.dart';
import '../domain/usecases/add_status_usecase.dart';
import '../domain/usecases/delete_status_usecase.dart';
import '../domain/usecases/filter_status_usecase.dart';
import '../domain/usecases/get_status_usecase.dart';
import '../domain/usecases/getby_status_usecase.dart';
import '../domain/usecases/list_status_usecase.dart';
import '../domain/usecases/update_status_usecase.dart';

class StatusController extends GetxController {
  AddStatusUseCase<StatusModel> addStatus =
      AddStatusUseCase<StatusModel>(Get.find());
  DeleteStatusUseCase<StatusModel> deleteStatus =
      DeleteStatusUseCase<StatusModel>(Get.find());
  GetStatusUseCase<StatusModel> getStatus =
      GetStatusUseCase<StatusModel>(Get.find());
  GetStatusByFieldUseCase<StatusModel> getStatusByField =
      GetStatusByFieldUseCase<StatusModel>(Get.find());
  UpdateStatusUseCase<StatusModel> updateStatus =
      UpdateStatusUseCase<StatusModel>(Get.find());
  ListStatusUseCase<StatusModel> listStatusUseStatus =
      ListStatusUseCase<StatusModel>(Get.find());
  FilterStatusUseCase<StatusModel> filterUseStatus =
      FilterStatusUseCase<StatusModel>(Get.find());

  StatusController() : super();

  Future<Either<Failure, EntityModelList<StatusModel>>> filterStatuss() =>
      filterUseStatus.filter();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is FilterStatusUseCase) {
      result = filterStatuss().then((value) => Future.value(value as T));
    } else {
      result = getStatuss().then((value) => Future.value(value as T));
    }
    return result;
  }

  Future<Either<Failure, EntityModelList<StatusModel>>> getStateByField(
      String field, String value) {
    return getStatusByField
        .setParamsFromMap({"field": field, "value": value}).call(null);
  }

  Future<Either<Failure, EntityModelList<StatusModel>>> getStatuss() =>
      listStatusUseStatus.getAll();

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
