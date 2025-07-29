import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '/app/core/services/logger_service.dart';
import '../../../core/interfaces/repository.dart';
import '../../../core/interfaces/use_case.dart';
import '../data/datasources/rbac_datasource.dart';
import '../data/providers/rbac_provider.dart';
import '../data/repositories/rbac_repository_impl.dart';
import '../domain/models/rbac_model.dart';
import '../domain/repository/rbac_repository.dart';
import '../domain/usecases/load_roles_usecase.dart';
import 'security_binding.dart';

class RbacBinding extends Bindings {
  RbacBinding() : super() {
    if (!Get.isRegistered<RbacBinding>()) {
      Get.lazyPut<RbacBinding>(
        () => this,
      );
      loadPages();
      dependencies();
    }
  }

  @override
  void dependencies() {
    final secBinding = SecurityBinding();
    secBinding.dependencies();
    Get.lazyPut<SecurityBinding>(() => secBinding);
    Get.lazyPut<FlutterSecureStorage>(
      () => FlutterSecureStorage(),
    );
    Get.lazyPut<RbacProvider>(
      () => RbacProvider(),
    );
    Get.lazyPut<RemoteRbacDataSourceImpl>(
      () => RemoteRbacDataSourceImpl(),
    );
    Get.lazyPut<LocalRbacDataSourceImpl>(
      () => LocalRbacDataSourceImpl(),
    );
    Get.lazyPut<Repository<RbacModel>>(
      () => RbacRepositoryImpl<RbacModel>(),
    );
    Get.lazyPut<RbacRepository<RbacModel>>(
      () => RbacRepositoryImpl<RbacModel>(),
    );

    Get.lazyPut<UseCase>(
      () => LoadRolesUseCase<RbacModel>(Get.find()),
    );
  }

  static loadPages() {
    log("Inicializando páginas del módulo");
  }
}
