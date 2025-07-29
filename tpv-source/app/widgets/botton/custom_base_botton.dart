// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '/app/widgets/components/custom_widget.dart';

import '../../../app/core/types/custom_types.dart';
import 'custom_bottons.dart';

class CustomBaseBotton extends StatelessWidget
    implements CustomButtonsInterface {
  Widget icon;
  MouseCursor? cursor;
  bool? opaque;
  HitTestBehavior? hitTestBehavior;
  onTapCallBack? onTap;
  onEnterCallBack? onEnter;
  onExitCallBack? onExit;
  onHoverCallBack? onHover;

  @override
  CustomWidgetInterface? container;

  CustomBaseBotton({
    Key? key,
    required this.icon,
    this.cursor,
    this.opaque,
    this.hitTestBehavior,
    this.onTap,
    this.onEnter,
    this.onExit,
    this.onHover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onTap != null ? onTap!(context, this) : false;
        },
        child: MouseRegion(
          child: icon,
          onHover: (event) {
            onHover != null ? onHover!(context, event, this) : false;
          },
          onEnter: (event) {
            onEnter != null ? onEnter!(context, event, this) : false;
          },
          onExit: (event) {
            onExit != null ? onExit!(context, event, this) : false;
          },
          cursor: cursor ?? SystemMouseCursors.click,
          opaque: false,
          hitTestBehavior: hitTestBehavior ?? HitTestBehavior.deferToChild,
        ),
      ),
    );
  }

  @override
  CustomWidgetInterface setContainer(CustomWidgetInterface container) {
    this.container = container;
    return this;
  }
}
