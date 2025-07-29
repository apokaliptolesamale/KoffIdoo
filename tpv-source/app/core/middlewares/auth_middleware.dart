import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/config/app_config.dart';
import '/app/core/services/manager_authorization_service.dart';
import '/app/modules/security/controllers/security_controller.dart';
import '/globlal_constants.dart';

class AuthMidleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    String returnUrl = Uri.encodeFull(route ?? '');
    String loginRoute = ConfigApp.getInstance.configModel!.loginRoute;
    String homeRoute = ConfigApp.getInstance.configModel!.homePageRoute;
    final service = ManagerAuthorizationService().get(defaultIdpKey);
    bool securityDisabled = service != null &&
        service.active == false &&
        service.ignoreOnError == true;
    final security = Get.find<SecurityController>();
    return security.authStatus == AuthStatus.authenticated || securityDisabled
        ? null
        : RouteSettings(
            name: !securityDisabled ? loginRoute : homeRoute,
            arguments: returnUrl,
          );
  }
}
