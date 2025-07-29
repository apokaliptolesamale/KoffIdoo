// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import '/app/core/config/assets.dart';
import '/app/core/helpers/functions.dart';
import '/app/modules/security/domain/models/role_model.dart';
import 'package:xml/xml.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/rbac.dart';
import '../entities/role.dart';
import 'user_model.dart';

RbacList rbacListModelFromJson(String str) =>
    RbacList.fromJson(json.decode(str));

RbacModel rbacModelFromJson(String str) => RbacModel.fromJson(json.decode(str));

String rbacModelToJson(RbacModel data) => json.encode(data.toJson());

class RbacList<T extends RbacModel> implements EntityModelList<T> {
  final List<T> rbacs;

  RbacList({
    this.rbacs = const [],
  });

  factory RbacList.fromEmpty() => RbacList(
        rbacs: List<T>.from([].map((x) => RbacList.fromJson(x))),
      );

  factory RbacList.fromJson(Map<String, dynamic> json) => RbacList(
        rbacs: List<T>.from(json["rbacs"].map((x) => RbacModel.fromJson(x))),
      );

  factory RbacList.fromStringJson(String strJson) =>
      RbacList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return RbacList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!rbacs.contains(element)) rbacs.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return RbacList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => rbacs;

  Map<String, dynamic> toJson() => {
        "rbacs": List<dynamic>.from(rbacs.map((x) => x.toJson())),
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
class RbacModel extends Rbac implements EntityModel {
  @override
  final Map<String, dynamic> source;
  final List<RoleModel> _roles;
  final List<UserModel> _users;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  RbacModel({
    required this.source,
    List<RoleModel>? roles,
    List<UserModel>? users,
  })  : _roles = roles ?? List.empty(growable: true),
        _users = users ?? List.empty(growable: true),
        super(
          source: source,
        ) {
    final listRoles = source.containsKey("roles") && source["roles"] is List
        ? (source["roles"] as List)
        : List<Map<String, dynamic>>.empty(growable: true);
    _roles.addAll(listRoles.map((e) {
      final role = RoleModel.fromJson(e);
      CustomRoleSingleList.instance.add(role);
      return role;
    }).toList());
    final listUsers = source.containsKey("users") && source["users"] is List
        ? (source["users"] as List)
        : List<Map<String, dynamic>>.empty(growable: true);
    final userList = listUsers.map((e) {
      final user = UserModel.fromJson(e);
      log(user.email);
      return user;
    }).toList();
    _users.addAll(userList);
    log(source.toString());
    save();
  }

  factory RbacModel.fromJson(Map<String, dynamic> json) => RbacModel(
        source: json,
      );

  factory RbacModel.fromXml(
          XmlElement element, RbacModel Function(XmlElement el) process) =>
      process(element);

  @override
  Map<String, ColumnMetaModel>? get getMetaModel => getColumnMetaModel();

  List<Role> get getRoles => _roles;

  @override
  set setMetaModel(Map<String, ColumnMetaModel> newMetaModel) {
    metaModel = newMetaModel;
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return RbacList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return RbacList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return RbacList.fromJson({});
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
    return {"id_rbac": "ID"};
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

  Future<void> save() {
    final data = {
      "roles": _roles.map((e) => e.toJson()).toList(),
      "users": _users.map((e) => e.toJson()).toList(),
    };
    return writeToAssetsFile(ASSETS_MODELS_SECURITY_JSON, json.encode(data));
  }

  @override
  Map<String, dynamic> toJson() {
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

  @override
  static T getValueFrom<T>(
    String key,
    Map<dynamic, dynamic> json,
    T defaultValue, {
    JsonReader<T>? reader,
    Caster<T>? cast,
  }) {
    return EntityModel.getValueFromJson<T>(
      key,
      json,
      defaultValue,
      reader: reader,
      cast: cast,
    );
  }
}
