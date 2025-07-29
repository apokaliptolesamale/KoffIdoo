//ASSETS_IMAGES_WARRANTY_APP_SIN_NADA_PNG

import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable

import '../../../core/config/assets.dart';

class EmptyDataCard extends StatelessWidget {
  String text;
  EdgeInsetsGeometry? margin;
  void Function() onPressed;
  double height;
  double width;
  EmptyDataCard({
    Key? key,
    required this.text,
    required this.onPressed,
    this.height = 200,
    this.width = 200,
    this.margin = const EdgeInsets.only(top: 50),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(children: [
        GestureDetector(
            onTap: onPressed,
            child: Container(
              margin: margin,
              height: height,
              width: width,
              child: Image.asset(
                ASSETS_IMAGES_ICONS_APP_SIN_NADA_PNG,
              ),
            )),
        Text(
          text,
          style: TextStyle(
            color: Colors.teal,
            fontSize: 20,
            fontFamily: "Source Sans Pro",
          ),
        )
      ]),
    );
  }
}
