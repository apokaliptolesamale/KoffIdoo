// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member, must_be_immutable
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xml/xml.dart';

import '/app/modules/config/domain/models/custom_shadow_model.dart';
import '../../../../../app/core/helpers/functions.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../core/design/color.dart';
import '../entities/custom_icon_theme_data.dart';

CustomIconThemeDataList custom_icon_theme_dataListModelFromJson(String str) =>
    CustomIconThemeDataList.fromJson(json.decode(str));

CustomIconThemeDataModel custom_icon_theme_dataModelFromJson(String str) =>
    CustomIconThemeDataModel.fromJson(json.decode(str));

String custom_icon_theme_dataModelToJson(CustomIconThemeDataModel data) =>
    json.encode(data.toJson());

class CustomIconThemeDataList<T extends CustomIconThemeDataModel>
    implements EntityModelList<T> {
  final List<T> custom_icon_theme_datas;

  CustomIconThemeDataList({
    this.custom_icon_theme_datas = const [],
  });

  factory CustomIconThemeDataList.fromEmpty() => CustomIconThemeDataList(
        custom_icon_theme_datas:
            List<T>.from([].map((x) => CustomIconThemeDataList.fromJson(x))),
      );

  factory CustomIconThemeDataList.fromJson(Map<String, dynamic> json) =>
      CustomIconThemeDataList(
        custom_icon_theme_datas: List<T>.from(json["custom_icon_theme_datas"]
            .map((x) => CustomIconThemeDataModel.fromJson(x))),
      );

  factory CustomIconThemeDataList.fromStringJson(String strJson) =>
      CustomIconThemeDataList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return CustomIconThemeDataList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!custom_icon_theme_datas.contains(element)) {
        custom_icon_theme_datas.add(element);
      }
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return CustomIconThemeDataList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => custom_icon_theme_datas;

  Map<String, dynamic> toJson() => {
        "custom_icon_theme_datas":
            List<dynamic>.from(custom_icon_theme_datas.map((x) => x.toJson())),
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
class CustomIconThemeDataModel extends CustomIconThemeData
    implements EntityModel {
  //
  @override
  double? size;

  @override
  double? fill;

  @override
  double? weight;

  @override
  double? grade;
  @override
  double? opticalSize;
  @override
  Color? color;
  @override
  double? opacity;
  @override
  List<Shadow>? shadows;
  @override
  Map<String, ColumnMetaModel>? metaModel;
  CustomIconThemeDataModel({
    this.size = 24.0,
    this.fill = 0.0,
    this.weight = 400.0,
    this.grade = 0.0,
    this.opticalSize = 48.0,
    this.color = const Color(0xFF000000),
    double? opacity,
    this.shadows,
  }) : super(
          size: size,
          fill: fill,
          weight: weight,
          grade: grade,
          opticalSize: opticalSize,
          color: color,
          opacity: opacity,
          shadows: shadows,
        ) {
    color = super.color = opacity != null ? color!.withOpacity(opacity) : color;
  }
  factory CustomIconThemeDataModel.fromDefault() {
    return CustomIconThemeDataModel(
      size: 24.0,
      fill: 0.0,
      weight: 2.0,
      grade: 0.0,
      opticalSize: 48.0,
      color: Color(0xFF000000),
      opacity: 1.0,
      shadows: List.empty(growable: true),
    );
  }
  factory CustomIconThemeDataModel.fromJson(Map<String, dynamic> json) =>
      CustomIconThemeDataModel(
        size: getValueFrom(
          "size",
          json,
          24.0,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return double.tryParse(data[key]) ?? defaultValue;
            }
            return defaultValue;
          },
        ),
        fill: getValueFrom(
          "fill",
          json,
          0.0,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return double.tryParse(data[key]) ?? defaultValue;
            }
            return defaultValue;
          },
        ),
        weight: getValueFrom(
          "weight",
          json,
          2.0,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return double.tryParse(data[key]) ?? defaultValue;
            }
            return defaultValue;
          },
        ),
        grade: getValueFrom(
          "grade",
          json,
          0.0,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return double.tryParse(data[key]) ?? defaultValue;
            }
            return defaultValue;
          },
        ),
        opticalSize: getValueFrom(
          "opticalSize",
          json,
          48.0,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is String) {
              return double.tryParse(data[key]) ?? defaultValue;
            }
            return defaultValue;
          },
        ),
        color: getValueFrom(
          "color",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key) && data[key] is Map) {
              return CustomColor.fromJson(data[key]);
            } else if (data.containsKey(key) && data[key] is String) {
              return CustomColor.fromString(data[key]);
            }
            return defaultValue;
          },
        ),
        opacity: getValueFrom(
          "opacity",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return double.tryParse(data[key].toString()) ?? defaultValue;
            }
            return defaultValue;
          },
        ),
        shadows: EntityModel.getValueFromJson(
          "shadows",
          json,
          null,
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
      );
  factory CustomIconThemeDataModel.fromXml(XmlElement element,
          CustomIconThemeDataModel Function(XmlElement el) process) =>
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
    return CustomIconThemeDataModel.fromJson(other.toJson()) as T;
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return CustomIconThemeDataList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return CustomIconThemeDataList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return CustomIconThemeDataList.fromJson({});
  }

  @override
  T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
    return CustomIconThemeDataModel.fromJson(params) as T;
  }

  @override
  Map<String, ColumnMetaModel> getColumnMetaModel() {
    // //Map<String, String> colNames = getColumnNames();
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
    return {"id_custom_icon_theme_data": "ID"};
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
        "size": size,
        "fill": fill,
        "weight": weight,
        "grade": grade,
        "opticalSize": opticalSize,
        "color": color,
        "opacity": opacity,
        "shadows": shadows,
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
