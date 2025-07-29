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
import '../entities/customer.dart';

CustomerList customerListModelFromJson(String str) =>
    CustomerList.fromJson(json.decode(str));

CustomerModel customerModelFromJson(String str) =>
    CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerList<T extends CustomerModel> implements EntityModelList<T> {
  final List<T> customers;

  CustomerList({
    required this.customers,
  });

  factory CustomerList.fromJson(Map<String, dynamic> json) => CustomerList(
        customers: List<T>.from(
            json["customers"].map((x) => CustomerModel.fromJson(x))),
      );

  factory CustomerList.fromStringJson(String strJson) => CustomerList(
        customers: List<T>.from(json
            .decode(strJson)["customers"]
            .map((x) => CustomerModel.fromJson(x))),
      );

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return CustomerList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!customers.contains(element)) customers.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return CustomerList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => customers;

  Map<String, dynamic> toJson() => {
        "customers": List<dynamic>.from(customers.map((x) => x.toJson())),
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

class CustomerModel extends Customer implements EntityModel {
  @override
  final dynamic id;
  @override
  final String firstName, lastName, email, userName, dni;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  CustomerModel({
    this.id,
    required this.firstName,
    required this.lastName,
    this.userName = "Sin usuario",
    this.email = "Sin correo",
    this.dni = "Sin dni",
  }) : super(
          id: id,
          dni: dni,
          email: email,
          firstName: firstName,
          lastName: lastName,
          userName: userName,
        );

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: getValueFrom("id", json, "Sin id"),
        dni: getValueFrom("dni", json, "Sin dni"),
        email: getValueFrom("email", json, "Sin correo"),
        firstName: getValueFrom("firstName", json, "Sin nombre"),
        lastName: getValueFrom("lastName", json, "Sin apellidos"),
        userName: getValueFrom("userName", json, "Sin usuario"),
      );

  factory CustomerModel.fromXml(
          XmlElement element, CustomerModel Function(XmlElement el) process) =>
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
        return CustomerList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return CustomerList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return CustomerList.fromJson({});
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
      "dni": "Documento de Identidad",
      "email": "Correo",
      "firstName": "Nombre",
      "lastName": "Apellidos",
      "userName": "Usuario",
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

  String getFullName() {
    return "$firstName $lastName";
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
        "dni": dni,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "userName": userName,
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
      String key, Map<String, dynamic> json, dynamic defaultValue) {
    if (defaultValue != null && defaultValue is ServerException) {
      throw defaultValue;
    }
    try {
      return EntityModel.getValueFromJson<T>(key, json, defaultValue);
    } on Exception {
      throw CastErrorException();
    }
  }
}
