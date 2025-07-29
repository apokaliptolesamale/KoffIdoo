// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import 'package:xml/xml.dart';

import '/globlal_constants.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/idp.dart';

IdpList idpListModelFromJson(String str) => IdpList.fromJson(json.decode(str));

IdpModel idpModelFromJson(String str) => IdpModel.fromJson(json.decode(str));

String idpModelToJson(IdpModel data) => json.encode(data.toJson());

class IdpList<T extends IdpModel> implements EntityModelList<T> {
  final List<T> idps;

  IdpList({
    this.idps = const [],
  });

  factory IdpList.fromEmpty() => IdpList(
        idps: List<T>.from([].map((x) => IdpList.fromJson(x))),
      );

  factory IdpList.fromJson(Map<String, dynamic> json) => IdpList(
        idps: List<T>.from(json["idps"].map((x) => IdpModel.fromJson(x))),
      );

  factory IdpList.fromStringJson(String strJson) =>
      IdpList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return IdpList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!idps.contains(element)) idps.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return IdpList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => idps;

  Map<String, dynamic> toJson() => {
        "idps": List<dynamic>.from(idps.map((x) => x.toJson())),
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
class IdpModel extends Idp implements EntityModel {
  @override
  final String key;

  @override
  final String consumerKey;

  @override
  final String? consumerSecret;

  @override
  final bool ignoreOnError, active;
  @override
  String? domain;
  @override
  String? redirectUri;
  @override
  String? authDomain;
  @override
  String? authIssuer;
  @override
  String? authorizationEndpoint;
  @override
  String? tokenEndpoint;
  @override
  String? endSessionEndpoint;
  @override
  String? userinfoEndpoint;
  @override
  final List<String> scopes;
  @override
  final bool withPkce;
  @override
  Map<String, ColumnMetaModel>? metaModel;
  IdpModel({
    this.key = "",
    this.consumerKey = "",
    this.consumerSecret,
    this.ignoreOnError = false,
    this.active = false,
    this.domain = "",
    this.redirectUri = "",
    this.authDomain = "",
    this.authIssuer = "",
    this.authorizationEndpoint = "",
    this.tokenEndpoint = "",
    this.endSessionEndpoint = "",
    this.userinfoEndpoint = "",
    this.scopes = const [],
    this.withPkce = false,
  }) : super(
          key: key,
          consumerKey: consumerKey,
          consumerSecret: consumerSecret,
          active: active,
          ignoreOnError: ignoreOnError,
          domain: domain,
          redirectUri: redirectUri,
          authDomain: authDomain,
          authIssuer: authIssuer,
          authorizationEndpoint: authorizationEndpoint,
          tokenEndpoint: tokenEndpoint,
          endSessionEndpoint: endSessionEndpoint,
          userinfoEndpoint: userinfoEndpoint,
          scopes: scopes,
          withPkce: withPkce,
        ) {
    domain = domain == null || (domain != null && domain!.isEmpty)
        ? "enzona.net"
        : domain;
    authDomain =
        authDomain == null || (authDomain != null && authDomain!.isEmpty)
            ? "$key.$domain"
            : authDomain;
    authIssuer =
        authIssuer == null || (authIssuer != null && authIssuer!.isEmpty)
            ? "https://$authDomain"
            : authIssuer;
    redirectUri =
        redirectUri == null || (redirectUri != null && redirectUri!.isEmpty)
            ? "$globalApplicationId://apk-callback"
            : redirectUri;
    authorizationEndpoint = authorizationEndpoint != null &&
            !authorizationEndpoint!.startsWith(authIssuer!)
        ? "$authIssuer$authorizationEndpoint"
        : authorizationEndpoint;
    tokenEndpoint =
        tokenEndpoint != null && !tokenEndpoint!.startsWith(authIssuer!)
            ? "$authIssuer$tokenEndpoint"
            : tokenEndpoint;
    endSessionEndpoint = endSessionEndpoint != null &&
            !endSessionEndpoint!.startsWith(authIssuer!)
        ? "$authIssuer$endSessionEndpoint"
        : endSessionEndpoint;

    userinfoEndpoint =
        userinfoEndpoint != null && !userinfoEndpoint!.startsWith(authIssuer!)
            ? "$authIssuer$userinfoEndpoint"
            : userinfoEndpoint;
  }
  factory IdpModel.fromJson(Map<String, dynamic> json) => IdpModel(
        key: getValueFrom("key", json, "idp"),
        consumerKey: getValueFrom("consumerKey", json, ""),
        consumerSecret: getValueFrom("consumerSecret", json, null),
        ignoreOnError: getValueFrom(
          "ignoreOnError",
          json,
          false,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) return data[key].toString() == "true";
            return false;
          },
        ),
        active: getValueFrom(
          "active",
          json,
          false,
          reader: (key, data, defaultValue) {
            if (data.containsKey(key)) return data[key].toString() == "true";
            return false;
          },
        ),
        domain: getValueFrom("domain", json, "enzona.net"),
        redirectUri: getValueFrom(
            "redirectUri", json, "$globalApplicationId://apk-callback"),
        authDomain: getValueFrom("authDomain", json, ""),
        authIssuer: getValueFrom("authIssuer", json, ""),
        authorizationEndpoint:
            getValueFrom("authorizationEndpoint", json, "/authorize"),
        tokenEndpoint: getValueFrom("tokenEndpoint", json, "/token"),
        endSessionEndpoint: getValueFrom("endSessionEndpoint", json, "/logout"),
        userinfoEndpoint: getValueFrom("userinfoEndpoint", json, "/userinfo"),
        scopes: getValueFrom("scopes", json, [
          'openid',
          'openid apim:subscribe',
          'email',
          'offline_access',
          'api'
        ]),
        withPkce: getValueFrom("withPkce", json, false),
      );
  factory IdpModel.fromXml(
          XmlElement element, IdpModel Function(XmlElement el) process) =>
      process(element);
  @override
  Map<String, ColumnMetaModel>? get getMetaModel => getColumnMetaModel();

  List<Object?> get props => [];

  @override
  set setMetaModel(Map<String, ColumnMetaModel> newMetaModel) {
    metaModel = newMetaModel;
  }

  bool? get stringify => true;

  //method generated by wizard
  @override
  T cloneWith<T extends EntityModel>(T other) {
    return IdpModel.fromJson(other.toJson()) as T;
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return IdpList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return IdpList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return IdpList.fromJson({});
  }

  @override
  T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
    return IdpModel.fromJson(params) as T;
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
    return {
      "key": "Identificador",
      "consumerKey": "Llave",
      "consumerSecret": "Clave",
      "domain": "Dominio",
      "redirectUri": "Url de CallBack",
      "authDomain": "Dominio de authenticación",
      "authIssuer": "authIssuer",
      "authorizationEndpoint": "Url de autorización",
      "tokenEndpoint": "Url de tokenización",
      "endSessionEndpoint": "Url de logout",
      "scopes": "Scopes",
      "withPkce": "Modo",
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
        "key": key,
        "consumerKey": consumerKey,
        "consumerSecret": consumerSecret,
        "active": active,
        "ignoreOnError": ignoreOnError,
        "domain": domain,
        "redirectUri": redirectUri,
        "authDomain": authDomain,
        "authIssuer": authIssuer,
        "authorizationEndpoint": authorizationEndpoint,
        "tokenEndpoint": tokenEndpoint,
        "endSessionEndpoint": endSessionEndpoint,
        "userinfoEndpoint": userinfoEndpoint,
        "scopes": scopes,
        "withPkce": withPkce.toString(),
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
    String key,
    dynamic json,
    T defaultValue, {
    JsonReader<T>? reader,
    Caster<T>? cast,
  }) {
    return EntityModel.getValueFromJson<T>(key, json, defaultValue,
        reader: reader, cast: cast);
  }
}
