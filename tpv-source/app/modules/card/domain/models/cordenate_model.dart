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
import '../entities/cordenate.dart';

CordenateList cordenateListModelFromJson(String str) =>
    CordenateList.fromJson(json.decode(str));

CordenateModel cordenateModelFromJson(String str) =>
    CordenateModel.fromJson(json.decode(str));

String cordenateModelToJson(CordenateModel data) => json.encode(data.toJson());

class CordenateList<T extends CordenateModel> implements EntityModelList<T> {
  final List<T> cordenates;

  CordenateList({
    required this.cordenates,
  });

  factory CordenateList.fromJson(Map<String, dynamic> json) => CordenateList(
        cordenates: List<T>.from(
            json["coordinates"].map((x) => CordenateModel.fromJson(x))),
      );

  factory CordenateList.fromStringJson(String strJson) =>
      CordenateList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return CordenateList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!cordenates.contains(element)) cordenates.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return CordenateList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => cordenates;

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(cordenates.map((x) => x.toJson())),
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
class CordenateModel extends Cordenate implements EntityModel {
  @override
  final String c1;
  @override
  final String c2;
  @override
  final String p1;
  @override
  final String p2;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  CordenateModel({
    required this.c1,
    required this.c2,
    required this.p1,
    required this.p2,
  }) : super(
          c1: c1,
          c2: c2,
          p1: p1,
          p2: p2,
        );

  factory CordenateModel.fromJson(Map<String, dynamic> json) => CordenateModel(
        c1: json.containsKey("C1") && json["C1"] != null
            ? json["C1"]
            : '', //json["C1"],
        c2: json.containsKey("C2") && json["C2"] != null
            ? json["C2"]
            : '', //json["C2"],
        p1: json.containsKey("P1") && json["P1"] != null
            ? json["P1"].toString()
            : '', //json["P1"],
        p2: json.containsKey("P2") && json["P2"] != null
            ? json["P2"].toString()
            : '', //json["P2"]
      );

  factory CordenateModel.fromXml(
          XmlElement element, CordenateModel Function(XmlElement el) process) =>
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
        return CordenateList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return CordenateList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return CordenateList.fromJson({});
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
    return {"id_cordenate": "ID"};
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
        "C1": c1,
        "C2": c2,
        "P1": p1,
        "P2": p2,
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
      String key, Map<dynamic, dynamic> json, T defaultValue,
      {JsonReader<T>? reader}) {
    return EntityModel.getValueFromJson<T>(key, json, defaultValue,
        reader: reader);
  }
}
