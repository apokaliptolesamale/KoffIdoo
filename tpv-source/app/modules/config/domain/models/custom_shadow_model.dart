// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xml/xml.dart';

import '/app/core/design/color.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/custom_shadow.dart';

CustomShadowList shadowListModelFromJson(String str) =>
    CustomShadowList.fromJson(json.decode(str));

CustomShadowModel shadowModelFromJson(String str) =>
    CustomShadowModel.fromJson(json.decode(str));

String shadowModelToJson(CustomShadowModel data) => json.encode(data.toJson());

class CustomShadowList<T extends CustomShadowModel>
    implements EntityModelList<T> {
  final List<T> shadows;

  CustomShadowList({
    this.shadows = const [],
  });

  factory CustomShadowList.fromEmpty() => CustomShadowList(
        shadows: List<T>.from([].map((x) => CustomShadowList.fromJson(x))),
      );

  factory CustomShadowList.fromJson(Map<String, dynamic> json) =>
      CustomShadowList(
        shadows: json.containsKey("shadows") && json["shadows"] is List
            ? List<T>.from(
                json["shadows"].map((x) => CustomShadowModel.fromJson(x)))
            : List.empty(growable: true),
      );

  factory CustomShadowList.fromStringJson(String strJson) =>
      CustomShadowList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return CustomShadowList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!shadows.contains(element)) shadows.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return CustomShadowList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => shadows;

  Map<String, dynamic> toJson() => {
        "shadows": List<dynamic>.from(shadows.map((x) => x.toJson())),
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
class CustomShadowModel extends CustomShadow implements EntityModel {
  @override
  final dynamic idShadow;
  @override
  final String name;

  @override
  final double dx;
  @override
  final double dy;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  CustomShadowModel({
    this.idShadow,
    required this.name,
    required Color color,
    required double blurRadius,
    required this.dx,
    required this.dy,
  }) : super(
          idShadow: idShadow,
          name: name,
          color: color,
          blurRadius: blurRadius,
          dx: dx,
          dy: dy,
        );

  factory CustomShadowModel.fromJson(Map<String, dynamic> json) =>
      CustomShadowModel(
        idShadow: EntityModel.getValueFromJson(
          "idShadow",
          json,
          null,
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key)) return json[key];
            return defaultValue;
          },
        ),
        name: EntityModel.getValueFromJson(
          "name",
          json,
          "Default",
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key)) return json[key];
            return defaultValue;
          },
        ),
        color: EntityModel.getValueFromJson(
          "color",
          json,
          Colors.transparent,
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key)) {
              return CustomColor.fromString(json[key]);
            }
            return defaultValue;
          },
        ),
        blurRadius: EntityModel.getValueFromJson(
          "blurRadius",
          json,
          1.0,
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key)) {
              return double.tryParse(json[key].toString()) ?? defaultValue;
            }
            return defaultValue;
          },
        ),
        dx: EntityModel.getValueFromJson(
          "dx",
          json,
          1.0,
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key)) {
              return double.tryParse(json[key].toString()) ?? defaultValue;
            }
            return defaultValue;
          },
        ),
        dy: EntityModel.getValueFromJson(
          "dy",
          json,
          1.0,
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key)) {
              return double.tryParse(json[key].toString()) ?? defaultValue;
            }
            return defaultValue;
          },
        ),
      );

  factory CustomShadowModel.fromXml(XmlElement element,
          CustomShadowModel Function(XmlElement el) process) =>
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
        return CustomShadowList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return CustomShadowList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return CustomShadowList.fromJson({});
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
    return {"id_shadow": "ID"};
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
    Map<String, dynamic> data = {
      "idShadow": idShadow,
      "name": name,
      "blurRadius": blurRadius,
      "color": color,
      "dx": dx,
      "dy": dy,
    };
    data.removeWhere((key, value) => value == null);
    return data;
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
}

class CustomShadowSingleList {
  static final CustomShadowSingleList instance =
      !Get.isRegistered() ? CustomShadowSingleList._internal([]) : Get.find();
  final List<CustomShadowModel> _shadows;

  factory CustomShadowSingleList({required shadows}) => instance;
  CustomShadowSingleList._internal(this._shadows) {
    Get.lazyPut(() => this);
  }

  List<CustomShadowModel> get getShadows => _shadows;

  bool add(CustomShadowModel shadow) {
    if (getByName(shadow.name) == null) {
      _shadows.add(shadow);
      return true;
    }
    return false;
  }

  Map<String, CustomShadowModel> asMap() {
    Map<String, CustomShadowModel> map = {};
    _shadows.map((e) {
      return map.addEntries([MapEntry(e.name, e)]);
    });
    return map;
  }

  bool exists(CustomShadowModel shadow) {
    return _shadows.contains(shadow);
  }

  CustomShadowModel? getByName(String name) {
    CustomShadowModel? shadow;

    if (_shadows.isEmpty) return null;
    for (var element in _shadows) {
      if (element.name == name) {
        shadow = element;
        break;
      }
    }
    return shadow;
  }

  List<CustomShadowModel> getByNames(List<String> names) {
    List<CustomShadowModel> shadows = List.empty(growable: true);
    if (_shadows.isEmpty) return List.empty(growable: true);
    for (var element in _shadows) {
      for (var name in names) {
        if (element.name == name) {
          shadows.add(element);
          break;
        }
      }
    }
    return shadows;
  }
}
