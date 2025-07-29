// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

// ignore_for_file: overridden_fields, empty_catches

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/app/core/constants/constants.dart';
import '/app/core/interfaces/entity_model.dart';
import '/app/core/services/local_storage.dart';
import '/app/core/services/logger_service.dart';
import '/app/core/services/manager_authorization_service.dart';
import '/app/modules/config/domain/models/design_model.dart';
import '/app/modules/config/domain/models/idp_model.dart';
import '/globlal_constants.dart';
import '../../../../widgets/utils/custom_datetime_converter.dart';
import '../entities/config.dart';
import 'api_model.dart';
import 'app_model.dart';

ConfigList configListModelFromJson(Map<String, dynamic> json) =>
    ConfigList.fromJson(json);

ConfigList configListModelFromStr(String str) =>
    ConfigList.fromJson(json.decode(str));

ConfigModel configModelFromJson(String str) =>
    ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigList<T extends ConfigModel> implements EntityModelList<T> {
  final List<T> configs;

  ConfigList({
    required this.configs,
  });

  factory ConfigList.empty() => ConfigList(
        configs: [],
      );

  factory ConfigList.fromJson(Map<String, dynamic> json) => ConfigList(
        configs:
            List<T>.from(json["configs"].map((x) => ConfigModel.fromJson(x))),
      );

  factory ConfigList.fromStringJson(String strJson) => ConfigList(
        configs: List<T>.from(json
            .decode(strJson)["configs"]
            .map((x) => ConfigModel.fromJson(x))),
      );

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return ConfigList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!configs.contains(element)) configs.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return ConfigList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => configs;

  Map<String, dynamic> toJson() => {
        "configs": List<dynamic>.from(configs.map((x) => x.toJson())),
      };
}

class ConfigModel extends Config implements EntityModel {
  //
  @override
  final String name;

  @override
  final String logLevel;

  @override
  final List<ApiModel> apis;

  @override
  final List<IdpModel> idps;
  @override
  final AppModel app;
  @override
  final DateTime createAt;
  @override
  DateTime updateAt;
  @override
  String loginRoute;
  @override
  String indexRoute;
  @override
  final String homePageRoute;
  @override
  final bool useSystemProxy;

  @override
  final String localProxy;

  //Para chequear la conectividad antes de iniciar la app
  @override
  final bool useTestConnection;

  @override
  final String urlConnectionTest;

  @override
  DesignModel? design;

