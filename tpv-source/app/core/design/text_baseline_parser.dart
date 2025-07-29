import 'dart:ui';

extension TextBaselineParser on TextBaseline {
  static TextBaseline get alphabetic => TextBaseline.alphabetic;
  static TextBaseline get ideographic => TextBaseline.ideographic;
  static TextBaseline parse(dynamic value) {
    if (value is TextBaseline) {
      return value;
    } else if (value is String) {
      switch (value) {
        case "alphabetic":
          return TextBaseline.alphabetic;
        case "ideographic":
          return TextBaseline.ideographic;
      }
    }
    return TextBaseline.alphabetic;
  }

  static String value(TextBaseline? value) {
    return value != null
        ? value.toString().replaceAll("TextBaseline.", "")
        : "alphabetic";
  }
}
