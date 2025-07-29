// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xml/xml.dart';

import '/app/core/services/logger_service.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/design/color.dart';
import '../../../../widgets/utils/custom_datetime_converter.dart';
import '../entities/design.dart';
import 'custom_shadow_model.dart';
import 'custom_text_style_model.dart';
import 'custom_text_theme_model.dart';
import 'theme_model.dart';

DesignList designListModelFromJson(String str) =>
    DesignList.fromJson(json.decode(str));

DesignModel designModelFromJson(String str) =>
    DesignModel.fromJson(json.decode(str));

String designModelToJson(DesignModel data) => json.encode(data.toJson());

class DesignList<T extends DesignModel> implements EntityModelList<T> {
  final List<T> designs;

  DesignList({
    this.designs = const [],
  });

  factory DesignList.fromEmpty() => DesignList(
        designs: List<T>.from([].map((x) => DesignList.fromJson(x))),
      );

  factory DesignList.fromJson(Map<String, dynamic> json) => DesignList(
        designs:
            List<T>.from(json["designs"].map((x) => DesignModel.fromJson(x))),
      );

  factory DesignList.fromStringJson(String strJson) =>
      DesignList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return DesignList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!designs.contains(element)) designs.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return DesignList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => designs;

  Map<String, dynamic> toJson() => {
        "designs": List<dynamic>.from(designs.map((x) => x.toJson())),
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
class DesignModel extends Design implements EntityModel {
  @override
  final String name;
  @override
  final String clientId;
  @override
  final DateTime createAt;
  @override
  final DateTime updateAt;
  @override
  final List<Color> colors;
  @override
  final List<ThemeModel> themes;
  @override
  final List<CustomTextThemeModel> textThemes;
  @override
  final List<CustomTextStyleModel> styles;
  @override
  final List<CustomShadowModel> shadows;
  @override
  Map<String, ColumnMetaModel>? metaModel;

  DesignModel({
    required this.name,
    required this.clientId,
    required this.createAt,
    required this.updateAt,
    required this.colors,
    required this.themes,
    required this.textThemes,
    required this.styles,
    required this.shadows,
  }) : super(
          name: name,
          clientId: clientId,
          createAt: createAt,
          updateAt: updateAt,
          colors: colors,
          themes: themes,
          textThemes: textThemes,
          styles: styles,
          shadows: shadows,
        );

  factory DesignModel.fromEmpty() => DesignModel(
        name: "",
        clientId: "",
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        colors: List.empty(growable: true),
        styles: CustomTextStyleList.fromEmpty().styles,
        themes: ThemeList.fromEmpty().themes,
        textThemes: CustomTextThemeList.fromEmpty().textThemes,
        shadows: CustomShadowList.fromEmpty().shadows,
      );
  factory DesignModel.fromJson(Map<String, dynamic> json) {
    //
    List<Color> colors = json.isNotEmpty
        ? List<Color>.from(CustomColorList.fromJson(json).colors.map((e) {
            log("Cargando color:${e.name}");
            CustomColorSingleList.instance.add(e);
            return e;
          })).toList(growable: true)
        : List.empty(growable: true);
    //
    /*final tmp = CustomShadowList.fromJson((json["design"] as List).elementAt(0))
        .shadows;*/
    List<CustomShadowModel> shadows = json.isNotEmpty
        ? List<CustomShadowModel>.from(
            CustomShadowList.fromJson(json).shadows.map((e) {
            log("Cargando tema:${e.name}");
            CustomShadowSingleList.instance.add(e);
            return e;
          })).toList(growable: true)
        : List.empty(growable: true);

    //
    final List<CustomTextStyleModel> styles =
        CustomTextStyleList.fromJson(json).styles;
    //
    List<CustomTextThemeModel> textThemes = json.isNotEmpty
        ? List<CustomTextThemeModel>.from(
            CustomTextThemeList.fromJson(json).textThemes.map((e) {
            log("Cargando tema de texto:${e.themeName}");
            CustomTextThemeSingleList.instance.add(e);
            return e;
          })).toList(growable: true)
        : List.empty(growable: true);
    //
    List<ThemeModel> themes = json.isNotEmpty
        ? List<ThemeModel>.from(ThemeList.fromJson(json).themes.map((e) {
            log("Cargando tema:${e.name}");
            CustomThemeSingleList.instance.add(e);
            return e;
          })).toList(growable: true)
        : List.empty(growable: true);

    //
    return DesignModel(
      name: EntityModel.getValueFromJson(
        "design",
        json,
        "",
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key)) {
            return data[key];
          }
          return defaultValue;
        },
      ),
      clientId: EntityModel.getValueFromJson(
        "clientId",
        json,
        "",
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key)) {
            return data[key];
          }
          return defaultValue;
        },
      ),
      createAt: EntityModel.getValueFromJson(
        "createAt",
        json,
        DateTime.now(),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key)) {
            return CustomDateTimeConverter.from(data[key]);
          }
          return defaultValue;
        },
      ),
      updateAt: EntityModel.getValueFromJson(
        "updateAt",
        json,
        DateTime.now(),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key)) {
            return CustomDateTimeConverter.from(data[key]);
          }
          return defaultValue;
        },
      ),
      colors: colors,
      textThemes: textThemes,
      themes: themes,
      styles: styles,
      shadows: shadows,
    );
  }
  factory DesignModel.fromXml(
          XmlElement element, DesignModel Function(XmlElement el) process) =>
      process(element);
  @override
  Map<String, ColumnMetaModel>? get getMetaModel => getColumnMetaModel();

  @override
  set setMetaModel(Map<String, ColumnMetaModel> newMetaModel) {
    metaModel = newMetaModel;
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return DesignList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return DesignList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return DesignList.fromJson({});
  }

  @override
  Map<String, ColumnMetaModel> getColumnMetaModel() {
    //Map<String, String> colNames = getColumnNames();
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
    return {"id_design": "ID"};
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

  Color getSecundaryColor() {
    return colors.isNotEmpty && colors.length >= 2
        ? colors.elementAt(1)
        : Colors.transparent;
  }

  Color getTertiaryColor() {
    return colors.isNotEmpty && colors.length >= 3
        ? colors.elementAt(2)
        : Colors.transparent;
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

  bool isValidId() => clientId.isNotEmpty;

  @override
  Map<String, dynamic> toJson() {
    final colorList = List<Map<String, dynamic>>.from(
        colors.map((e) => (e as CustomColor).toJson()));
    final themesList =
        List<Map<String, dynamic>>.from(themes.map((e) => e.toJson()));
    final textThemesList =
        List<Map<String, dynamic>>.from(textThemes.map((e) => e.toJson()));
    final stylesList =
        List<Map<String, dynamic>>.from(styles.map((e) => e.toJson()));
    //
    final Map<String, dynamic> source = {
      "colors": colorList,
      "themes": themesList,
      "textThemes": textThemesList,
      "styles": stylesList,
    };
    return source;
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
    Map<dynamic, dynamic> json,
    T defaultValue, {
    JsonReader<T>? reader,
    Caster<T>? cast,
  }) {
    return EntityModel.getValueFromJson<T>(
      key,
      json,
      defaultValue,
      reader: reader,
      cast: cast,
    );
  }

  static Future<DesignModel?> loadFromAssets(String file) async {
    String source = await _readFileAsync(file);
    Map<String, dynamic> properties = json.decode(source);
    DesignModel? design =
        properties.isNotEmpty && properties.containsKey("design")
            ? DesignModel.fromJson(properties["design"]!)
            : null;
    return design;
  }

  static Future<String> _readFileAsync(
    String path, {
    cache = true,
  }) {
    return rootBundle.loadString(
      path,
      cache: cache,
    );
  }
}
