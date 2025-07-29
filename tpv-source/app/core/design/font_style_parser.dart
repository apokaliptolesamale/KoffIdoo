import 'dart:ui';

extension FontStyleParser on FontStyle {
  static FontStyle get italic => FontStyle.italic;
  static FontStyle get normal => FontStyle.normal;

  static FontStyle parse(dynamic value) {
    if (value is FontStyle) {
      return value;
    } else if (value is String) {
      switch (value) {
        case "normal":
          return FontStyle.normal;
        case "italic":
          return FontStyle.italic;
      }
    }
    return FontStyle.normal;
  }

  static String value(FontStyle? value) {
    return value != null
        ? value.toString().replaceAll("FontStyle.", "")
        : "normal";
  }
}
