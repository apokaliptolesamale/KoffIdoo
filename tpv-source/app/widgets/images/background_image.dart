// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BackGroundColor extends StatelessWidget {
  Color? backgroundColor;
  BackGroundColor({
    Key? key,
    this.backgroundColor = Colors.white,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: backgroundColor),
    );
  }
}

class BackGroundImage extends StatelessWidget {
  String backgroundImage;
  BackGroundImage({
    Key? key,
    required this.backgroundImage,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
