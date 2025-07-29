import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/modules/home/widgets/menu_item.dart';
import '../../../../app/modules/home/widgets/navbar.dart';
import '../../../../app/modules/home/widgets/text_separator.dart';
import '../../../../app/widgets/layout/row/ez_logo.dart';
import '../../../../app/widgets/utils/size_constraints.dart';
import '../../routes/app_routes.dart';

class AppHomeContainerProvider {
  static Widget getHomeContainer(BuildContext context, double percent) {
    final constraint = SizeConstraints(context: context);
    final vSeparator = constraint.getWidthByPercent(2);
    return Container(
      width: constraint.getWidthByPercent(percent),
      height: double.infinity,
      decoration: _buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          EzLogo(height: NavBar.instance.preferredSize.height),
          SizedBox(height: vSeparator),
          TextSeparator(text: 'Operaciones'),
          CustomMenuItem(
            text: 'Dashboard',
            icon: Icons.dashboard_outlined,
            onPressed: () {
              NavBar.instance.clearExtraButtons();
              Get.toNamed(Routes.getInstance.getPath("HOME"));
            },
          ),
          CustomMenuItem(
            text: 'Casos',
            icon: Icons.report_problem,
            onPressed: () {
              NavBar.instance.clearExtraButtons();
              Get.toNamed(Routes.getInstance.getPath("SUPPORT_INCIDENTS"));
            },
          ),
          SizedBox(height: vSeparator),
          TextSeparator(text: 'Configuración'),
          CustomMenuItem(
            text: 'Nomencladores',
            icon: Icons.star,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  static BoxDecoration _buildBoxDecoration() => BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff092044),
              Color(0xff092042),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
            ),
          ]);
}
