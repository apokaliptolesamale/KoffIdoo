import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/core/interfaces/entity_model.dart';

String configModelToJson(CustomColor data) => json.encode(data.toJson());

CustomColorList customColorListModelFromJson(String str) =>
    CustomColorList.fromJson(json.decode(str));

CustomColor customColorModelFromJson(String str) =>
    CustomColor.fromJson(json.decode(str));

class CustomColor extends Color {
  @override
  int alpha;
  @override
  int blue;
  @override
  int green;
  @override
  int red;

  int maxValue;
  int minValue;
  int delta;
  double lightness;
  double saturation;
  double hue;

  @override
  double opacity;

  final String name;
  final String hex;
  String? rgb;
  String? hsl;

  late Color color;

  CustomColor({
    required this.name,
    required this.hex,
    this.blue = 0,
    this.alpha = 0,
    this.red = 0,
    this.green = 0,
    this.lightness = 0,
    this.saturation = 0,
    this.minValue = 0,
    this.maxValue = 0,
    this.delta = 0,
    this.hue = 0,
    this.rgb,
    this.hsl,
    this.opacity = 0.0,
  }) : super(int.parse(hex.replaceAll(RegExp(r'#|0x'), "").toString(),
            radix: 16)) {
    int abgr = value;
    // int.parse(hex.replaceAll("#", "").toString(), radix: 16);
    alpha = abgr >> 24 & 0xFF;
    blue = abgr >> 16 & 0xFF;
    green = abgr >> 8 & 0xFF;
    red = abgr & 0xFF;

    maxValue = math.max(red, math.max(green, blue));
    minValue = math.min(red, math.min(green, blue));
    delta = maxValue - minValue;
    hue = _getHue(red.toDouble(), green.toDouble(), blue.toDouble(),
        maxValue.toDouble(), delta.toDouble());
    lightness = (maxValue + minValue) / 2.0;
    saturation = lightness == 1.0
        ? 0.0
        : ((delta / (1.0 - (2.0 * lightness - 1.0).abs())).clamp(0.0, 1.0));
    color = Color.fromRGBO(red, green, blue, 0).withOpacity(opacity);
    hsl = hsl ?? toHSL();
    rgb = "$alpha$red$green$blue";
    //HSLColor.fromColor(color)
  }
  factory CustomColor.fromColor(Color color) {
    return CustomColor(
      name: color.toString(),
      hex: color.toHex(),
    );
  }
  factory CustomColor.fromDefault() {
    String colorName = "Default";
    final color = CustomColorSingleList.instance.getByName(colorName);
    if (color != null) return color;
    return CustomColor.fromColor(Colors.transparent);
  }
  factory CustomColor.fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    //return Color(int.parse(buffer.toString(), radix: 16));

