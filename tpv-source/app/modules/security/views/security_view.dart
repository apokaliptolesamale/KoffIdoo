// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/widgets/components/enzona_login.dart';
import '../controllers/security_controller.dart';

class SecurityView extends GetResponsiveView<SecurityController> {
  SecurityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EnzonaLoginWidget(
      controller: controller,
    );
  }
}
