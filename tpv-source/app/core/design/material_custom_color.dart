import 'dart:convert';

import 'package:flutter/material.dart';

import '/app/core/helpers/functions.dart';
import 'color.dart';

class MaterialCustomColor extends MaterialColor {
  //
  final Map<int, Color> swatch;

  MaterialCustomColor(
    int primary,
    this.swatch,
  ) : super(
          primary,
          swatch,
        );
  factory MaterialCustomColor.fromDefault() {
    return MaterialCustomColor(1, {});
  }
  factory MaterialCustomColor.fromJson(Map<String, dynamic> json) {
    final color = json.containsKey('primary') ? json['primary'] : 'Default';
    final Map<int, CustomColor> swatch = json.containsKey('swatch')
        ? (json['swatch'] as Map<String, dynamic>).map(
            (key, value) =>
                MapEntry(int.parse(key), CustomColor.fromColor(value)),
          )
        : CustomColor.getSwatch(CustomColor.fromString(color));
    return MaterialCustomColor(color, swatch);
  }

  factory MaterialCustomColor.fromString(String str) {
    if (isJson(str)) {
      return MaterialCustomColor.fromJson(json.decode(str));
    }
    final color = CustomColor.fromString(str);
    final Map<int, CustomColor> swatch =
        CustomColor.getSwatch(color); // {1: CustomColor.fromString(str)};
    final tmp = "0x${color.value.toRadixString(16).toUpperCase()}";
    return MaterialCustomColor(int.parse(tmp), swatch);
  }

  Map<String, dynamic> toJson() {
    final swatchJson =
        swatch.map((key, value) => MapEntry(key.toString(), value.value));
    return <String, dynamic>{
      'primary': value,
      'swatch': swatchJson,
    };
  }

  static Map<int, CustomColor> getSwatch(CustomColor color) =>
      CustomColor.getSwatch(color);
}
