// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../app/widgets/menu/horizontal_menu_item.dart';
import '../../../app/widgets/screen/responsiveness.dart';
import 'vertical_menu_item.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final Function onTap;
  final String route;
  SideMenuItem({
    Key? key,
    required this.itemName,
    required this.route,
    required this.onTap,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomScreen(context)) {
      return VerticalMenuItem(itemName: itemName, route: route, onTap: onTap);
    }
    return HorizontalMenuItem(itemName: itemName, route: route, onTap: onTap);
  }
}
