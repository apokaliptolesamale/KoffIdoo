// ignore_for_file: unnecessary_overrides

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/interfaces/use_case.dart';
import '../domain/models/idp_model.dart';
import '../domain/usecases/add_idp_usecase.dart';
import '../domain/usecases/delete_idp_usecase.dart';
import '../domain/usecases/filter_idp_usecase.dart';
import '../domain/usecases/get_idp_usecase.dart';
import '../domain/usecases/getby_idp_usecase.dart';
import '../domain/usecases/list_idp_usecase.dart';
import '../domain/usecases/update_idp_usecase.dart';


class IdpController extends GetxController {

  AddIdpUseCase<IdpModel> addIdp = AddIdpUseCase<IdpModel>(Get.find());
  DeleteIdpUseCase<IdpModel> deleteIdp = DeleteIdpUseCase<IdpModel>(Get.find());
  GetIdpUseCase<IdpModel> getIdp = GetIdpUseCase<IdpModel>(Get.find());
  GetIdpByFieldUseCase<IdpModel> getIdpByField = GetIdpByFieldUseCase<IdpModel>(Get.find());
  UpdateIdpUseCase<IdpModel> updateIdp = UpdateIdpUseCase<IdpModel>(Get.find());
  ListIdpUseCase<IdpModel> listIdpUseIdp = ListIdpUseCase<IdpModel>(Get.find());
  FilterIdpUseCase<IdpModel> filterUseIdp = FilterIdpUseCase<IdpModel>(Get.find());
  
  
  IdpController() : super();

  Future<Either<Failure, EntityModelList<IdpModel>>> getIdps() =>
      listIdpUseIdp.getAll();

  Future<Either<Failure, EntityModelList<IdpModel>>> filterIdps() =>
      filterUseIdp.filter();

  Future<T> getFutureByUseCase<T>(UseCase uc) {
    Future<T> result;
    if (uc is FilterIdpUseCase) {
      result = filterIdps().then((value) => Future.value(value as T));
    } else {
      result = getIdps().then((value) => Future.value(value as T));
    }
    return result;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
