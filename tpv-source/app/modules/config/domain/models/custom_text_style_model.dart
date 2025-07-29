// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member, must_be_immutable, non_constant_identifier_names
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui' as ui
    show FontFeature, FontVariation, Shadow, TextLeadingDistribution;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xml/xml.dart';

import '/app/core/design/color.dart';
import '/app/core/design/font_style_parser.dart';
import '/app/core/design/font_weight_parser.dart';
import '/app/core/design/text_baseline_parser.dart';
import '/app/core/design/text_decoration_parser.dart';
import '/app/core/design/text_decoration_style_parser.dart';
import '/app/core/design/text_leading_distribution_parser.dart';
import '/app/core/design/text_overflow_parser.dart';
import '/app/core/helpers/functions.dart';
import '/app/modules/config/domain/models/custom_shadow_model.dart';
import '/app/modules/config/domain/models/font_variation_model.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/custom_text_style.dart';

CustomTextStyleList custom_textstyleListModelFromJson(String str) =>
    CustomTextStyleList.fromJson(json.decode(str));

CustomTextStyleModel custom_textstyleModelFromJson(String str) =>
    CustomTextStyleModel.fromJson(json.decode(str));

String custom_textstyleModelToJson(CustomTextStyleModel data) =>
    json.encode(data.toJson());

