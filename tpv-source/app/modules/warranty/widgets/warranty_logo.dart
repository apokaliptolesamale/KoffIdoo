// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../app/core/config/assets.dart';

class WarrantyLogo extends StatelessWidget {
  EdgeInsets? margin;
  double? height, width;
  WarrantyLogo({Key? key, this.margin, this.height = 100, this.width = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(top: 30),
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage(ASSETS_IMAGES_LOGOS_WARRANTY_WARRANTY_LOGO_PNG),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
