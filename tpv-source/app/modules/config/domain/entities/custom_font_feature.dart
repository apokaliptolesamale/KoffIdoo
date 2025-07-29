// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: overridden_fields

import 'dart:ui';

class CustomFontFeature extends FontFeature {
  @override
  final String feature;
  @override
  final int value;
  CustomFontFeature({
    required this.feature,
    required this.value,
  }) : super(feature, value);
}
