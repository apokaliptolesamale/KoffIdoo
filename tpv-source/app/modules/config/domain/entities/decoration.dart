import 'package:flutter/material.dart';

class Decoration {
  String name;
  Color color;
  double opacityColor;
  double hoverOpacityColor;
  String borderRadius;
  String borderRadiusType;

  Decoration({
    required this.name,
    required this.color,
    required this.opacityColor,
    required this.hoverOpacityColor,
    this.borderRadius = "",
    this.borderRadiusType = "",
  });
}