    return CustomColor.isHexadecimal(hexString)
        ? CustomColor(name: hexString, hex: hexString)
        : CustomColor.fromDefault();
  }
  factory CustomColor.fromJson(Map<String, dynamic> json) {
    var color = CustomColorSingleList.instance.getByName(json["name"]);
    if (color != null) return color;
    String colorName = EntityModel.getValueFromJson("name", json, "Default");
    if (colorName.startsWith("0x") && CustomColor.isHexadecimal(colorName)) {
      color = CustomColor.fromColor(Color(int.parse(colorName)));
      colorName = colorName.replaceFirst("0x", "#");
    }
    final hexCodeRegex = RegExp(r'^#?([0-9a-fA-F]{6})$');
    if (!hexCodeRegex.hasMatch(colorName) ||
        !CustomColor.isHexadecimal(colorName)) {
      //throw ArgumentError('El formato del color hexadecimal no es válido');
      color = CustomColor.fromColor(Colors.transparent);
    }
    return CustomColor(
      name: colorName,
      hex: EntityModel.getValueFromJson("hex", json, "#FFFFFF"),
      rgb: EntityModel.getValueFromJson("rgb", json, "255,255,255"),
      hsl: EntityModel.getValueFromJson("hsl", json, null),
      opacity: EntityModel.getValueFromJson("opacity", json, 0.0),
      alpha: EntityModel.getValueFromJson("alpha", json, 0),
      red: EntityModel.getValueFromJson("red", json, 0),
      green: EntityModel.getValueFromJson("green", json, 0),
      blue: EntityModel.getValueFromJson("blue", json, 0),
      delta: EntityModel.getValueFromJson("delta", json, 0),
      hue: EntityModel.getValueFromJson("hue", json, 0.0),
      lightness: EntityModel.getValueFromJson("lightness", json, 0.0),
      saturation: EntityModel.getValueFromJson("saturation", json, 0.0),
      maxValue: EntityModel.getValueFromJson("maxValue", json, 0),
      minValue: EntityModel.getValueFromJson("minValue", json, 0),
    );
  }

  factory CustomColor.fromString(String colorName) {
    final color = CustomColorSingleList.instance.getByName(colorName);
    if (color != null) return color;
    if (colorName.startsWith("0x") && CustomColor.isHexadecimal(colorName)) {
      return CustomColor.fromColor(Color(int.parse(colorName)));
    }
    final hexCodeRegex = RegExp(r'^#?([0-9a-fA-F]{6})$');
    if (!hexCodeRegex.hasMatch(colorName) ||
        !CustomColor.isHexadecimal(colorName)) {
      //throw ArgumentError('El formato del color hexadecimal no es válido');
      return CustomColor.fromColor(Colors.transparent);
    }
    return CustomColor(
      name: colorName,
      hex: colorName,
    );
  }
  Color get getColor => color;

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  String toHSL() {
    double red = color.red / 255.0;
    double green = color.green / 255.0;
    double blue = color.blue / 255.0;

    double maxRGB = math.max(math.max(red, green), blue);
    double minRGB = math.min(math.min(red, green), blue);
    double luminosity = (maxRGB + minRGB) / 2.0;

    double saturation = 0.0;
    if (luminosity > 0.0 && luminosity < 1.0) {
      saturation = (maxRGB - minRGB) /
          (luminosity < 0.5 ? (2.0 * luminosity) : (2.0 - 2.0 * luminosity));
    }

    double hue = 0.0;
    if (maxRGB == minRGB) {
      hue = 0.0;
    } else if (maxRGB == red && green >= blue) {
      hue = 60.0 * ((green - blue) / (maxRGB - minRGB));
    } else if (maxRGB == red && green < blue) {
      hue = 60.0 * ((green - blue) / (maxRGB - minRGB)) + 360.0;
    } else if (maxRGB == green) {
      hue = 60.0 * ((blue - red) / (maxRGB - minRGB)) + 120.0;
    } else if (maxRGB == blue) {
      hue = 60.0 * ((red - green) / (maxRGB - minRGB)) + 240.0;
    }

    hue %= 360;

    return hsl = '$hue, $saturation, $luminosity';
  }

  String toHsl() => "Color.toHsl(color)";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "name": name,
      "hex": hex.isEmpty ? toHex() : hex,
      "rgb": rgb ?? toRgb(),
      "hsl": hsl ?? toHSL(),
      "opacity": opacity,
      "alpha": alpha,
      "red": color.red,
      "green": color.green,
      "blue": color.blue,
      "delta": delta,
      "hue": hue,
      "lightness": lightness,
      "saturation": saturation,
      "maxValue": maxValue,
      "minValue": minValue,
    };

    data.removeWhere((key, value) =>
        value == null || (value != null && value!.toString().isEmpty));
    return data;
  }

  String toRgb() => List.from([
        color.red,
        color.green,
        color.blue,
      ]).toString();

  double _getHue(
      double red, double green, double blue, double max, double delta) {
    late double hue;
    if (max == 0.0) {
      hue = 0.0;
    } else if (max == red) {
      hue = 60.0 * (((green - blue) / delta) % 6);
    } else if (max == green) {
      hue = 60.0 * (((blue - red) / delta) + 2);
    } else if (max == blue) {
      hue = 60.0 * (((red - green) / delta) + 4);
    }

    /// Set hue to 0.0 when red == green == blue.
    hue = hue.isNaN ? 0.0 : hue;
    return hue;
  }

  static Map<int, CustomColor> getSwatch(CustomColor color) {
    Map<int, CustomColor> swatch = {};
    List<int>.from([50, 100, 200, 300, 400, 500, 600, 700, 800, 900]).map((e) {
      double opacity = e / 1000;
      swatch.addEntries(
          [MapEntry(e, CustomColor.fromColor(color.withOpacity(opacity)))]);
      return e;
    }).toList();
    return swatch;
  }

  static bool isHexadecimal(String str) => int.tryParse(str, radix: 16) != null;
}

class CustomColorList<T extends CustomColor> implements EntityModelList<T> {
  final List<T> colors;

  CustomColorList({
    required this.colors,
  });

  factory CustomColorList.fromJson(Map<String, dynamic> json) =>
      CustomColorList(
        colors: json.containsKey("colors")
            ? List<T>.from(json["colors"].map((x) => CustomColor.fromJson(x)))
            : [],
      );

  factory CustomColorList.fromStringJson(String strJson) =>
      CustomColorList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return CustomColorList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!colors.contains(element)) colors.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return CustomColorList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => colors;

  Map<String, dynamic> toJson() => {
        "colors": List<dynamic>.from(colors.map((x) => x.toJson())),
      };
}

class CustomColorSingleList {
  static final CustomColorSingleList instance =
      !Get.isRegistered() ? CustomColorSingleList._internal([]) : Get.find();
  final List<CustomColor> _colors;

  factory CustomColorSingleList({required colors}) => instance;
  CustomColorSingleList._internal(this._colors) {
    Get.lazyPut(() => this);
  }
  List<CustomColor> get getColors => _colors;

  bool add(CustomColor color) {
    if (getByName(color.name) == null) {
      _colors.add(color);
      return true;
    }
    return false;
  }

  Map<String, CustomColor> asMap() {
    Map<String, CustomColor> map = {};
    _colors.map((e) {
      return map.addEntries([MapEntry(e.name, e)]);
    });
    return map;
  }

  bool exists(CustomColor color) {
    return _colors.contains(color);
  }

  CustomColor? getByName(String name) {
    CustomColor? color;

    if (_colors.isEmpty) return null;
    for (var element in _colors) {
      if (element.name == name) {
        color = element;
        break;
      }
    }
    return color;
  }
}

extension HexColor on Color {
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
