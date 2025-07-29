import 'package:get/get.dart';

import '../../../../app/core/services/logger_service.dart';
import '../../security/controllers/security_controller.dart';

class HomeController extends GetxController {
  final security = Get.find<SecurityController>();

  @override
  void onClose() {}

  @override
  void onInit() {
    log('inciando home view');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    log('home view iniciado');
  }
}
