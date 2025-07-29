// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

// ignore_for_file: overridden_fields, empty_catches

import 'dart:async';
import 'dart:convert';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../../../../../app/core/services/logger_service.dart';
import '../entities/api.dart';

ApiList apiListModelFromJson(String str) => ApiList.fromJson(json.decode(str));

ApiModel apiModelFromJson(String str) => ApiModel.fromJson(json.decode(str));

String apiModelToJson(ApiModel data) => json.encode(data.toJson());

class ApiList<T extends ApiModel> implements EntityModelList<T> {
  final List<T> apis;

  ApiList({
    required this.apis,
  });

  factory ApiList.fromEmpty() => ApiList(
        apis: List<T>.from([
          {
            "name": "enzona",
            "schema": "https",
            "hostname": "enzona.net",
            "endpoint": "enzona",
            "version": "v1.0.0"
          },
          {
            "name": "identity",
            "schema": "https",
            "hostname": "identity.enzona.net",
            "endpoint": "identity",
            "version": "v1.0.0"
          },
          {
            "name": "media",
            "schema": "https",
            "hostname": "media.enzona.net",
            "endpoint": "media",
            "version": "v1.0.0"
          },
          {
            "name": "nomenclator",
            "schema": "https",
            "hostname": "api.enzona.net",
            "endpoint": "nomenclator",
            "version": "v1.0.0"
          }
        ].map((x) => ApiModel.fromJson(x))),
      );

  factory ApiList.fromJson(Map<String, dynamic> json) => ApiList(
        apis: json.containsKey("apis")
            ? List<T>.from(json["apis"].map((x) => ApiModel.fromJson(x)))
            : [],
      );

  factory ApiList.fromStringJson(String strJson) => ApiList(
        apis: List<T>.from(
            json.decode(strJson)["apis"].map((x) => ApiModel.fromJson(x))),
      );

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return ApiList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!apis.contains(element)) apis.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return ApiList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => apis;

  Map<String, dynamic> toJson() => {
        "apis": List<dynamic>.from(apis.map((x) => x.toJson())),
      };
}

class ApiModel extends Api implements EntityModel {
  @override
  final String name;

  @override
  final String schema;

  @override
  final String hostname;

  @override
  final String endpoint;
  @override
  final String version;
  @override
  Map<String, ColumnMetaModel>? metaModel;
  ApiModel({
    required this.name,
    required this.hostname,
    required this.schema,
    required this.endpoint,
    required this.version,
  }) : super(
          name: name,
          hostname: hostname,
          schema: schema,
          endpoint: endpoint,
          version: version,
        );
  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
        name: json["name"],
        hostname: json["hostname"],
        schema: json["schema"],
        endpoint: json["endpoint"],
        version: json["version"],
      );
  @override
  Map<String, ColumnMetaModel>? get getMetaModel => getColumnMetaModel();

  List<Object?> get props => [];

  @override
  set setMetaModel(Map<String, ColumnMetaModel> newMetaModel) {
    metaModel = newMetaModel;
  }

  bool? get stringify => true;

  T cloneWith<T extends EntityModel>(T other) {
    return ApiModel.fromJson(other.toJson()) as T;
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return ApiList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return ApiList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return ApiList.fromJson({});
  }

  T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
    return ApiModel.fromJson(params) as T;
  }

  @override
  Map<String, ColumnMetaModel> getColumnMetaModel() {
    // TODO: implement getColumnMetaModel
    throw UnimplementedError();
  }

  @override
  Map<String, String> getColumnNames() {
    return {
      "name": "Nombre",
      "hostname": "Nombre de Host",
      "schema": "Esquema",
      "endpoint": "Punto de Acceso",
      "version": "Versión"
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
    // TODO: implement getVisibleColumnNames
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "hostname": hostname,
        "schema": schema,
        "endpoint": endpoint,
        "version": version,
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
