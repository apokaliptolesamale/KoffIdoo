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
import '../entities/custom_font_variation.dart';

FontVariationList fontvariationListModelFromJson(String str) =>
    FontVariationList.fromJson(json.decode(str));

CustomFontVariationModel fontvariationModelFromJson(String str) =>
    CustomFontVariationModel.fromJson(json.decode(str));

String fontvariationModelToJson(CustomFontVariationModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class CustomFontVariationModel extends CustomFontVariation
    implements EntityModel {
  @override
  final String axis;
  @override
  final double value;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  CustomFontVariationModel({
    required this.axis,
    required this.value,
  }) : super(
          axis: axis,
          value: value,
        );

  factory CustomFontVariationModel.fromJson(Map<String, dynamic> json) =>
      CustomFontVariationModel(
        axis: EntityModel.getValueFromJson(
          "axis",
          json,
          "",
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return data[key];
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
        value: EntityModel.getValueFromJson(
          "value",
          json,
          0.0,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) {
              return data[key];
            }
            return defaultValue;
          },
          cast: (value) => value,
        ),
      );

  factory CustomFontVariationModel.fromXml(XmlElement element,
          CustomFontVariationModel Function(XmlElement el) process) =>
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
        return FontVariationList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return FontVariationList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return FontVariationList.fromJson({});
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
    return {
      "axis": "Axis",
      "value": "Valor",
    };
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
        "axis": axis,
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

class FontVariationList<T extends CustomFontVariationModel>
    implements EntityModelList<T> {
  final List<T> fontvariations;

  FontVariationList({
    this.fontvariations = const [],
  });

  factory FontVariationList.fromEmpty() => FontVariationList(
        fontvariations:
            List<T>.from([].map((x) => FontVariationList.fromJson(x))),
      );

  factory FontVariationList.fromJson(Map<String, dynamic> json) =>
      FontVariationList(
        fontvariations: List<T>.from(json["fontvariations"]
            .map((x) => CustomFontVariationModel.fromJson(x))),
      );

  factory FontVariationList.fromStringJson(String strJson) =>
      FontVariationList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return FontVariationList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!fontvariations.contains(element)) fontvariations.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return FontVariationList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => fontvariations;

  Map<String, dynamic> toJson() => {
        "fontvariations":
            List<dynamic>.from(fontvariations.map((x) => x.toJson())),
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
