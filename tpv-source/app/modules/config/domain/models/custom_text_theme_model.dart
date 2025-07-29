// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member, must_be_immutable
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xml/xml.dart';

import '/app/core/helpers/functions.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/custom_texttheme.dart';
import 'custom_text_style_model.dart';

CustomTextThemeList custom_textthemeListModelFromJson(String str) =>
    CustomTextThemeList.fromJson(json.decode(str));

CustomTextThemeModel custom_textthemeModelFromJson(String str) =>
    CustomTextThemeModel.fromJson(json.decode(str));

String custom_textthemeModelToJson(CustomTextThemeModel data) =>
    json.encode(data.toJson());

class CustomTextThemeList<T extends CustomTextThemeModel>
    implements EntityModelList<T> {
  final List<T> textThemes;

  CustomTextThemeList({
    this.textThemes = const [],
  });

  factory CustomTextThemeList.fromEmpty() => CustomTextThemeList(
        textThemes:
            List<T>.from([].map((x) => CustomTextThemeList.fromJson(x))),
      );

  factory CustomTextThemeList.fromJson(Map<String, dynamic> json) =>
      CustomTextThemeList(
        textThemes: List<T>.from(
            json["textThemes"].map((x) => CustomTextThemeModel.fromJson(x))),
      );

  factory CustomTextThemeList.fromStringJson(String strJson) =>
      CustomTextThemeList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return CustomTextThemeList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!textThemes.contains(element)) textThemes.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return CustomTextThemeList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => textThemes;

  Map<String, dynamic> toJson() => {
        "textThemes": List<dynamic>.from(textThemes.map((x) => x.toJson())),
      };

  static Future<T> fromXmlServiceUrl<T>(
      String url,
      String parentTagName,
      Future<T> Function(XmlDocument doc, XmlElement el) process,
      Future<T> Function() onError) async {
    return EntityModelList.fromXmlServiceUrl(
        url, parentTagName, process, onError);
  }

  static Future<T> getJsonFromXMLUrl<T>(
      String url,
      Future<T> Function(XmlDocument result) process,
      Future<T> Function() onError) async {
    return EntityModelList.getJsonFromXMLUrl(url, process, onError);
  }
}

@JsonSerializable()
class CustomTextThemeModel extends CustomTextTheme implements EntityModel {
  //
  @override
  String themeName;

  @override
  String? themeId;

  @override
  CustomTextStyleModel? headlineLarge;

  @override
  CustomTextStyleModel? labelMedium;
  @override
  CustomTextStyleModel? displayLarge;
  @override
  CustomTextStyleModel? displayMedium;

  @override
  CustomTextStyleModel? displaySmall;
  @override
  CustomTextStyleModel? headlineMedium;
  @override
  CustomTextStyleModel? headlineSmall;
  @override
  CustomTextStyleModel? titleLarge;
  @override
  CustomTextStyleModel? titleMedium;
  @override
  CustomTextStyleModel? titleSmall;
  @override
  CustomTextStyleModel? bodyLarge;
  @override
  CustomTextStyleModel? bodyMedium;
  @override
  CustomTextStyleModel? bodySmall;
  @override
  CustomTextStyleModel? labelLarge;
  @override
  CustomTextStyleModel? labelSmall;
  @override
  Map<String, ColumnMetaModel>? metaModel;
  //
  CustomTextThemeModel({
    required this.themeName,
    required this.themeId,
    this.headlineLarge,
    this.displayLarge,
    this.displayMedium,
    this.displaySmall,
    this.headlineMedium,
    this.headlineSmall,
    this.titleLarge,
    this.titleMedium,
    this.titleSmall,
    this.bodyLarge,
    this.bodyMedium,
    this.bodySmall,
    this.labelLarge,
    this.labelMedium,
    this.labelSmall,
  }) : super(
          themeId: themeId,
          themeName: themeName,
          displayLarge: displayLarge,
          displayMedium: displayMedium,
          displaySmall: displaySmall,
          headlineLarge: headlineLarge,
          headlineMedium: headlineMedium,
          headlineSmall: headlineSmall,
          titleLarge: titleLarge,
          titleMedium: titleMedium,
          titleSmall: titleSmall,
          bodyLarge: bodyLarge,
          bodyMedium: bodyMedium,
          bodySmall: bodySmall,
          labelLarge: labelLarge,
          labelMedium: labelMedium,
          labelSmall: labelSmall,
        );

  factory CustomTextThemeModel.fromDefault() {
    final def = CustomTextThemeModel(
      themeId: "",
      themeName: "Default",
      displayLarge: CustomTextStyleSingleList.from("displayLarge"),
      displayMedium: CustomTextStyleSingleList.from("displayMedium"),
      displaySmall: CustomTextStyleSingleList.from("displaySmall"),
      headlineLarge: CustomTextStyleSingleList.from("headlineLarge"),
      headlineMedium: CustomTextStyleSingleList.from("headlineMedium"),
      headlineSmall: CustomTextStyleSingleList.from("headlineSmall"),
      titleLarge: CustomTextStyleSingleList.from("titleLarge"),
      titleMedium: CustomTextStyleSingleList.from("titleMedium"),
      titleSmall: CustomTextStyleSingleList.from("titleSmall"),
      bodyLarge: CustomTextStyleSingleList.from("bodyLarge"),
      bodyMedium: CustomTextStyleSingleList.from("bodyMedium"),
      bodySmall: CustomTextStyleSingleList.from("bodySmall"),
      labelLarge: CustomTextStyleSingleList.from("labelLarge"),
      labelMedium: CustomTextStyleSingleList.from("labelMedium"),
      labelSmall: CustomTextStyleSingleList.from("labelSmall"),
    );
    return def;
  }

