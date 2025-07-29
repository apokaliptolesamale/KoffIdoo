import 'dart:convert';

import 'package:flutter/material.dart';

import '/app/core/interfaces/entity_model.dart';
import '/app/core/services/logger_service.dart';
import 'brightness_extension.dart';
import 'color.dart';

class ColorSchemeExtension extends ColorScheme {
  final BrightnessExtension? brightnessExtension;

  ColorSchemeExtension({
    required CustomColor primary,
    required CustomColor primaryVariant,
    required CustomColor secondary,
    required CustomColor secondaryVariant,
    required CustomColor surface,
    required CustomColor background,
    required CustomColor error,
    required CustomColor onPrimary,
    required CustomColor onSecondary,
    required CustomColor onSurface,
    required CustomColor onBackground,
    required CustomColor onError,
    this.brightnessExtension,
  }) : super(
          primary: primary,
          secondary: secondary,
          surface: surface,
          background: background,
          error: error,
          onPrimary: onPrimary,
          onSecondary: onSecondary,
          onSurface: onSurface,
          onBackground: onBackground,
          onError: onError,
          brightness: brightnessExtension?.toBrightness() ?? Brightness.light,
        );
  factory ColorSchemeExtension.fromDefault() {
    return ColorSchemeExtension(
      primary: CustomColor.fromDefault(),
      primaryVariant: CustomColor.fromDefault(),
      secondary: CustomColor.fromDefault(),
      secondaryVariant: CustomColor.fromDefault(),
      surface: CustomColor.fromDefault(),
      background: CustomColor.fromDefault(),
      error: CustomColor.fromDefault(),
      onPrimary: CustomColor.fromDefault(),
      onSecondary: CustomColor.fromDefault(),
      onSurface: CustomColor.fromDefault(),
      onBackground: CustomColor.fromDefault(),
      onError: CustomColor.fromDefault(),
    );
  }
  factory ColorSchemeExtension.fromJson(Map<String, dynamic> json) {
    return ColorSchemeExtension(
      primary: EntityModel.getValueFrom<CustomColor>(
        "primary",
        json,
        CustomColor.fromString("primary"),
        reader: (key, data, defaultValue) {
          if (data.containsKey(key) && data[key] is Map) {
            return CustomColor.fromJson(data[key]);
          } else if (data.containsKey(key) && data[key] is String) {
            return CustomColor.fromString(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      primaryVariant: EntityModel.getValueFrom(
        "primaryVariant",
        json,
        CustomColor.fromString("primaryVariant"),
        reader: (key, data, defaultValue) {
          if (data.containsKey(key) && data[key] is Map) {
            return CustomColor.fromJson(data[key]);
          } else if (data.containsKey(key) && data[key] is String) {
            return CustomColor.fromString(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      secondary: EntityModel.getValueFrom(
        "secondary",
        json,
        CustomColor.fromString("secondary"),
        reader: (key, data, defaultValue) {
          if (data.containsKey(key) && data[key] is Map) {
            return CustomColor.fromJson(data[key]);
          } else if (data.containsKey(key) && data[key] is String) {
            return CustomColor.fromString(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      secondaryVariant: EntityModel.getValueFrom(
        "secondaryVariant",
        json,
        CustomColor.fromString("secondaryVariant"),
        reader: (key, data, defaultValue) {
          if (data.containsKey(key) && data[key] is Map) {
            return CustomColor.fromJson(data[key]);
          } else if (data.containsKey(key) && data[key] is String) {
            return CustomColor.fromString(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      surface: EntityModel.getValueFrom(
        "surface",
        json,
        CustomColor.fromString("surface"),
        reader: (key, data, defaultValue) {
          if (data.containsKey(key) && data[key] is Map) {
            return CustomColor.fromJson(data[key]);
          } else if (data.containsKey(key) && data[key] is String) {
            return CustomColor.fromString(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      background: EntityModel.getValueFrom(
        "background",
        json,
        CustomColor.fromString("background"),
        reader: (key, data, defaultValue) {
          if (data.containsKey(key) && data[key] is Map) {
            return CustomColor.fromJson(data[key]);
          } else if (data.containsKey(key) && data[key] is String) {
            return CustomColor.fromString(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      error: EntityModel.getValueFrom(
        "error",
        json,
        CustomColor.fromString("error"),
        reader: (key, data, defaultValue) {
          if (data.containsKey(key) && data[key] is Map) {
            return CustomColor.fromJson(data[key]);
          } else if (data.containsKey(key) && data[key] is String) {
            return CustomColor.fromString(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      onPrimary: EntityModel.getValueFrom(
        "onPrimary",
        json,
        CustomColor.fromString("onPrimary"),
        reader: (key, data, defaultValue) {
          if (data.containsKey(key) && data[key] is Map) {
            return CustomColor.fromJson(data[key]);
          } else if (data.containsKey(key) && data[key] is String) {
            return CustomColor.fromString(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      onSecondary: EntityModel.getValueFrom(
        "onSecondary",
        json,
        CustomColor.fromString("onSecondary"),
        reader: (key, data, defaultValue) {
          if (data.containsKey(key) && data[key] is Map) {
            return CustomColor.fromJson(data[key]);
          } else if (data.containsKey(key) && data[key] is String) {
            return CustomColor.fromString(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      onSurface: EntityModel.getValueFrom(
        "onSurface",
        json,
        CustomColor.fromString("onSurface"),
        reader: (key, data, defaultValue) {
          if (data.containsKey(key) && data[key] is Map) {
            return CustomColor.fromJson(data[key]);
          } else if (data.containsKey(key) && data[key] is String) {
            return CustomColor.fromString(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      onBackground: EntityModel.getValueFrom(
        "onBackground",
        json,
        CustomColor.fromString("onBackground"),
        reader: (key, data, defaultValue) {
          if (data.containsKey(key) && data[key] is Map) {
            return CustomColor.fromJson(data[key]);
          } else if (data.containsKey(key) && data[key] is String) {
            return CustomColor.fromString(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      onError: EntityModel.getValueFrom(
        "onError",
        json,
        CustomColor.fromString("onError"),
        reader: (key, data, defaultValue) {
          if (data.containsKey(key) && data[key] is Map) {
            return CustomColor.fromJson(data[key]);
          } else if (data.containsKey(key) && data[key] is String) {
            return CustomColor.fromString(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      brightnessExtension: EntityModel.getValueFrom(
        "brightness",
        json,
        BrightnessExtensionMethods.light,
        reader: (key, data, defaultValue) {
          if (data.containsKey(key) && data[key] is String) {
            return BrightnessExtensionMethods.fromString(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
    );
  }

  factory ColorSchemeExtension.fromString(String str) =>
      ColorSchemeExtension.fromJson(json.decode(str));

  String get brightnessName => brightnessExtension?.name ?? 'unknown';

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'primary': (primary as CustomColor).toJson(),
      'primaryVariant': (primaryContainer as CustomColor).toJson(),
      'secondary': (secondary as CustomColor).toJson(),
      'secondaryVariant': (secondaryContainer as CustomColor).toJson(),
      'surface': (surface as CustomColor).toJson(),
      'background': (background as CustomColor).toJson(),
      'error': (error as CustomColor).toJson(),
      'onPrimary': (onPrimary as CustomColor).toJson(),
      'onSecondary': (onSecondary as CustomColor).toJson(),
      'onSurface': (onSurface as CustomColor).toJson(),
      'onBackground': (onBackground as CustomColor).toJson(),
      'onError': (onError as CustomColor).toJson(),
      'brightnessExtension': brightnessExtension?.name,
    };
  }
}
