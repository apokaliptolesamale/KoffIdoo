// ignore_for_file: public_member_api_docs, sort_constructors_first, overridden_fields
import 'package:flutter/material.dart';

class CustomShadow extends Shadow {
  @override
  final double blurRadius;
  final double dx;
  final double dy;
  @override
  final Color color;
  dynamic idShadow;
  final String name;
  CustomShadow({
    this.idShadow,
    required this.name,
    required this.blurRadius,
    required this.dx,
    required this.dy,
    required this.color,
  }) : super(
          blurRadius: blurRadius,
          color: color,
          offset: Offset(dx, dy),
        );
}
