// ignore_for_file: unrelated_type_equality_checks, unused_element

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '/app/modules/security/bindings/rbac_binding.dart';
import '/app/modules/security/data/repositories/rbac_repository_impl.dart';
import '../../../../app/core/services/logger_service.dart';
import '../../../core/config/errors/errors.dart';
import '../domain/models/rbac_model.dart';
import '../domain/repository/rbac_repository.dart';
import '../domain/usecases/load_roles_usecase.dart';
import 'security_controller.dart';

class RbacController extends SecurityController {
  static RbacController? _instance = RbacController._internal();
  static RbacController get getInstance =>
      _instance ??= RbacController._internal();
  RbacModel? _rbac;

  LoadRolesUseCase<RbacModel> loadRbac = Get.isRegistered<LoadRolesUseCase>()
      ? Get.find()
      : LoadRolesUseCase<RbacModel>(Get.isRegistered<RbacRepository>()
          ? Get.find()
          : RbacRepositoryImpl<RbacModel>());

  RbacController._internal() {
    if (!Get.isRegistered<RbacBinding>()) {
      RbacBinding().dependencies();
    }
    log("Iniciando instancia de RbacController...");
  }
  Future<Either<Failure, RbacModel>> loadRoles(
      Map<String, dynamic> params) async {
    loadRbac.setParamsFromMap(params);
    return loadRbac.call(null);
  }

  RbacController setRbac(RbacModel rbac) {
    _rbac = rbac;
    return this;
  }
}
