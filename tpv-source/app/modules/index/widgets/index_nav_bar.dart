// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/core/config/assets.dart';
import '../../security/controllers/security_controller.dart';
import '../controllers/index_controller.dart';

class IndexNavBar extends GetResponsiveView<IndexController> {
  final security = Get.find<SecurityController>();

  String? urlLogo;

  IndexNavBar({Key? key, this.urlLogo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(55, 0, 0, 0),
            child: Image(
              image: AssetImage(urlLogo ?? ASSETS_IMAGES_LOGOS_LOGO_PNG),
              height: 25,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 55, 0),
            child: TextButton(
              onPressed: () {
                security.toLogin();
              },
              child: Text('Iniciar sessión'),
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5),
        ],
      );
}
