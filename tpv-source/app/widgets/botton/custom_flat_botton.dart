// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomFlatBotton extends StatelessWidget {
  late double _height;
  late double _width;
  Widget child;
  EdgeInsets? padding;
  Color? color;
  OutlinedBorder? shape;
  void Function() onPressed;

  CustomFlatBotton({
    required this.child,
    required this.onPressed,
    Key? key,
    double height = 30,
    double width = 120,
    this.padding,
    this.color,
    this.shape,
  }) : super(key: key) {
    _height = height;
    _width = width;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      minimumSize: Size(_width, _height),
      backgroundColor: theme.buttonTheme.colorScheme!.background,
      padding: padding,
      shape: shape,
    );
    return TextButton(
      style: flatButtonStyle,
      onPressed: onPressed,
      child: child,
    );
  }
}
