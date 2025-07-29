// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: overridden_fields

import 'dart:ui';

class CustomFontVariation extends FontVariation {
  @override
  final String axis;
  @override
  final double value;
  CustomFontVariation({
    required this.axis,
    required this.value,
  }) : super(axis, value);
}
