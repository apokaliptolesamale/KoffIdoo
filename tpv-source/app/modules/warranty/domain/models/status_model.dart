// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:xml/xml.dart';

import '../../../../../../../../../app/core/config/errors/exceptions.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/status.dart';

StatusList statusListModelFromJson(String str) =>
    StatusList.fromJson(json.decode(str));

StatusModel statusModelFromJson(String str) =>
    StatusModel.fromJson(json.decode(str));

String statusModelToJson(StatusModel data) => json.encode(data.toJson());

class StatusList<T extends StatusModel> implements EntityModelList<T> {
  final List<T> statuss;

  StatusList({
    required this.statuss,
  });

  factory StatusList.fromJson(Map<String, dynamic> json) => StatusList(
        statuss:
            List<T>.from(json["statuss"].map((x) => StatusModel.fromJson(x))),
      );

  factory StatusList.fromStringJson(String strJson) =>
      StatusList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return StatusList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!statuss.contains(element)) statuss.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return StatusList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => statuss;

  Map<String, dynamic> toJson() => {
        "statuss": List<dynamic>.from(statuss.map((x) => x.toJson())),
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

class StatusModel extends Status implements EntityModel {
  @override
  final dynamic id;
  @override
  final String denominacion;
  @override
  final String descripcion;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  StatusModel({
    required this.id,
    required this.denominacion,
    required this.descripcion,
  }) : super(id: id, denominacion: denominacion, descripcion: descripcion);

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        id: json["id"],
        denominacion: json["denominacion"],
        descripcion: json["descripcion"],
      );

  factory StatusModel.fromXml(
          XmlElement element, StatusModel Function(XmlElement el) process) =>
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
        return StatusList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return StatusList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return StatusList.fromJson({});
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
    return {"id_status": "ID"};
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
  Map<String, dynamic> toJson() => {
        "id": id,
        "denominacion": denominacion,
        "descripcion": descripcion,
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
  static T? getValueFrom<T>(
      String key, Map<dynamic, dynamic> json, dynamic defaultValue) {
    if (defaultValue != null && defaultValue is ServerException) {
      throw defaultValue;
    }
    try {
      return EntityModel.getValueFromJson<T?>(key, json, defaultValue);
    } on Exception {
      throw CastErrorException();
    }
  }

  static String translate(String status) {
    switch (status) {
      case "CREATED":
        return "Creada(o)";
      case "ACCEPTED":
        return "Aceptada(o)";
      case "REFUSED":
        return "Rechazada(o)";
      case "EXPIRED":
        return "Expirada(o)";
      case "FAILED":
        return "Fallo";
      case "REPAIR":
        return "Reparación";
      case "REPAIRED":
        return "Reparado";
      case "NO REPAIR":
        return "Sin reparación";
    }
    return status;
  }
}
