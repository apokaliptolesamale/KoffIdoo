// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member, annotate_overrides

import 'dart:async';
import 'dart:convert';

import 'package:xml/xml.dart';

import '/app/core/services/logger_service.dart';
import '/app/modules/prestashop/domain/entities/customer.dart';
import '/app/modules/prestashop/domain/models/customer_model.dart';
import '../../../../../../../../../app/core/config/errors/exceptions.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/address.dart';

AddressList addressListModelFromJson(String str) =>
    AddressList.fromJson(json.decode(str));

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressList<T extends AddressModel> implements EntityModelList<T> {
  final List<T> addresss;

  AddressList({
    required this.addresss,
  });

  factory AddressList.fromJson(Map<String, dynamic> json) => AddressList(
        addresss:
            List<T>.from(json["addresss"].map((x) => AddressModel.fromJson(x))),
      );

  factory AddressList.fromStringJson(String strJson) => AddressList(
        addresss: List<T>.from(json
            .decode(strJson)["addresss"]
            .map((x) => AddressModel.fromJson(x))),
      );

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return AddressList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!addresss.contains(element)) addresss.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return AddressList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => addresss;

  Map<String, dynamic> toJson() => {
        "addresss": List<dynamic>.from(addresss.map((x) => x.toJson())),
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

class AddressModel extends Address implements EntityModel {
  @override
  @override
  @override
  dynamic idAddress, idCountry, idState;
  @override
  @override
  @override
  String alias, address, city;
  @override
  String? postcode;
  @override
  DateTime createAt;
  @override
  DateTime? updateAt;

  Customer custormer;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  AddressModel({
    required this.alias,
    required this.city,
    required this.address,
    required this.createAt,
    required this.custormer,
    this.updateAt,
    this.postcode,
    this.idAddress,
    this.idCountry,
    this.idState,
  }) : super(
          idAddress: idAddress,
          idCountry: idCountry,
          idState: idState,
          custormer: custormer,
          alias: alias,
          city: city,
          address: address,
          createAt: createAt,
          updateAt: updateAt,
          postcode: postcode,
        );

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        idAddress: json["idAddress"],
        idCountry: getValueFrom("idCountry", json, null),
        idState: getValueFrom("idState", json, null),
        custormer: CustomerModel.fromJson(json),
        alias: getValueFrom("alias", json, RequiredTypeErrorException()),
        city: getValueFrom("city", json, RequiredTypeErrorException()),
        address: getValueFrom("address", json, RequiredTypeErrorException()),
        createAt: getValueFrom("createAt", json, RequiredTypeErrorException()),
        updateAt: getValueFrom("updateAt", json, DateTime.now()),
        postcode: getValueFrom("postcode", json, null),
      );

  factory AddressModel.fromXml(
          XmlElement element, AddressModel Function(XmlElement el) process) =>
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
        return AddressList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return AddressList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return AddressList.fromJson({});
  }

  String getBeneficiary() {
    return "${custormer.firstName} ${custormer.lastName}";
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
      "idAddress": "ID",
      "idCountry": "Provincia",
      "idState": "Municipio",
      "alias": "Alias",
      "city": "Ciudad",
      "address": "Dirección",
      "createAt": "Creación",
      "updateAt": "Modificación",
      "postcode": "Código postal",
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
        "idAddress": idAddress,
        "idCountry": idCountry,
        "idState": idState,
        "alias": alias,
        "city": city,
        "address": address,
        "createAt": createAt,
        "updateAt": updateAt,
        "postcode": postcode,
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
