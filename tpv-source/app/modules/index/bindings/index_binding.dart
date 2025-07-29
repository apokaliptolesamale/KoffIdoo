import 'package:get/get.dart';

import '/app/modules/index/views/pages/index_page.dart';
import '/app/modules/index/views/pages/root_page.dart';
import '/app/modules/security/bindings/security_binding.dart';
import '/app/routes/app_pages.dart';
import '../controllers/index_controller.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndexController>(
      () => IndexController(),
    );
    Get.lazyPut<SecurityBinding>(() => SecurityBinding());
  }

  loadPages() {
    AppPages.addAllRouteIfAbsent([
      RootPageImpl.builder(),
      IndexAppPageImpl.builder(),
    ]);
  }
}
