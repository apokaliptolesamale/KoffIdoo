// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomBottonTextFormFiedl extends StatelessWidget {
  final void Function()? onTap;
  final Widget icon;
  BoxDecoration? decoration;
  CustomBottonTextFormFiedl({
    Key? key,
    required this.onTap,
    required this.icon,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: decoration,
        child: icon,
      ),
      onTap: onTap,
    );
  }
}
