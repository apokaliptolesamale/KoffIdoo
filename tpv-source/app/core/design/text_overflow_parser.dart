import 'package:flutter/material.dart';

extension TextOverflowParser on TextOverflow {
  //
  static TextOverflow get clip => TextOverflow.clip;

  static TextOverflow get ellipsis => TextOverflow.clip;

  static TextOverflow get fade => TextOverflow.clip;

  static TextOverflow parse(dynamic value) {
    if (value is TextOverflow) {
      return value;
    } else if (value is String) {
      switch (value) {
        case "clip":
          return TextOverflow.clip;
        case "ellipsis":
          return TextOverflow.ellipsis;
        case "fade":
          return TextOverflow.fade;
      }
    }
    return TextOverflow.ellipsis;
  }

  static String value(TextOverflow? value) {
    return value != null
        ? value.toString().replaceAll("TextOverflow.", "")
        : "ellipsis";
  }
}
