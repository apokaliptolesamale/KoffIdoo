import 'dart:ui';

extension FontWeightParser on FontWeight {
  //
  static FontWeight get bold => FontWeight.bold;

  static FontWeight get normal => FontWeight.normal;

  static FontWeight parse(dynamic value) {
    if (value is FontWeight) {
      return value;
    } else if (value is String) {
      switch (value) {
        case "w100":
          return FontWeight.w100;
        case "w200":
          return FontWeight.w200;
        case "w300":
          return FontWeight.w300;
        case "w400":
          return FontWeight.w400;
        case "w500":
          return FontWeight.w500;
        case "w600":
          return FontWeight.w600;
        case "w700":
          return FontWeight.w700;
        case "w800":
          return FontWeight.w800;
        case "w900":
          return FontWeight.w900;
        case "normal":
          return FontWeight.normal;
        case "bold":
          return FontWeight.bold;
        case "100":
          return FontWeight.w100;
        case "200":
          return FontWeight.w200;
        case "300":
          return FontWeight.w300;
        case "400":
          return FontWeight.w400;
        case "500":
          return FontWeight.w500;
        case "600":
          return FontWeight.w600;
        case "700":
          return FontWeight.w700;
        case "800":
          return FontWeight.w800;
        case "900":
          return FontWeight.w900;
      }
    }
    return FontWeight.normal;
  }

  static String value(FontWeight? value) {
    return value != null
        ? value.toString().replaceAll("FontWeight.", "")
        : "normal";
  }
}
