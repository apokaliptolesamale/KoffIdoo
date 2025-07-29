import 'package:flutter/foundation.dart' show describeEnum;
import 'package:flutter/material.dart';

enum BrightnessExtension { light, dark }

extension BrightnessExtensionMethods on BrightnessExtension {
  static const Map<BrightnessExtension, Brightness> _brightnessMap = {
    BrightnessExtension.light: Brightness.light,
    BrightnessExtension.dark: Brightness.dark,
  };

  static const Map<Brightness, BrightnessExtension> _brightnessExtensionMap = {
    Brightness.light: BrightnessExtension.light,
    Brightness.dark: BrightnessExtension.dark,
  };

  static BrightnessExtension get dark => BrightnessExtension.dark;

  //
  static BrightnessExtension get light => BrightnessExtension.light;

  String get name => describeEnum(this);

  Brightness toBrightness() {
    return _brightnessMap[this]!;
  }

  static BrightnessExtension fromBrightness(Brightness brightness) {
    return _brightnessExtensionMap[brightness]!;
  }

  static Brightness fromBrightnessExtension(BrightnessExtension brightness) {
    return brightness.toBrightness();
  }

  static BrightnessExtension? fromString(String? brightnessString) {
    if (brightnessString == null) {
      return null;
    }

    brightnessString = brightnessString.toLowerCase();

    if (brightnessString == 'light') {
      return BrightnessExtension.light;
    } else if (brightnessString == 'dark') {
      return BrightnessExtension.dark;
    } else {
      return null;
    }
  }

  static Brightness getBrightness(String? brightnessString) {
    if (brightnessString == null) {
      return Brightness.light;
    }

    brightnessString = brightnessString.toLowerCase();

    if (brightnessString == 'light') {
      return BrightnessExtension.light.toBrightness();
    } else if (brightnessString == 'dark') {
      return BrightnessExtension.dark.toBrightness();
    } else {
      return Brightness.light;
    }
  }

  static String? toStringValue(BrightnessExtension? brightness) {
    return brightness?.name;
  }
}
