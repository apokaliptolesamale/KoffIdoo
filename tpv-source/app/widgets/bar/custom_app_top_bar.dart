// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../app/widgets/botton/custom_app_toolbar_bottons.dart';
import '../../../app/widgets/utils/size_constraints.dart';
import '../../core/config/styles.dart';

class CustomAppTopBar extends StatelessWidget implements PreferredSizeWidget {
  Widget? container;
  List<Widget>? buttons;

  CustomAppTopBar({
    Key? key,
    this.container,
    this.buttons,
  }) : super(key: key);

  @override
  Size get preferredSize => Size(double.infinity, 40);

  @override
  Widget build(BuildContext context) {
    final constraint = SizeConstraints(context: context);
    final height = constraint.getHeightByPercent(3);
    return Container(
      width: constraint.getWidth,
      height: height < 30 ? 30 : height,
      //padding: EdgeInsets.all(constraint.getWidthByPercent(0.2)),
      decoration: BoxDecoration(
          color: sideBarColorStyle,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Column(
        children: [
          Flexible(
            child: SizedBox(
              child: Row(
                children: [
                  Expanded(child: Container()),
                  CustomAppTopBarButtons(
                    buttons: buttons ?? <Widget>[],
                  ),
                  SizedBox(
                    width: constraint.getWidthByPercent(1.5),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void setContainer(Widget widget) {
    container = widget;
  }
}
