import 'dart:ui';

extension TextDecorationStyleParser on TextDecorationStyle {
  static TextDecorationStyle get dashed => TextDecorationStyle.dashed;

  static TextDecorationStyle get dotted => TextDecorationStyle.dotted;

  static TextDecorationStyle get double => TextDecorationStyle.double;

  //
  static TextDecorationStyle get solid => TextDecorationStyle.solid;

  static TextDecorationStyle get wavy => TextDecorationStyle.wavy;

  static TextDecorationStyle parse(dynamic value) {
    if (value is TextDecorationStyle) {
      return value;
    } else if (value is String) {
      switch (value) {
        case "solid":
          return TextDecorationStyle.solid;
        case "double":
          return TextDecorationStyle.double;
        case "dotted":
          return TextDecorationStyle.dotted;
        case "dashed":
          return TextDecorationStyle.dashed;
        case "wavy":
          return TextDecorationStyle.wavy;
      }
    }
    return TextDecorationStyle.solid;
  }

  static String value(TextDecorationStyle? value) {
    return value != null ? value.toString() : "solid";
  }
}