class CustomTextStyleList<T extends CustomTextStyleModel>
    implements EntityModelList<T> {
  final List<T> styles;

  CustomTextStyleList({
    this.styles = const [],
  });

  factory CustomTextStyleList.fromEmpty() => CustomTextStyleList(
        styles: List<T>.from([].map((x) => CustomTextStyleList.fromJson(x))),
      );

  factory CustomTextStyleList.fromJson(Map<String, dynamic> json) =>
      CustomTextStyleList(
        styles: List<T>.from(json["styles"].map((x) {
          CustomTextStyleModel? tmp =
              CustomTextStyleSingleList.instance.getByName(x["styleName"]);
          if (tmp == null) {
            CustomTextStyleSingleList.instance
                .add(tmp = CustomTextStyleModel.fromJson(x));
          }
          return tmp;
        })),
      );

  factory CustomTextStyleList.fromStringJson(String strJson) =>
      CustomTextStyleList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return CustomTextStyleList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!styles.contains(element)) styles.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return CustomTextStyleList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => styles;

  Map<String, dynamic> toJson() => {
        "styles": List<dynamic>.from(styles.map((x) => x.toJson())),
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
class CustomTextStyleModel extends CustomTextStyle implements EntityModel {
  //
  @override
  double opacity;

  @override
  String? styleId;

  @override
  String styleName;

  @override
  final bool inherit = true;

  @override
  Color? color;
  @override
  final Color? backgroundColor;
  @override
  final double? fontSize;

  @override
  final FontWeight? fontWeight;
  @override
  final FontStyle? fontStyle;
  @override
  final double? letterSpacing;
  @override
  final double? wordSpacing;
  @override
  final TextBaseline? textBaseline;
  @override
  final double? height;
  @override
  final ui.TextLeadingDistribution? leadingDistribution;
  @override
  final Locale? locale;
  @override
  final Paint? foreground;
  @override
  final Paint? background;
  @override
  final List<ui.Shadow>? shadows;
  @override
  final List<ui.FontFeature>? fontFeatures;
  @override
  final List<ui.FontVariation>? fontVariations;
  @override
  final TextDecoration? decoration;
  @override
  final Color? decorationColor;
  @override
  final TextDecorationStyle? decorationStyle;
  @override
  final double? decorationThickness;
  @override
  final String? debugLabel;
  @override
  String? fontFamily;
  @override
  List<String>? fontFamilyFallback;
  @override
  String? package;
  @override
  final TextOverflow? overflow;
  @override
  Map<String, ColumnMetaModel>? metaModel;
  //
  CustomTextStyleModel({
    required this.styleName,
    required this.styleId,
    this.opacity = 0.0,
    this.color,
    this.backgroundColor,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.height,
    this.leadingDistribution,
    this.locale,
    this.foreground,
    this.background,
    this.shadows,
    this.fontFeatures,
    this.fontVariations,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.debugLabel,
    this.fontFamily,
    this.fontFamilyFallback = const [
      "Arial",
      "sans-serif",
      "Pacifico",
      "Source Sans Pro",
      "Helvetica Neue",
      "Open Sans",
      "Lato",
      "Montserrat",
      "Noto Sans"
    ],
    this.package,
    this.overflow,
  }) : super(
          styleId: styleId,
          styleName: styleName,
          package: package,
          color: opacity > 0.0 ? color?.withOpacity(opacity) : color,
          backgroundColor: backgroundColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
          textBaseline: textBaseline,
          height: height,
          leadingDistribution: leadingDistribution,
          locale: locale,
          foreground: color != null ? null : foreground,
          background: backgroundColor != null ? null : background,
          shadows: shadows,
          fontFeatures: fontFeatures,
          fontVariations: fontVariations,
          decoration: decoration,
          decorationColor: decorationColor,
          decorationStyle: decorationStyle,
          decorationThickness: decorationThickness,
          debugLabel: debugLabel,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          overflow: overflow,
        ) {
    color = opacity > 0.0 ? color?.withOpacity(opacity) : color;
  }

  factory CustomTextStyleModel.fromJson(Map<String, dynamic> json) =>
      CustomTextStyleModel(
        styleId: EntityModel.getValueFromJson(
          "styleId",
          json,
          "Default",
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return data[key];
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        styleName: EntityModel.getValueFromJson(
          "styleName",
          json,
          "Default",
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return data[key];
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        package: EntityModel.getValueFromJson(
          "package",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return data[key];
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        color: EntityModel.getValueFromJson(
          "color",
          json,
          CustomColor.fromColor(Colors.black),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            }
            if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        opacity: EntityModel.getValueFromJson(
          "colorOpacity",
          json,
          0.0,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return double.tryParse(data[key].toString()) ?? defaultValue;
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        backgroundColor: EntityModel.getValueFromJson(
          "backgroundColor",
          json,
          !json.containsKey("backgroundColor") &&
                  !json.containsKey("background")
              ? Colors.black
              : null,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            }
            if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        background: EntityModel.getValueFromJson(
          "background",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && !data.containsKey("backgroundColor")) {
              return Paint()..color = CustomColor.fromString(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        fontSize: EntityModel.getValueFromJson(
          "fontSize",
          json,
          14.0,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return double.tryParse(data[key].toString()) ?? defaultValue;
            }
            return defaultValue;
          },
          cast: (value) => value.toDouble(),
        ),
        fontWeight: EntityModel.getValueFromJson(
          "fontWeight",
          json,
          FontWeightParser.normal,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return FontWeightParser.parse(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => FontWeightParser.parse(value),
        ),
        fontStyle: EntityModel.getValueFromJson(
          "fontStyle",
          json,
          FontStyleParser.normal,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return FontStyleParser.parse(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => FontStyleParser.parse(value),
        ),
        letterSpacing: EntityModel.getValueFromJson(
          "letterSpacing",
          json,
          0.5,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return double.tryParse(data[key].toString()) ?? defaultValue;
            }
            return defaultValue;
          },
          cast: (value) => double.tryParse(value) ?? 0.5,
        ),
        wordSpacing: EntityModel.getValueFromJson(
          "wordSpacing",
          json,
          0.5,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return double.tryParse(data[key].toString()) ?? defaultValue;
            }
            return defaultValue;
          },
          cast: (value) => double.tryParse(value) ?? 0.5,
        ),
        textBaseline: EntityModel.getValueFromJson(
          "textBaseline",
          json,
          TextBaselineParser.alphabetic,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return TextBaselineParser.parse(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => TextBaselineParser.parse(value),
        ),
        height: EntityModel.getValueFromJson(
          "height",
          json,
          1.0,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return double.tryParse(data[key].toString()) ?? defaultValue;
            }
            return defaultValue;
          },
          cast: (value) => double.tryParse(value) ?? 1.0,
        ),
        leadingDistribution: EntityModel.getValueFromJson(
          "leadingDistribution",
          json,
          TextLeadingDistributionParser.even,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return TextLeadingDistributionParser.parse(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => TextLeadingDistributionParser.parse(value),
        ),
        locale: EntityModel.getValueFromJson(
          "locale",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) &&
                data[key] is Map &&
                (data[key] as Map).containsKey("languageCode")) {
              return Locale(
                  data[key]["languageCode"], data[key]["countryCode"]);
            }
            return defaultValue;
          },
          cast: (value) => Locale(value["languageCode"], value["countryCode"]),
        ),
        foreground: EntityModel.getValueFromJson(
          "foreground",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && !data.containsKey("color")) {
              return Paint()..color = CustomColor.fromString(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        shadows: EntityModel.getValueFromJson(
          "shadows",
          json,
          CustomShadowSingleList.instance.getShadows,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              if (data[key] is List) {
                return (data[key] as List<dynamic>)
                    .map((dynamic item) => CustomShadowModel(
                          idShadow: item["idShadow"],
                          name: item["name"],
                          color: CustomColor.fromString(item["color"]),
                          blurRadius: item["blurRadius"].toDouble(),
                          dx: double.tryParse(item["dx"]) ?? 1.0,
                          dy: double.tryParse(item["dy"]) ?? 1.0,
                        ))
                    .toList();
              } else if (data[key] is String &&
                  data[key].toString().isNotEmpty) {
                RegExp exp = RegExp("[,;:]");
                if (data[key].toString().contains(exp)) {
                  return CustomShadowSingleList.instance
                      .getByNames(data[key].toString().split(exp));
                }
                return CustomShadowSingleList.instance.getShadows;
              }
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        fontFeatures: getValueFrom(
          "fontFeatures",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key) && data[key] is List) {
              final list = (data[key] as List);
              return (list.isNotEmpty)
                  ? list
                      .map((e) => ui.FontFeature(e["feature"], e["value"]))
                      .toList()
                  : [];
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        fontVariations: getValueFrom(
          "fontVariations",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key) && data[key] is List) {
              final list = (data[key] as List);
              return (list.isNotEmpty)
                  ? list
                      .map((e) => CustomFontVariationModel.fromJson(e))
                      .toList()
                  : [];
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        decoration: EntityModel.getValueFromJson(
          "decoration",
          json,
          TextDecorationParser.none,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return TextDecorationParser.parse(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => TextDecorationParser.parse(value),
        ),
        decorationColor: EntityModel.getValueFromJson(
          "decorationColor",
          json,
          CustomColor.fromString("0xFF000000"),
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return CustomColor.fromString(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        decorationStyle: EntityModel.getValueFromJson(
          "decorationStyle",
          json,
          TextDecorationStyleParser.solid,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return TextDecorationStyleParser.parse(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => TextDecorationStyleParser.parse(value),
        ),
        decorationThickness: EntityModel.getValueFromJson(
          "decorationThickness",
          json,
          1.0,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return data[key].toDouble();
            }
            return defaultValue;
          },
          cast: (value) => value.toDouble(),
        ),
        debugLabel: EntityModel.getValueFromJson(
          "debugLabel",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return data[key];
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        fontFamily: EntityModel.getValueFromJson(
          "fontFamily",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return data[key];
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        fontFamilyFallback: EntityModel.getValueFromJson(
          "fontFamilyFallback",
          json,
          [
            "Arial",
            "sans-serif",
            "Pacifico",
            "Source Sans Pro",
            "Helvetica Neue",
            "Open Sans",
            "Lato",
            "Montserrat",
            "Noto Sans"
          ],
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return (data[key] as List<dynamic>).cast<String>();
            }
            return defaultValue;
          },
          cast: (value) => (value as List<dynamic>).cast<String>(),
        ),
        overflow: EntityModel.getValueFromJson(
          "overflow",
          json,
          TextOverflowParser.clip,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return TextOverflowParser.parse(data[key]);
            }
            return defaultValue;
          },
          cast: (value) => TextOverflowParser.parse(value),
        ),
      );
  factory CustomTextStyleModel.fromString(String source) {
    final style = CustomTextStyleSingleList.instance.getByName(source);
    if (style != null) {
      return style;
    }
    if (isJson(source)) {
      return CustomTextStyleModel.fromJson(json.decode(source));
    }
    return CustomTextStyleModel.fromJson({});
  }
  //
  factory CustomTextStyleModel.fromXml(XmlElement element,
          CustomTextStyleModel Function(XmlElement el) process) =>
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
    return CustomTextStyleModel.fromJson(other.toJson()) as T;
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return CustomTextStyleList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return CustomTextStyleList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return CustomTextStyleList.fromJson({});
  }

  @override
  T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
    return CustomTextStyleModel.fromJson(params) as T;
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
    return {"id_custom_textstyle": "ID"};
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
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "styleId": styleId ?? "styleName",
      "styleName": styleName,
      "color": color?.value.toRadixString(16),
      "backgroundColor": backgroundColor?.value.toRadixString(16),
      "fontSize": fontSize,
      "fontWeight": FontWeightParser.value(fontWeight),
      "fontStyle": FontStyleParser.value(fontStyle),
      "letterSpacing": letterSpacing,
      "wordSpacing": wordSpacing,
      "textBaseline": TextBaselineParser.value(textBaseline),
      "height": height,
      "leadingDistribution":
          TextLeadingDistributionParser.value(leadingDistribution),
      "locale": locale != null ? locale!.toString() : null,
      "foreground": foreground?.color.value.toRadixString(16),
      "background": background?.color.value.toRadixString(16),
      "shadows": shadows != null
          ? shadows!
              .map((e) => {
                    "color": e.color.value.toRadixString(16),
                    "blurRadius": e.blurRadius,
                    "dx": e.offset.dx,
                    "dy": e.offset.dy
                  }.toString())
              .toList()
          : [],
      "fontFeatures": fontFeatures != null
          ? fontFeatures!
              .map((e) => {
                    "feature": e.feature,
                    "value": e.value,
                  })
              .toString()
          : [],
      "fontVariations": fontVariations != null
          ? fontVariations!
              .map((e) => {
                    "feature": e.axis,
                    "value": e.value,
                  })
              .toString()
          : [],
      "decoration": TextDecorationParser.value(decoration),
      "decorationColor": decorationColor?.value.toRadixString(16),
      "decorationStyle": TextDecorationStyleParser.value(decorationStyle),
      "decorationThickness": decorationThickness,
      "debugLabel": debugLabel,
      "fontFamily": fontFamily ?? "Roboto",
      "fontFamilyFallback":
          fontFamilyFallback != null && fontFamilyFallback!.isNotEmpty
              ? fontFamilyFallback!.map((e) => e).toList()
              : [],
      "package": package,
      "overflow": TextOverflowParser.value(overflow),
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

//
class CustomTextStyleSingleList {
  static final CustomTextStyleSingleList instance = !Get.isRegistered()
      ? CustomTextStyleSingleList._internal([])
      : Get.find();
  final List<CustomTextStyleModel> _styles;

  factory CustomTextStyleSingleList({required styles}) => instance;
  CustomTextStyleSingleList._internal(this._styles) {
    Get.lazyPut(() => this);
  }
  List<CustomTextStyleModel> get getStyles => _styles;

  bool add(CustomTextStyleModel style) {
    if (getByName(style.styleName) == null) {
      _styles.add(style);
      return true;
    }
    return false;
  }

  Map<String, CustomTextStyleModel> asMap() {
    Map<String, CustomTextStyleModel> map = {};
    _styles.map((e) {
      return map.addEntries([MapEntry(e.styleName, e)]);
    });
    return map;
  }

  bool exists(CustomTextStyleModel style) {
    return _styles.contains(style);
  }

  CustomTextStyleModel? getByName(String name) {
    CustomTextStyleModel? style;

    if (_styles.isEmpty) {
      if (isJson(name)) {
        return CustomTextStyleModel.fromJson(json.decode(name));
      }
    }
    for (var element in _styles) {
      if (element.styleName == name) {
        style = element;
        break;
      }
    }
    return style;
  }

  static CustomTextStyleModel from(String name) =>
      CustomTextStyleSingleList.instance.getByName(name) ??
      CustomTextStyleModel.fromJson({});
}
