// To parse this JSON data, do
//
//     final destinatario = destinatarioFromJson(jsonString);

import 'dart:convert';

import '/app/core/interfaces/entity_model.dart';
import 'package:xml/xml.dart';

import '../entities/destinatario.dart';

DestinatarioList destinatarioListModelFromJson(String str) =>
    DestinatarioList.fromJson(json.decode(str));

class DestinatarioList<T extends DestinatarioModel>
    implements EntityModelList<T> {
  final List<T> destinatarios;

  DestinatarioList({
    required this.destinatarios,
  });

  factory DestinatarioList.fromJson(Map<String, dynamic> json) =>
      DestinatarioList(
        destinatarios: List<T>.from(
            json["accounts"].map((x) => DestinatarioModel.fromJson(x))),
      );

  factory DestinatarioList.fromStringJson(String strJson) =>
      DestinatarioList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return DestinatarioList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!destinatarios.contains(element)) destinatarios.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return DestinatarioList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => destinatarios;

  Map<String, dynamic> toJson() => {
        "destinatarios":
            List<dynamic>.from(destinatarios.map((x) => x.toJson())),
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

DestinatarioModel destinatarioFromJson(String str) =>
    DestinatarioModel.fromJson(json.decode(str));

String destinatarioToJson(DestinatarioModel data) => json.encode(data.toJson());

class DestinatarioModel extends Destinatario implements EntityModel {
  DestinatarioModel({
    required this.pan,
    required this.name,
    required this.phone,
    required this.last4,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.uuid,
    required this.bankCode,
  }) : super(
            createdAt: createdAt,
            last4: last4,
            name: name,
            pan: pan,
            phone: phone,
            status: status,
            updatedAt: updatedAt,
            bankCode: bankCode,
            uuid: uuid);

  @override
  String pan;
  @override
  String name;
  @override
  String phone;
  @override
  String last4;
  @override
  String createdAt;
  @override
  String updatedAt;
  @override
  String status;
  @override
  String uuid;
  @override
  String bankCode;

  factory DestinatarioModel.fromJson(Map<String, dynamic> json) =>
      DestinatarioModel(
        pan: json.containsKey("pan") && json["pan"] != null
            ? json["pan"].toString()
            : "",
        name: json.containsKey("name") && json["name"] != null
            ? json["name"]
            : "",
        phone: json.containsKey("phone") && json["phone"] != null
            ? json["phone"].toString()
            : "",
        last4: json.containsKey("last4") && json["last4"] != null
            ? json["last4"].toString()
            : "",
        createdAt: json.containsKey("createAt") && json["createAt"] != null
            ? json["createAt"].toString()
            : "",
        updatedAt: json.containsKey("updateAt") && json["updateAt"] != null
            ? json["updateAt"].toString()
            : "",
        status: json.containsKey("status") && json["status"] != null
            ? json["status"].toString()
            : "",
        uuid: json.containsKey("uuid") && json["uuid"] != null
            ? json["uuid"].toString()
            : "",
        bankCode: json.containsKey("bankCode") && json["bankCode"] != null
            ? json["bankCode"].toString()
            : "",
      );

  @override
  Map<String, dynamic> toJson() => {
        "pan": pan,
        "name": name,
        "phone": phone,
        "last4": last4,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "status": status,
        "uuid": uuid,
        "bankCode": bankCode,
      };

  @override
  Map<String, ColumnMetaModel>? metaModel;

  @override
  EntityModelList createModelListFrom(data) {
    // TODO: implement createModelListFrom
    throw UnimplementedError();
  }

  @override
  Map<String, ColumnMetaModel> getColumnMetaModel() {
    // TODO: implement getColumnMetaModel
    throw UnimplementedError();
  }

  @override
  Map<String, String> getColumnNames() {
    // TODO: implement getColumnNames
    throw UnimplementedError();
  }

  @override
  List<String> getColumnNamesList() {
    // TODO: implement getColumnNamesList
    throw UnimplementedError();
  }

  @override
  Map<K1, V1> getMeta<K1, V1>(String searchKey, searchValue) {
    // TODO: implement getMeta
    throw UnimplementedError();
  }

  @override
  // TODO: implement getMetaModel
  Map<String, ColumnMetaModel>? get getMetaModel => throw UnimplementedError();

  @override
  Map<String, String> getVisibleColumnNames() {
    // TODO: implement getVisibleColumnNames
    throw UnimplementedError();
  }

  @override
  set setMetaModel(Map<String, ColumnMetaModel> metaModel) {
    // TODO: implement setMetaModel
  }

  @override
  Map<String, ColumnMetaModel> updateColumnMetaModel(
      String keySearch, valueSearch, newValue) {
    // TODO: implement updateColumnMetaModel
    throw UnimplementedError();
  }
}
