// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches

import 'dart:async';
import 'dart:convert';

import '/app/core/services/logger_service.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/client.dart';

ClientList clientListModelFromJson(String str) =>
    ClientList.fromJson(json.decode(str));

ClientModel clientModelFromJson(String str) =>
    ClientModel.fromJson(json.decode(str));

String clientModelToJson(ClientModel data) => json.encode(data.toJson());

class ClientList<T extends ClientModel> implements EntityModelList<T> {
  final List<T> clients;

  ClientList({
    required this.clients,
  });

  factory ClientList.fromJson(Map<String, dynamic> json) => ClientList(
        clients:
            List<T>.from(json["clients"].map((x) => ClientModel.fromJson(x))),
      );

  factory ClientList.fromStringJson(String strJson) => ClientList(
        clients: List<T>.from(json
            .decode(strJson)["clients"]
            .map((x) => ClientModel.fromJson(x))),
      );

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return ClientList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!clients.contains(element)) clients.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return ClientList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => clients;

  Map<String, dynamic> toJson() => {
        "clients": List<dynamic>.from(clients.map((x) => x.toJson())),
      };
}

class ClientModel extends Client implements EntityModel {
  @override
  final String idClient;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  ClientModel({
    required this.idClient,
  }) : super(
          idClient: idClient,
        );

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        idClient: json["id_client"],
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
        return ClientList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return ClientList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return ClientList.fromJson({});
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
    return {"id_client": "ID"};
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
        "id_client": idClient,
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
