// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import 'package:xml/xml.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/custom_font_feature.dart';

CustomFontFeatureList custom_font_featureListModelFromJson(String str) =>
    CustomFontFeatureList.fromJson(json.decode(str));

CustomFontFeatureModel custom_font_featureModelFromJson(String str) =>
    CustomFontFeatureModel.fromJson(json.decode(str));

String custom_font_featureModelToJson(CustomFontFeatureModel data) =>
    json.encode(data.toJson());

class CustomFontFeatureList<T extends CustomFontFeatureModel>
    implements EntityModelList<T> {
  final List<T> custom_font_features;

  CustomFontFeatureList({
    this.custom_font_features = const [],
  });

  factory CustomFontFeatureList.fromEmpty() => CustomFontFeatureList(
        custom_font_features:
            List<T>.from([].map((x) => CustomFontFeatureList.fromJson(x))),
      );

  factory CustomFontFeatureList.fromJson(Map<String, dynamic> json) =>
      CustomFontFeatureList(
        custom_font_features: List<T>.from(json["custom_font_features"]
            .map((x) => CustomFontFeatureModel.fromJson(x))),
      );

  factory CustomFontFeatureList.fromStringJson(String strJson) =>
      CustomFontFeatureList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return CustomFontFeatureList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!custom_font_features.contains(element)) {
        custom_font_features.add(element);
      }
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return CustomFontFeatureList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => custom_font_features;

  Map<String, dynamic> toJson() => {
        "custom_font_features":
            List<dynamic>.from(custom_font_features.map((x) => x.toJson())),
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
class CustomFontFeatureModel extends CustomFontFeature implements EntityModel {
  @override
  final String feature;
  @override
  final int value;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  CustomFontFeatureModel({
    required this.feature,
    required this.value,
  }) : super(
          feature: feature,
          value: value,
        );

  factory CustomFontFeatureModel.fromJson(Map<String, dynamic> json) =>
      CustomFontFeatureModel(
        feature: EntityModel.getValueFromJson("feature", json, ""),
        value: EntityModel.getValueFromJson("value", json, -1),
      );

  factory CustomFontFeatureModel.fromXml(XmlElement element,
          CustomFontFeatureModel Function(XmlElement el) process) =>
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
        return CustomFontFeatureList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return CustomFontFeatureList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return CustomFontFeatureList.fromJson({});
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
    return {"id_custom_font_feature": "ID"};
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
  Map<String, dynamic> toJson() => {
        "feature": feature,
        "value": value,
      };

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
}
