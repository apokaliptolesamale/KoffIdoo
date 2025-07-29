// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member, must_be_immutable
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart' as fun;
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xml/xml.dart';

import '/app/core/helpers/functions.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/custom_typography.dart';
import 'custom_text_theme_model.dart';

CustomTypographyList custom_typographyListModelFromJson(String str) =>
    CustomTypographyList.fromJson(json.decode(str));

CustomTypographyModel custom_typographyModelFromJson(String str) =>
    CustomTypographyModel.fromJson(json.decode(str));

String custom_typographyModelToJson(CustomTypographyModel data) =>
    json.encode(data.toJson());

class CustomTypographyList<T extends CustomTypographyModel>
    implements EntityModelList<T> {
  final List<T> custom_typographys;

  CustomTypographyList({
    this.custom_typographys = const [],
  });

  factory CustomTypographyList.fromEmpty() => CustomTypographyList(
        custom_typographys:
            List<T>.from([].map((x) => CustomTypographyList.fromJson(x))),
      );

  factory CustomTypographyList.fromJson(Map<String, dynamic> json) =>
      CustomTypographyList(
        custom_typographys: List<T>.from(json["custom_typographys"]
            .map((x) => CustomTypographyModel.fromJson(x))),
      );

  factory CustomTypographyList.fromStringJson(String strJson) =>
      CustomTypographyList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return CustomTypographyList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!custom_typographys.contains(element)) {
        custom_typographys.add(element);
      }
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return CustomTypographyList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => custom_typographys;

  Map<String, dynamic> toJson() => {
        "custom_typographys":
            List<dynamic>.from(custom_typographys.map((x) => x.toJson())),
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
class CustomTypographyModel extends CustomTypography implements EntityModel {
  static final Map<String, Typography> _typographies = Map.from({});

  static Map<String, Typography> get getTypographies => _typographies;

  //
  @override
  Map<String, ColumnMetaModel>? metaModel;

  late final String name;

  factory CustomTypographyModel({
    String name,
    fun.TargetPlatform? platform,
    TextTheme? black,
    TextTheme? white,
    TextTheme? englishLike,
    TextTheme? dense,
    TextTheme? tall,
  }) = CustomTypographyModel.material2018;

  factory CustomTypographyModel.fromJson(Map<String, dynamic> json) =>
      CustomTypographyModel(
        name: getValueFrom("name", json, "Default"),
        black: getValueFrom("black", json, null),
        dense: getValueFrom("dense", json, null),
        englishLike: getValueFrom("englishLike", json, null),
        platform: getValueFrom("platform", json, null),
        tall: getValueFrom("tall", json, null),
        white: getValueFrom("white", json, null),
      );

  factory CustomTypographyModel.fromXml(XmlElement element,
          CustomTypographyModel Function(XmlElement el) process) =>
      process(element);

  factory CustomTypographyModel.material2018({
    String name = "Default",
    TargetPlatform? platform = TargetPlatform.android,
    TextTheme? black,
    TextTheme? white,
    TextTheme? englishLike,
    TextTheme? dense,
    TextTheme? tall,
  }) {
    assert(platform != null || (black != null && white != null));
    return CustomTypographyModel._withPlatform(
      name,
      platform,
      black,
      white,
      englishLike ?? Typography.englishLike2018,
      dense ?? Typography.dense2018,
      tall ?? Typography.tall2018,
    );
  }

  factory CustomTypographyModel._withPlatform(
    String name,
    TargetPlatform? platform,
    TextTheme? black,
    TextTheme? white,
    TextTheme englishLike,
    TextTheme dense,
    TextTheme tall,
  ) {
    assert(platform != null || (black != null && white != null));
    switch (platform) {
      case TargetPlatform.iOS:
        black ??= Typography.blackCupertino;
        white ??= Typography.whiteCupertino;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        black ??= Typography.blackMountainView;
        white ??= Typography.whiteMountainView;
        break;
      case TargetPlatform.windows:
        black ??= Typography.blackRedmond;
        white ??= Typography.whiteRedmond;
        break;
      case TargetPlatform.macOS:
        black ??= Typography.blackRedwoodCity;
        white ??= Typography.whiteRedwoodCity;
        break;
      case TargetPlatform.linux:
        black ??= Typography.blackHelsinki;
        white ??= Typography.whiteHelsinki;
        break;
      case null:
        break;
    }
    if (getTypographies.containsKey(name)) {
      return _typographies[name]! as CustomTypographyModel;
    }

    _typographies[name] = Typography(
      black: black,
      dense: dense,
      englishLike: englishLike,
      platform: platform,
      tall: tall,
      white: white,
    );
    return _typographies[name] as CustomTypographyModel;
  }

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
    return CustomTypographyModel.fromJson(other.toJson()) as T;
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return CustomTypographyList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return CustomTypographyList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return CustomTypographyList.fromJson({});
  }

  @override
  T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
    return CustomTypographyModel.fromJson(params) as T;
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
    return {"id_custom_typography": "ID"};
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
      onCancel: onCancel,
    );
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
  Map<String, dynamic> toJson() => entityToJson({
        "black": black,
        "dense": dense,
        "englishLike": englishLike,
        "platform": TargetPlatform.values.byName("android"),
        "tall": tall,
        "white": white,
      });

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

  static Typography createTypography({
    String name = "Default",
    fun.TargetPlatform? platform,
    TextTheme? black,
    TextTheme? white,
    TextTheme? englishLike,
    TextTheme? dense,
    TextTheme? tall,
  }) {
    return Typography(
      black: black,
      dense: dense,
      englishLike: englishLike,
      platform: platform ?? getTargetPlatform(),
      tall: tall,
      white: white,
    );
  }

  static Typography createTypographyFromJson(Map<String, dynamic> json) {
    final type = Typography(
      platform: getValueFrom(
        "platform",
        json,
        getTargetPlatform(),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is String) {
            return TargetPlatform.values.byName(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      black: getValueFrom(
        "black",
        json,
        CustomTextThemeSingleList.from("black"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextThemeModel.fromJson(data[key]);
          } else if (data is Map &&
              data.containsKey(key) &&
              data[key] is String) {
            return CustomTextThemeModel.fromString(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      dense: getValueFrom(
        "dense",
        json,
        CustomTextThemeSingleList.from("dense"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextThemeModel.fromJson(data[key]);
          } else if (data is Map &&
              data.containsKey(key) &&
              data[key] is String) {
            return CustomTextThemeModel.fromString(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      englishLike: getValueFrom(
        "englishLike",
        json,
        CustomTextThemeSingleList.from("englishLike"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextThemeModel.fromJson(data[key]);
          } else if (data is Map &&
              data.containsKey(key) &&
              data[key] is String) {
            return CustomTextThemeModel.fromString(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      tall: getValueFrom(
        "tall",
        json,
        CustomTextThemeSingleList.from("tall"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextThemeModel.fromJson(data[key]);
          } else if (data is Map &&
              data.containsKey(key) &&
              data[key] is String) {
            return CustomTextThemeModel.fromString(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
      white: getValueFrom(
        "white",
        json,
        CustomTextThemeSingleList.from("white"),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key) && data[key] is Map) {
            return CustomTextThemeModel.fromJson(data[key]);
          } else if (data is Map &&
              data.containsKey(key) &&
              data[key] is String) {
            return CustomTextThemeModel.fromString(data[key]);
          }
          return defaultValue;
        },
        cast: (value) => value,
      ),
    );

    return type;
  }

  static Typography fromDefault() {
    return CustomTypographyModel(
      platform: getTargetPlatform(),
      black: CustomTextThemeSingleList.from("black"),
      dense: CustomTextThemeSingleList.from("dense"),
      englishLike: CustomTextThemeSingleList.from("englishLike"),
      tall: CustomTextThemeSingleList.from("tall"),
      white: CustomTextThemeSingleList.from("white"),
    );
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

extension MyCustomTypography on Typography {
  TextTheme get black => CustomTextThemeModel.fromDefault();

  TextTheme get dense => CustomTextThemeModel.fromDefault();
  TextTheme get englishLike => CustomTextThemeModel.fromDefault();
  TextStyle get myTextStyle {
    // Define your custom text style here
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      color: Colors.blueAccent,
    );
  }

  TargetPlatform get platform => getTargetPlatform();
  TextTheme get tall => CustomTextThemeModel.fromDefault();
  TextTheme get white => CustomTextThemeModel.fromDefault();
}
