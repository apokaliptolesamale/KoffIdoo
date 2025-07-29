// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member

import 'dart:async';
import 'dart:convert';

import 'package:xml/xml.dart';

import '/app/core/services/logger_service.dart';
import '../../../../../../../../../app/core/config/errors/exceptions.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/orderhistory.dart';

OrderHistoryList orderhistoryListModelFromJson(String str) =>
    OrderHistoryList.fromJson(json.decode(str));

OrderHistoryModel orderhistoryModelFromJson(String str) =>
    OrderHistoryModel.fromJson(json.decode(str));

String orderhistoryModelToJson(OrderHistoryModel data) =>
    json.encode(data.toJson());

class OrderHistoryList<T extends OrderHistoryModel>
    implements EntityModelList<T> {
  final List<T> orderhistorys;

  OrderHistoryList({
    required this.orderhistorys,
  });

  factory OrderHistoryList.fromJson(Map<String, dynamic> json) =>
      OrderHistoryList(
        orderhistorys: List<T>.from(
            json["orderhistorys"].map((x) => OrderHistoryModel.fromJson(x))),
      );

  factory OrderHistoryList.fromStringJson(String strJson) => OrderHistoryList(
        orderhistorys: List<T>.from(json
            .decode(strJson)["orderhistorys"]
            .map((x) => OrderHistoryModel.fromJson(x))),
      );

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return OrderHistoryList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!orderhistorys.contains(element)) orderhistorys.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return OrderHistoryList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => orderhistorys;

  Map<String, dynamic> toJson() => {
        "orderhistorys":
            List<dynamic>.from(orderhistorys.map((x) => x.toJson())),
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

class OrderHistoryModel extends OrderHistory implements EntityModel {
  @override
  dynamic id, idEmployee, idOrderState, idOrder, dateAdd;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  OrderHistoryModel({
    this.id,
    this.idEmployee,
    this.idOrder,
    this.idOrderState,
    this.dateAdd,
  }) : super(
          id: id,
          idEmployee: idEmployee,
          idOrder: idOrder,
          idOrderState: idOrderState,
          dateAdd: dateAdd,
        );

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryModel(
        id: getValueFrom("id", json, null),
        idEmployee: getValueFrom("idEmployee", json, null),
        idOrder: getValueFrom("idOrder", json, null),
        idOrderState: getValueFrom("idOrderState", json, null),
        dateAdd: getValueFrom("dateAdd", json, null),
      );

  factory OrderHistoryModel.fromXml(XmlElement element,
          OrderHistoryModel Function(XmlElement el) process) =>
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
        return OrderHistoryList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return OrderHistoryList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return OrderHistoryList.fromJson({});
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
    return {
      "id": "ID",
      "idEmployee": "Id empleado",
      "idOrder": "Id orden",
      "idOrderState": "Id estado",
      "dateAdd": "Fecha",
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
        "idEmployee": idEmployee,
        "idOrder": idOrder,
        "idOrderState": idOrderState,
        "dateAdd": dateAdd,
      };

  XmlDocument toXml() {
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element('prestashop', nest: () {
      builder.attribute('xmlns:xlink', 'http://www.w3.org/1999/xlink');
      builder.element('order_history', nest: () {
        builder.element('id', nest: () {
          if (id != null) {
            builder.text(id);
          }
        });

        builder.element('id_employee', nest: () {
          if (idEmployee != null) {
            builder.text(idEmployee);
          }
        });

        builder.element('id_order_state', nest: () {
          if (idOrderState != null) {
            builder.text(idOrderState);
          }
        });

        builder.element('id_order', nest: () {
          if (idOrder != null) {
            builder.text(idOrder);
          }
        });

        builder.element('date_add', nest: () {
          if (dateAdd != null) {
            builder.text(dateAdd);
          }
        });
      });
    });
    final document = builder.buildDocument();
    return document;
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
}
