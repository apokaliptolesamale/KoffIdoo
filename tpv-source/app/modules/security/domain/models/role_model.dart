// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xml/xml.dart';

import '/app/core/helpers/functions.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/role.dart';
import 'permission_model.dart';

RoleList roleListModelFromJson(String str) =>
    RoleList.fromJson(json.decode(str));

RoleModel roleModelFromJson(String str) => RoleModel.fromJson(json.decode(str));

String roleModelToJson(RoleModel data) => json.encode(data.toJson());

class CustomRoleSingleList {
  static final CustomRoleSingleList instance =
      !Get.isRegistered() ? CustomRoleSingleList._internal([]) : Get.find();
  final List<RoleModel> _roles;

  factory CustomRoleSingleList({
    required themes,
  }) =>
      instance;
  CustomRoleSingleList._internal(this._roles) {
    Get.lazyPut(() => this);
  }

  List<RoleModel> get getRoles => _roles;

  bool add(RoleModel role) {
    if (getByName(role.name) == null) {
      _roles.add(role);
      return true;
    }
    return false;
  }

  Map<String, RoleModel> asMap() {
    Map<String, RoleModel> map = {};
    _roles.map((e) {
      return map.addEntries([MapEntry(e.name, e)]);
    });
    return map;
  }

  bool exists(RoleModel role) {
    return _roles.contains(role);
  }

  RoleModel get(int position) {
    return _roles[position];
  }

  RoleModel? getById(String id) {
    RoleModel? role;

    if (_roles.isEmpty) return null;
    for (var element in _roles) {
      if (element.id == id) {
        role = element;
        break;
      }
    }
    return role;
  }

  RoleModel? getByName(String name) {
    RoleModel? role;

    if (_roles.isEmpty) return null;
    for (var element in _roles) {
      if (element.name == name) {
        role = element;
        break;
      }
    }
    return role;
  }

  List<RoleModel> getRolesByIds(List<String> ids) {
    if (ids.isEmpty) return List.empty(growable: true);
    List<RoleModel> tmp = List.empty(growable: true);
    for (var id in ids) {
      final role = getById(id);
      if (role != null) {
        tmp.add(role);
      }
    }
    return tmp;
  }

  List<RoleModel> getRolesFromNames(List<String> names) {
    if (names.isEmpty) return List.empty(growable: true);
    List<RoleModel> tmp = List.empty(growable: true);
    for (var name in names) {
      final role = getByName(name);
      if (role != null) {
        tmp.add(role);
      }
    }
    return tmp;
  }

  CustomRoleSingleList set(int position, RoleModel newTheme) {
    _roles[position] = newTheme;
    return this;
  }
}

class RoleList<T extends RoleModel> implements EntityModelList<T> {
  final List<T> roles;

  RoleList({
    this.roles = const [],
  });

  factory RoleList.fromEmpty() => RoleList(
        roles: List<T>.from([].map((x) => RoleList.fromJson(x))),
      );

  factory RoleList.fromJson(Map<String, dynamic> json) => RoleList(
        roles: List<T>.from(json["roles"].map((x) => RoleModel.fromJson(x))),
      );

  factory RoleList.fromStringJson(String strJson) =>
      RoleList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return RoleList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!roles.contains(element)) roles.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return RoleList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => roles;

  Map<String, dynamic> toJson() => {
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
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
class RoleModel extends Role implements EntityModel {
  @override
  final String id;
  @override
  final String name;
  @override
  final List<PermissionModel> permissions;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  RoleModel({
    required this.id,
    required this.name,
    required this.permissions,
  }) : super(id: id, name: name, permissions: permissions);

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
      id: EntityModel.getValueFromJson("id", json, ""),
      name: EntityModel.getValueFromJson("name", json, ""),
      permissions: EntityModel.getValueFromJson(
        "permissions",
        json,
        List<PermissionModel>.empty(growable: true),
        reader: (key, data, defaultValue) {
          if (data is Map && data.containsKey(key)) {
            if (data[key] is List) {
              final list = data[key] as List;
              int c = 1;
              return list
                  .map((permission) =>
                      PermissionModel.fromJson(isJson(permission)
                          ? permission
                          : {
                              "id": "perm-role:${data['id']}:${c++}",
                              "name": permission,
                            }))
                  .toList();
            }
          }
          return defaultValue;
        },
      ));

  factory RoleModel.fromXml(
          XmlElement element, RoleModel Function(XmlElement el) process) =>
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
        return RoleList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return RoleList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return RoleList.fromJson({});
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
    return {"id_role": "ID"};
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
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      "id": id,
      "name": name,
      "permissions": permissions.map((e) => e.toJson()).toList()
    };
    data.removeWhere((key, value) => value == null);
    return data;
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
