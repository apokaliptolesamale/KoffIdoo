// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import '/app/widgets/utils/custom_datetime_converter.dart';
import 'package:xml/xml.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/nomenclador.dart';

NomencladorList nomencladorListModelFromJson(String str) =>
    NomencladorList.fromJson(json.decode(str));

NomencladorModel nomencladorModelFromJson(String str) =>
    NomencladorModel.fromJson(json.decode(str));

String nomencladorModelToJson(NomencladorModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class NomencladorList<T extends NomencladorModel>
    implements EntityModelList<T>, EntityModel {
  final List<T> nomencladors;
  final String uuid;
  final String name;
  final String clientId;
  final DateTime? createdAt, updatedAt;
  @override
  Map<String, ColumnMetaModel>? metaModel;

  NomencladorList({
    this.nomencladors = const [],
    this.uuid = "",
    this.name = "",
    this.clientId = "",
    this.createdAt,
    this.updatedAt,
  });

  factory NomencladorList.customReaderfromJson(Map<String, dynamic> json,
          NomencladorModel Function(Map<String, dynamic> data) reader) =>
      NomencladorList(
        nomencladors: List<T>.from(
          json["nomenclatures"].map((x) => reader(x)),
        ),
      );

  factory NomencladorList.fromEmpty() => NomencladorList(
        nomencladors: List<T>.from([].map((x) => NomencladorList.fromJson(x))),
      );
  factory NomencladorList.fromJson(Map<String, dynamic> json) =>
      NomencladorList(
        uuid: EntityModel.getValueFromJson(
          "uuid",
          json,
          "",
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key)) {
              return data[key];
            }
            return defaultValue;
          },
        ),
        nomencladors: EntityModel.getValueFromJson(
          "nomenclatures",
          json,
          [],
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key)) {
              return List<T>.from(
                  json[key].map((x) => NomencladorModel.fromJson(x)));
            }
            return defaultValue;
          },
        ),
        clientId: EntityModel.getValueFromJson(
          "clientId",
          json,
          "",
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key)) {
              return data[key];
            }
            return defaultValue;
          },
        ),
        name: EntityModel.getValueFromJson(
          "name",
          json,
          "",
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key)) {
              return data[key];
            }
            return defaultValue;
          },
        ),
        createdAt: EntityModel.getValueFromJson(
          "createdAt",
          json,
          DateTime.now(),
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key)) {
              return CustomDateTimeConverter.from(data[key]);
            }
            return defaultValue;
          },
        ),
        updatedAt: EntityModel.getValueFromJson(
          "updatedAt",
          json,
          DateTime.now(),
          reader: (key, data, defaultValue) {
            if (data is Map && data.containsKey(key)) {
              return CustomDateTimeConverter.from(data[key]);
            }
            return defaultValue;
          },
        ),
      );

  factory NomencladorList.fromOther(NomencladorList<T> other) =>
      NomencladorList(
        uuid: other.uuid,
        clientId: other.clientId,
        createdAt: other.createdAt,
        updatedAt: other.updatedAt,
        name: other.name,
        nomencladors: other.nomencladors,
      );

  factory NomencladorList.fromStringJson(String strJson) =>
      NomencladorList.fromJson(json.decode(strJson));

  factory NomencladorList.fromTrdJson(Map<String, dynamic> json) =>
      NomencladorList(
        nomencladors: List<T>.from(
            json["nomenclatures"].map((x) => NomencladorModel.fromTrdJson(x))),
      );

  @override
  // TODO: implement getMetaModel
  Map<String, ColumnMetaModel>? get getMetaModel => throw UnimplementedError();

  @override
  int get getTotal => getList().length;

  @override
  set setMetaModel(Map<String, ColumnMetaModel> metaModel) {
    // TODO: implement setMetaModel
  }

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList createModelListFrom(data) {
    // TODO: implement createModelListFrom
    throw UnimplementedError();
  }

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return NomencladorList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!nomencladors.contains(element)) nomencladors.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return NomencladorList.fromStringJson(strJson);
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
  List<T> getList() => nomencladors;

  @override
  Map<K1, V1> getMeta<K1, V1>(String searchKey, searchValue) {
    // TODO: implement getMeta
    throw UnimplementedError();
  }

  @override
  Map<String, String> getVisibleColumnNames() {
    // TODO: implement getVisibleColumnNames
    throw UnimplementedError();
  }

  List<Map<String, String>> toDropDownFormat() =>
      List<Map<String, String>>.from(
          nomencladors.map((x) => x.toDropDownFormat()));

  @override
  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "clientId": clientId,
        "createdAt": createdAt.toString(),
        "updatedAt": updatedAt.toString(),
        "name": name,
        "nomenclatures":
            List<dynamic>.from(nomencladors.map((x) => x.toJson())),
      };

  @override
  Map<String, ColumnMetaModel> updateColumnMetaModel(
      String keySearch, valueSearch, newValue) {
    // TODO: implement updateColumnMetaModel
    throw UnimplementedError();
  }

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
class NomencladorModel extends Nomenclador implements EntityModel {
  @override
  final dynamic idNomenclature;
  @override
  final dynamic idPadre;
  @override
  final String denomination;
  @override
  final String description;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  NomencladorModel({
    this.idNomenclature = "",
    this.idPadre = "",
    this.denomination = "",
    this.description = "",
  }) : super(
          idNomenclature: idNomenclature,
          idPadre: idPadre,
          denomination: denomination,
          description: description,
        );

  factory NomencladorModel.fromJson(Map<String, dynamic> json) =>
      NomencladorModel(
        idNomenclature: getValueFrom("idNomenclature", json, ""),
        idPadre: getValueFrom("idPadre", json, getValueFrom("id", json, "")),
        denomination: getValueFrom("denomination", json, ""),
        description: getValueFrom("denomination", json, ""),
      );

  factory NomencladorModel.fromTrdJson(Map<String, dynamic> json) {
    return NomencladorModel(
      idNomenclature: getValueFrom(
        "idNomenclature",
        json,
        "",
        reader: (key, data, defaultValue) {
          if (data.containsKey(key) && data.containsKey("IdDivision")) {
            return "${data[key]}_${data["IdDivision"]}";
          }
          return defaultValue;
        },
      ),
      idPadre: getValueFrom(
        "idPadre",
        json,
        "",
        reader: (key, data, defaultValue) {
          if (data.containsKey(key) && data.containsKey("IdDivision")) {
            return "${data[key]}_${data["IdDivision"]}";
          }
          return defaultValue;
        },
      ),
      denomination: getValueFrom("denomination", json, ""),
      description: getValueFrom(
        "denomination",
        json,
        "",
        reader: (key, data, defaultValue) {
          if (data.containsKey(key)) {
            return "Unidad comercial:${data[key]}";
          }
          return defaultValue;
        },
      ),
    );
  }

  factory NomencladorModel.fromXml(XmlElement element,
          NomencladorModel Function(XmlElement el) process) =>
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
        return NomencladorList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return NomencladorList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return NomencladorList.fromJson({});
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
    return {"id_nomenclador": "ID"};
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

  Map<String, String> toDropDownFormat() => {
        "id": "$idNomenclature",
        "name": denomination,
      };

  @override
  Map<String, dynamic> toJson() => {
        "idNomenclature": idNomenclature,
        "idPadre": idPadre,
        "denomination": denomination,
        "description": description,
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
