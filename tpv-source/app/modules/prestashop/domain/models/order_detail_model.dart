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
import '../entities/order_detail.dart';

OrderDetailList orderDetailListModelFromJson(String str) =>
    OrderDetailList.fromJson(json.decode(str));

OrderDetailModel orderDetailModelFromJson(String str) =>
    OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) =>
    json.encode(data.toJson());

class OrderDetailList<T extends OrderDetailModel>
    implements EntityModelList<T> {
  final List<T> order_details;

  OrderDetailList({
    required this.order_details,
  });

  factory OrderDetailList.fromJson(Map<String, dynamic> json) =>
      OrderDetailList(
        order_details: List<T>.from(
            json["order_details"].map((x) => OrderDetailModel.fromJson(x))),
      );

  factory OrderDetailList.fromStringJson(String strJson) =>
      OrderDetailList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return OrderDetailList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!order_details.contains(element)) order_details.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return OrderDetailList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => order_details;

  Map<String, dynamic> toJson() => {
        "order_details":
            List<dynamic>.from(order_details.map((x) => x.toJson())),
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

class OrderDetailModel extends OrderDetail implements EntityModel {
  @override
  @override
  @override
  final int? idOrderDetail, idOrder, idProduct;
  @override
  final String? productName;
  @override
  final int? productQuantity;
  @override
  final double? productPrice;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  OrderDetailModel({
    this.idOrderDetail,
    this.idOrder,
    this.idProduct,
    this.productName,
    this.productPrice,
    this.productQuantity,
  }) : super(
          idOrderDetail: idOrderDetail,
          idOrder: idOrder,
          idProduct: idProduct,
          productName: productName,
          productPrice: productPrice,
          productQuantity: productQuantity,
        );

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailModel(
        idOrderDetail:
            EntityModel.getValueFromJson("idOrderDetail", json, null),
        idOrder: EntityModel.getValueFromJson("idOrder", json, null),
        idProduct: EntityModel.getValueFromJson("idProduct", json, null),
        productName: EntityModel.getValueFromJson("productName", json, null),
        productPrice: EntityModel.getValueFromJson("productPrice", json, null),
        productQuantity:
            EntityModel.getValueFromJson("productQuantity", json, null),
      );

  factory OrderDetailModel.fromXml(XmlElement element,
          OrderDetailModel Function(XmlElement el) process) =>
      process(element);

  factory OrderDetailModel.loadFromXml(XmlElement element) =>
      OrderDetailModel.fromXml(element, (el) {
        return OrderDetailModel(
          idOrderDetail: int.parse(el.getElement("id")!.text),
          idOrder: int.parse(el.getElement("id_order")!.text),
          idProduct: int.parse(el.getElement("product_id")!.text),
          productName: el.getElement("product_name")!.text,
          productPrice: double.parse(el.getElement("product_price")!.text),
          productQuantity: int.parse(el.getElement("product_quantity")!.text),
        );
      });

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
        return OrderDetailList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return OrderDetailList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return OrderDetailList.fromJson({});
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
    return {"idOrderDetail": "ID"};
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
        "idOrderDetail": idOrderDetail,
        "idOrder": idOrder,
        "idProduct": idProduct,
        "productName": productName,
        "productPrice": productPrice,
        "productQuantity": productQuantity,
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
}
