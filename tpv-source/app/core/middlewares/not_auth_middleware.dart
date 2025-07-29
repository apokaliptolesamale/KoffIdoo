import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/config/app_config.dart';
import '../../../app/modules/security/controllers/security_controller.dart';

class NotAuthMidleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    String returnUrl = Uri.encodeFull(route ?? '');
    String homeRoute = ConfigApp.getInstance.configModel!.homePageRoute;

    final security = Get.find<SecurityController>();
    return security.authStatus == AuthStatus.notAuthenticated
        ? null
        : RouteSettings(
            name: homeRoute,
            arguments: returnUrl,
          );
  }
}
