// ignore_for_file: overridden_fields, must_be_immutable

import 'package:flutter/material.dart';

class CustomIconThemeData extends IconThemeData {
  @override
  double? size;
  @override
  double? fill;
  @override
  double? weight;
  @override
  double? grade;
  @override
  double? opticalSize;
  @override
  Color? color;
  @override
  double? opacity;
  @override
  List<Shadow>? shadows;
  //
  CustomIconThemeData({
    this.size = 24.0,
    this.fill = 0.0,
    this.weight = 400.0,
    this.grade = 0.0,
    this.opticalSize = 48.0,
    this.color = const Color(0xFF000000),
    double? opacity = 1.0,
    this.shadows,
  }) : super(
          size: size,
          fill: fill,
          weight: weight,
          grade: grade,
          opticalSize: opticalSize,
          color: color,
          opacity: opacity,
          shadows: shadows,
        );
}