  @override
  Map<String, ColumnMetaModel>? metaModel;
  ConfigModel({
    required this.name,
    required this.createAt,
    required this.updateAt,
    required this.apis,
    required this.idps,
    required this.app,
    required this.loginRoute,
    required this.homePageRoute,
    required this.indexRoute,
    this.design,
    this.logLevel = "ALL",
    this.useSystemProxy = true,
    this.localProxy = "",
    this.urlConnectionTest = Constants.redirectUri,
    this.useTestConnection = true,
  }) : super(
          name: name,
          createAt: createAt,
          updateAt: updateAt,
          apis: apis,
          idps: idps,
          design: design,
          app: app,
          loginRoute: loginRoute,
          indexRoute: indexRoute,
          homePageRoute: homePageRoute,
          logLevel: logLevel,
          useSystemProxy: useSystemProxy,
          localProxy: localProxy,
          useTestConnection: useTestConnection,
          urlConnectionTest: urlConnectionTest,
        );
  factory ConfigModel.fromEmpty() => ConfigModel(
        name: "ENZONA",
        loginRoute: "/",
        homePageRoute: "/",
        indexRoute: "/",
        logLevel: "NONE",
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        apis: ApiList.fromEmpty().apis,
        design: DesignModel.fromEmpty(),
        idps: IdpList.fromEmpty().idps,
        app: AppModel.fromEmpty(),
      );

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    final result = json.isNotEmpty
        ? ConfigModel(
            name: json["name"],
            loginRoute:
                EntityModel.getValueFromJson("loginRoute", json, "/security"),
            homePageRoute:
                EntityModel.getValueFromJson("homePageRoute", json, "/"),
            indexRoute: EntityModel.getValueFromJson("indexRoute", json, "/"),
            logLevel: EntityModel.getValueFromJson("logLevel", json, "all"),
            localProxy: EntityModel.getValueFromJson("localProxy", json, ""),
            createAt: CustomDateTimeConverter().fromJson(json["createAt"]),
            updateAt: CustomDateTimeConverter().fromJson(json["updateAt"]),
            urlConnectionTest: EntityModel.getValueFromJson(
              "urlConnectionTest",
              json,
              Constants.redirectUri,
            ),
            useTestConnection:
                EntityModel.getValueFromJson("useTestConnection", json, true),
            apis: ApiList.fromJson(json).apis,
            idps: IdpList.fromJson(json).idps,
            app: AppModel.fromJson(json["app"]),
            design: EntityModel.getValueFromJson(
              "design",
              json,
              null,
              reader: (key, data, defaultValue) {
                if (data is Map && data.containsKey(key)) {
                  var tmp = [];
                  tmp = data[key] is Map &&
                          (data[key] as Map).containsKey("design") &&
                          (data[key] as Map)["design"] is List &&
                          (tmp = (data[key] as Map)["design"] as List)
                              .isNotEmpty
                      ? tmp
                      : [];
                  return tmp.isNotEmpty
                      ? DesignModel.fromJson(tmp.elementAt(0))
                      : defaultValue;
                }
                return defaultValue;
              },
            ),
          )
        : ConfigModel.fromEmpty();
    return result;
  }

  factory ConfigModel.fromLocalStorage() {
    final service = ManagerAuthorizationService().get(defaultIdpKey);
    if (service != null) {
      var sys = service.get("sys_config", {});
      return service.hasData("sys_config") && sys is String
          ? ConfigModel.fromStringJson(sys)
          : ConfigModel.fromJson(sys);
    }
    return ConfigModel.fromEmpty();
  }
  factory ConfigModel.fromStringJson(String stringJson) =>
      ConfigModel.fromJson(json.decode(stringJson));

  @override
  Map<String, ColumnMetaModel>? get getMetaModel => getColumnMetaModel();

  List<Object?> get props => [];
  @override
  set setMetaModel(Map<String, ColumnMetaModel> newMetaModel) {
    metaModel = newMetaModel;
  }

  bool? get stringify => true;

  T cloneWith<T extends EntityModel>(T other) {
    return ConfigModel.fromJson(other.toJson()) as T;
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return ConfigList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return ConfigList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return ConfigList.fromJson({});
  }

  T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
    return ConfigModel.fromJson(params) as T;
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
      "logLevel": "Nivel de Log",
      "createAt": "Fecha de creación",
      "updateAt": "Fecha de actualización",
      "apis": "Apis",
      "app": "Aplicación",
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

  Color getSecundaryColor() =>
      design != null ? design!.getSecundaryColor() : Colors.transparent;

  Color getTertiaryColor() =>
      design != null ? design!.getTertiaryColor() : Colors.transparent;

  @override
  Map<String, String> getVisibleColumnNames() {
    // TODO: implement getVisibleColumnNames
    throw UnimplementedError();
  }

  Future<ConfigModel> loadDesignFromAssets(String file) async {
    design = await DesignModel.loadFromAssets(file);
    return this;
  }

  DesignModel loadDesignFromMap(Map<String, dynamic> config) {
    return design = DesignModel.fromJson(config);
  }

  save() {
    updateAt = DateTime.now();
    final contents = jsonEncode(toJson());
    LocalSecureStorage.storage.write("sys_config", contents);
  }

  @override
  Map<String, dynamic> toJson() {
    final apisList =
        List<Map<String, dynamic>>.from(apis.map((e) => e.toJson()));

    final idpList =
        List<Map<String, dynamic>>.from(idps.map((e) => e.toJson()));
    //
    final Map<String, dynamic> source = {
      "name": name,
      "indexRoute": indexRoute,
      "homePageRoute": homePageRoute,
      "loginRoute": loginRoute,
      "logLevel": logLevel,
      "createAt": createAt.toString(),
      "updateAt": updateAt.toString(),
      "apis": apisList,
      "design": design != null ? design!.toJson() : null,
      "idps": idpList,
      "app": app.toJson(),
    };
    source.removeWhere((key, value) => value == null);
    return source;
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

  static Future<ConfigModel> getFromAssets(String url) async {
    final stringJson = await _readFileAsync(url);
    return Future.value(ConfigModel.fromStringJson(stringJson));
  }

  static ConfigModel getFromLocalStorage() => ConfigModel.fromLocalStorage();

  static T? getValueFrom<T>(
      String key, Map<dynamic, dynamic> json, T? defaultValue,
      {JsonReader<T?>? reader}) {
    return EntityModel.getValueFromJson<T?>(key, json, defaultValue,
        reader: reader);
  }

  static Future<String> _readFileAsync(
    String path, {
    cache = true,
  }) {
    return rootBundle.loadString(
      path,
      cache: cache,
    );
  }
}
