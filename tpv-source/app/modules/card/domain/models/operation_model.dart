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
import '../entities/operation.dart';

final actionValues = EnumValues({"DB": Action.DB});

//enum Channel { POS, ATM }

final channelValues = EnumValues({"ATM": Channel.ATM, "POS": Channel.POS});

OperationList operationListModelFromJson(String str) =>
    OperationList.fromJson(json.decode(str));

OperationModel operationModelFromJson(String str) =>
    OperationModel.fromJson(json.decode(str));

String operationModelToJson(OperationModel data) => json.encode(data.toJson());

//enum OperationDate { THE_160822 }

//final operationDateValues = EnumValues({"16/08/22": OperationDate.THE_160822});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    //reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class OperationList<T extends OperationModel> implements EntityModelList<T> {
  final List<T> operations;

  OperationList({
    required this.operations,
  });

  factory OperationList.fromJson(Map<String, dynamic> json) => OperationList(
        operations: List<T>.from(
            json["operation"].map((x) => OperationModel.fromJson(x))),
      );

  factory OperationList.fromStringJson(String strJson) =>
      OperationList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return OperationList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!operations.contains(element)) operations.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return OperationList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => operations;

  Map<String, dynamic> toJson() => {
        "operation": List<dynamic>.from(operations.map((x) => x.toJson())),
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
class OperationModel extends Operation implements EntityModel {
  @override
  final String operationDate;
  @override
  final String action;
  @override
  final String channel;
  @override
  final String description;
  @override
  final String amount;
  @override
  final String codigo;
  @override
  final String avatar;
  @override
  final String alias;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  OperationModel({
    required this.operationDate,
    required this.action,
    required this.channel,
    required this.description,
    required this.amount,
    required this.codigo,
    required this.avatar,
    required this.alias,
  }) : super(
          operationDate: operationDate,
          action: action,
          channel: channel,
          description: description,
          amount: amount,
          codigo: codigo,
          avatar: avatar,
          alias: alias,
        );

  factory OperationModel.fromJson(Map<String, dynamic> json) => OperationModel(
        operationDate: json["operation_date"],
        action: json["action"],
        channel: json["channel"],
        description: json["description"],
        amount: json["amount"],
        codigo: json["codigo"],
        avatar: json["avatar"],
        alias: json["alias"],
      );

  factory OperationModel.fromXml(
          XmlElement element, OperationModel Function(XmlElement el) process) =>
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
        return OperationList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return OperationList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return OperationList.fromJson({});
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
    return {"id_operation": "ID"};
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
        "operation_date": operationDate,
        "action": actionValues.reverse[action],
        "channel": channelValues.reverse[channel],
        "description": description,
        "amount": amount,
        "codigo": codigo,
        "avatar": avatar,
        "alias": alias,
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