  factory CustomTextThemeModel.fromJson(Map<String, dynamic> json) {
    final theme = CustomTextThemeModel(
      themeId: getValueFrom(
        "themeId",
        json,
        "default",
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is String) {
            return data[key];
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      themeName: getValueFrom(
        "themeName",
        json,
        "Default",
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is String) {
            return data[key];
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      displayLarge: getValueFrom(
        "displayLarge",
        json,
        CustomTextStyleSingleList.from("displayLarge"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextStyleModel.fromJson(data[key]);
          } else if (data is Map &&
              data.containsKey(key) &&
              data[key] is String) {
            return CustomTextStyleModel.fromString(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      displayMedium: getValueFrom(
        "displayMedium",
        json,
        CustomTextStyleSingleList.from("displayMedium"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextStyleModel.fromJson(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      displaySmall: getValueFrom(
        "displaySmall",
        json,
        CustomTextStyleSingleList.from("displaySmall"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextStyleModel.fromJson(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      headlineLarge: getValueFrom(
        "headlineLarge",
        json,
        CustomTextStyleSingleList.from("headlineLarge"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextStyleModel.fromJson(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      headlineMedium: getValueFrom(
        "headlineMedium",
        json,
        CustomTextStyleSingleList.from("headlineMedium"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextStyleModel.fromJson(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      headlineSmall: getValueFrom(
        "headlineSmall",
        json,
        CustomTextStyleSingleList.from("headlineSmall"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextStyleModel.fromJson(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      titleLarge: getValueFrom(
        "titleLarge",
        json,
        CustomTextStyleSingleList.from("titleLarge"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextStyleModel.fromJson(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      titleMedium: getValueFrom(
        "titleMedium",
        json,
        CustomTextStyleSingleList.from("titleMedium"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextStyleModel.fromJson(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      titleSmall: getValueFrom(
        "titleSmall",
        json,
        CustomTextStyleSingleList.from("titleSmall"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextStyleModel.fromJson(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      bodyLarge: getValueFrom(
        "bodyLarge",
        json,
        CustomTextStyleSingleList.from("bodyLarge"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextStyleModel.fromJson(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      bodyMedium: getValueFrom(
        "bodyMedium",
        json,
        CustomTextStyleSingleList.from("bodyMedium"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextStyleModel.fromJson(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      bodySmall: getValueFrom(
        "bodySmall",
        json,
        CustomTextStyleSingleList.from("bodySmall"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextStyleModel.fromJson(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      labelLarge: getValueFrom(
        "labelLarge",
        json,
        CustomTextStyleSingleList.from("labelLarge"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextStyleModel.fromJson(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      labelMedium: getValueFrom(
        "labelMedium",
        json,
        CustomTextStyleSingleList.from("labelMedium"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextStyleModel.fromJson(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      labelSmall: getValueFrom(
        "labelSmall",
        json,
        CustomTextStyleSingleList.from("labelSmall"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextStyleModel.fromJson(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
    );
    return theme;
  }

  //
  factory CustomTextThemeModel.fromString(String themeName) {
    final theme = CustomTextThemeSingleList.instance.getByName(themeName);
    return theme ?? CustomTextThemeModel.fromDefault();
  }
  factory CustomTextThemeModel.fromXml(XmlElement element,
          CustomTextThemeModel Function(XmlElement el) process) =>
      process(element);

  @override
  Map<String, ColumnMetaModel>? get getMetaModel => getColumnMetaModel();

  List<Object?> get props => [];

  @override
  set setMetaModel(Map<String, ColumnMetaModel> newMetaModel) {
    metaModel = newMetaModel;
  }

  bool? get stringify => true;

  //method generated by wizard
  @override
  T cloneWith<T extends EntityModel>(T other) {
    return CustomTextThemeModel.fromJson(other.toJson()) as T;
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return CustomTextThemeList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return CustomTextThemeList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return CustomTextThemeList.fromJson({});
  }

  @override
  T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
    return CustomTextThemeModel.fromJson(params) as T;
  }

  @override
  Map<String, ColumnMetaModel> getColumnMetaModel() {
    ////Map<String, String> colNames = getColumnNames();
    metaModel = metaModel ??
        {
          //TODO Declare here all ColumnMetaModel. you can use class implementation of class "DefaultColumnMetaModel".
        };
    int index = 0;
    metaModel!.forEach((key, value) {
      value.setColumnIndex(index++);
    });
    return metaModel!;
  }

  @override
  Map<String, String> getColumnNames() {
    return {"id_custom_texttheme": "ID"};
  }

  @override
  List<String> getColumnNamesList() {
    return getColumnNames().values.toList();
  }

  StreamController<EntityModel> getController({
    void Function()? onListen,
    void Function()? onPause,
    void Function()? onResume,
    FutureOr<void> Function()? onCancel,
  }) {
    return EntityModel.getController(
        entity: this,
        onListen: onListen,
        onPause: onPause,
        onResume: onResume,
        onCancel: onCancel);
  }

  @override
  Map<K1, V1> getMeta<K1, V1>(String searchKey, dynamic searchValue) {
    final Map<K1, V1> result = {};
    getColumnMetaModel().map<K1, V1>((key, value) {
      MapEntry<K1, V1> el = MapEntry(value.getDataIndex() as K1, value as V1);
      if (value[searchKey] == searchValue) {
        result.putIfAbsent(value.getDataIndex() as K1, () {
          return value as V1;
        });
      }
      return el;
    });
    return result;
  }

  @override
  Map<String, String> getVisibleColumnNames() {
    Map<String, String> names = {};
    getMeta<String, ColumnMetaModel>("visible", true)
        .map<String, String>((key, value) {
      names.putIfAbsent(key, () => value.getColumnName());
      return MapEntry(key, value.getColumnName());
    });
    return names;
    // throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    log("CustomTextThemeModel to Json...");
    final Map<String, dynamic> data = {
      "themeId": themeId,
      "themeName": themeName,
      "displayLarge": displayLarge != null ? displayLarge!.toJson() : null,
      "displayMedium": displayMedium != null ? displayMedium!.toJson() : null,
      "displaySmall": displaySmall != null ? displaySmall!.toJson() : null,
      "headlineLarge": headlineLarge != null ? headlineLarge!.toJson() : null,
      "headlineMedium":
          headlineMedium != null ? headlineMedium!.toJson() : null,
      "headlineSmall": headlineSmall != null ? headlineSmall!.toJson() : null,
      "titleLarge": titleLarge != null ? titleLarge!.toJson() : null,
      "titleMedium": titleMedium != null ? titleMedium!.toJson() : null,
      "titleSmall": titleSmall != null ? titleSmall!.toJson() : null,
      "bodyLarge": bodyLarge != null ? bodyLarge!.toJson() : null,
      "bodyMedium": bodyMedium != null ? bodyMedium!.toJson() : null,
      "bodySmall": bodySmall != null ? bodySmall!.toJson() : null,
      "labelLarge": labelLarge != null ? labelLarge!.toJson() : null,
      "labelMedium": labelMedium != null ? labelMedium!.toJson() : null,
      "labelSmall": labelSmall != null ? labelSmall!.toJson() : null,
    };
    data.removeWhere((key, value) =>
        value == null || (value != null && value!.toString().isEmpty));
    return entityToJson(data);
  }

  @override
  Map<String, ColumnMetaModel> updateColumnMetaModel(
      String keySearch, dynamic valueSearch, dynamic newValue) {
    Map<String, ColumnMetaModel> tmp = getColumnMetaModel();
    getMeta<String, ColumnMetaModel>(keySearch, valueSearch)
        .map<String, ColumnMetaModel>((key, value) {
      tmp.putIfAbsent(key, () => value);
      return MapEntry(key, value);
    });
    return metaModel = tmp;
  }

  @override
  static T getValueFrom<T>(
    String key,
    dynamic json,
    T defaultValue, {
    JsonReader<T>? reader,
    Caster<T>? cast,
  }) {
    return EntityModel.getValueFromJson<T>(key, json, defaultValue,
        reader: reader, cast: cast);
  }
}

class CustomTextThemeSingleList {
  //
  static final CustomTextThemeSingleList instance = !Get.isRegistered()
      ? CustomTextThemeSingleList._internal([])
      : Get.find();
  final List<CustomTextThemeModel> _themes;

  factory CustomTextThemeSingleList({required themes}) => instance;
  //
  CustomTextThemeSingleList._internal(this._themes) {
    Get.lazyPut(() => this);
  }
  List<TextTheme> get getThemes => _themes;

  bool add(CustomTextThemeModel theme) {
    //final tmp = getByName(theme.themeName);
    if (getByName(theme.themeName) == null) {
      _themes.add(theme);
      return true;
    }
    return false;
  }

  Map<String, TextTheme> asMap() {
    Map<String, TextTheme> map = {};
    _themes.map((e) {
      return map.addEntries([MapEntry(e.themeName, e)]);
    });
    return map;
  }

  bool exists(TextTheme theme) {
    return _themes.contains(theme);
  }

  CustomTextThemeModel? getByName(String name) {
    CustomTextThemeModel? theme;

    if (_themes.isEmpty) return null;
    for (var element in _themes) {
      if (element.themeName == name) {
        theme = element;
        break;
      }
    }
    return theme ?? CustomTextThemeModel.fromDefault();
  }

  static CustomTextThemeModel from(String name) =>
      CustomTextThemeSingleList.instance.getByName(name) ??
      CustomTextThemeModel.fromDefault();
}
