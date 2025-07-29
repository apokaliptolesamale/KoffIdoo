// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '/app/core/config/assets.dart';
import '/app/widgets/utils/size_constraints.dart';

class AccessOnTapWidget extends StatefulWidget {
  void Function(TapDownDetails)? onTapDown;
  void Function(TapUpDetails)? onTapUp;
  Color? onTapColor;
  Color? defaultColor;
  AccessOnTapWidget({
    Key? key,
    this.onTapDown,
    this.onTapUp,
    this.onTapColor = const Color.fromARGB(255, 181, 178, 178),
    this.defaultColor = Colors.transparent,
  }) : super(key: key);

  @override
  State<AccessOnTapWidget> createState() => _AccessOnTapWidgetState();
}

class _AccessOnTapWidgetState extends State<AccessOnTapWidget> {
  Color? onTapColor;
  Color? defaultColor;
  bool onTapPressed = false;
  @override
  Widget build(BuildContext context) {
    SizeConstraints contraint = SizeConstraints(context: context);
    return GestureDetector(
      onTapDown: (details) {
        widget.onTapDown != null ? widget.onTapDown!(details) : false;
        setState(() {
          onTapPressed = true;
        });
      },
      onTapUp: (details) {
        widget.onTapUp != null ? widget.onTapUp!(details) : false;
        setState(() {
          onTapPressed = false;
        });
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.only(
            top: 0,
            left: 0,
            right: 5,
          ),
          width: contraint.getHeightByPercent(onTapPressed ? 10 : 12),
          height: contraint.getHeightByPercent(onTapPressed ? 13 : 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: onTapPressed ? onTapColor : defaultColor,
            image: DecorationImage(
              image: AssetImage(
                ASSETS_IMAGES_ICONS_APP_WARRANTY_GARANTIA_JPEG,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    onTapColor = widget.onTapColor;
    defaultColor = widget.defaultColor;
  }
}
