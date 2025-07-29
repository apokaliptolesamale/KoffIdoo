import 'dart:ui';

extension TextDecorationParser on TextDecoration {
  static TextDecoration get lineThrough => TextDecoration.lineThrough;

  static TextDecoration get none => TextDecoration.none;

  static TextDecoration get overline => TextDecoration.overline;

  static TextDecoration get underline => TextDecoration.underline;

  static TextDecoration parse(dynamic value) {
    if (value is TextDecoration) {
      return value;
    } else if (value is String) {
      switch (value) {
        case "none":
          return TextDecoration.none;
        case "underline":
          return TextDecoration.underline;
        case "overline":
          return TextDecoration.overline;
        case "lineThrough":
          return TextDecoration.lineThrough;
      }
    }
    return TextDecoration.none;
  }

  static String value(TextDecoration? value) {
    return value != null
        ? value.toString().replaceAll("TextDecoration.", "")
        : "none";
  }
}
