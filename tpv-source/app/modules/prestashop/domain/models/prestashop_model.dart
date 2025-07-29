// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches

import 'dart:async';
import 'dart:convert';

import '/app/core/services/logger_service.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/prestashop.dart';

PrestaShopList prestashopListModelFromJson(String str) =>
    PrestaShopList.fromJson(json.decode(str));

PrestaShopModel prestashopModelFromJson(String str) =>
    PrestaShopModel.fromJson(json.decode(str));

String prestashopModelToJson(PrestaShopModel data) =>
    json.encode(data.toJson());

class PrestaShopList<T extends PrestaShopModel> implements EntityModelList<T> {
  final List<T> prestashops;

  PrestaShopList({
    required this.prestashops,
  });

  factory PrestaShopList.fromJson(Map<String, dynamic> json) => PrestaShopList(
        prestashops: List<T>.from(
            json["prestashops"].map((x) => PrestaShopModel.fromJson(x))),
      );

  factory PrestaShopList.fromStringJson(String strJson) => PrestaShopList(
        prestashops: List<T>.from(json
            .decode(strJson)["prestashops"]
            .map((x) => PrestaShopModel.fromJson(x))),
      );

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return PrestaShopList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!prestashops.contains(element)) prestashops.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return PrestaShopList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => prestashops;

  Map<String, dynamic> toJson() => {
        "prestashops": List<dynamic>.from(prestashops.map((x) => x.toJson())),
      };
}

class PrestaShopModel extends PrestaShop implements EntityModel {
  @override
  final String idPrestaShop;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  PrestaShopModel({
    required this.idPrestaShop,
  }) : super(
          idPrestaShop: idPrestaShop,
        );

  factory PrestaShopModel.fromJson(Map<String, dynamic> json) =>
      PrestaShopModel(
        idPrestaShop: json["id_prestashop"],
      );

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
        return PrestaShopList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return PrestaShopList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return PrestaShopList.fromJson({});
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
    return {"id_prestashop": "ID"};
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
        "id_prestashop": idPrestaShop,
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

  static T? getValueFrom<T>(
      String key, Map<dynamic, dynamic> json, T? defaultValue,
      {JsonReader<T?>? reader}) {
    return EntityModel.getValueFromJson<T?>(key, json, defaultValue,
        reader: reader);
  }
}
