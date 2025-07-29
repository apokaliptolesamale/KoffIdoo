// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member

import 'dart:async';
import 'dart:convert';

import 'package:xml/xml.dart';

import '/app/core/services/logger_service.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/beneficiary.dart';

BeneficiaryList beneficiaryListModelFromJson(String str) =>
    BeneficiaryList.fromJson(json.decode(str));

BeneficiaryModel beneficiaryModelFromJson(String str) =>
    BeneficiaryModel.fromJson(json.decode(str));

String beneficiaryModelToJson(BeneficiaryModel data) =>
    json.encode(data.toJson());

class BeneficiaryList<T extends BeneficiaryModel>
    implements EntityModelList<T> {
  final List<T> beneficiarys;

  BeneficiaryList({
    required this.beneficiarys,
  });

  factory BeneficiaryList.fromJson(Map<String, dynamic> json) =>
      BeneficiaryList(
        beneficiarys: List<T>.from(
            json["beneficiarys"].map((x) => BeneficiaryModel.fromJson(x))),
      );

  factory BeneficiaryList.fromStringJson(String strJson) =>
      BeneficiaryList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return BeneficiaryList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!beneficiarys.contains(element)) beneficiarys.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return BeneficiaryList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => beneficiarys;

  Map<String, dynamic> toJson() => {
        "beneficiarys": List<dynamic>.from(beneficiarys.map((x) => x.toJson())),
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

class BeneficiaryModel extends Beneficiary implements EntityModel {
  @override
  final String nameBeneficiary;

  @override
  final String lastNameBeneficiary;

  @override
  final String ciBeneficiary;

  @override
  final String phoneBeneficiary;
  @override
  final String addressBeneficiary;
  @override
  Map<String, ColumnMetaModel>? metaModel;
  BeneficiaryModel({
    required this.nameBeneficiary,
    required this.lastNameBeneficiary,
    required this.ciBeneficiary,
    required this.phoneBeneficiary,
    required this.addressBeneficiary,
  }) : super(
          nameBeneficiary: nameBeneficiary,
          lastNameBeneficiary: lastNameBeneficiary,
          ciBeneficiary: ciBeneficiary,
          phoneBeneficiary: phoneBeneficiary,
          addressBeneficiary: addressBeneficiary,
        );
  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) =>
      BeneficiaryModel(
        nameBeneficiary: getValueFrom(
          "nameBeneficiary",
          json,
          "",
          reader: (key, data, defaultValue) {
            if (json.isNotEmpty && json.containsKey(key)) {
              return json[key];
            }
            return defaultValue;
          },
        ),
        lastNameBeneficiary: getValueFrom(
          "lastNameBeneficiary",
          json,
          "",
          reader: (key, data, defaultValue) {
            if (json.isNotEmpty && json.containsKey(key)) {
              return json[key];
            }
            return defaultValue;
          },
        ),
        ciBeneficiary: getValueFrom(
          "ciBeneficiary",
          json,
          "",
          reader: (key, data, defaultValue) {
            if (json.isNotEmpty && json.containsKey(key) && json[key] != null) {
              return json[key];
            }
            return defaultValue;
          },
        ),
        phoneBeneficiary: getValueFrom(
          "phoneBeneficiary",
          json,
          "",
          reader: (key, data, defaultValue) {
            if (json.isNotEmpty && json.containsKey(key)) {
              return json[key];
            }
            return defaultValue;
          },
        ),
        addressBeneficiary: getValueFrom(
          "addressBeneficiary",
          json,
          "",
          reader: (key, data, defaultValue) {
            if (json.isNotEmpty && json.containsKey(key)) {
              return json[key];
            }
            return defaultValue;
          },
        ),
      );
  factory BeneficiaryModel.fromXml(XmlElement element,
          BeneficiaryModel Function(XmlElement el) process) =>
      process(element);

  String get getFullName => "$nameBeneficiary $lastNameBeneficiary";

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
    return BeneficiaryModel.fromJson(other.toJson()) as T;
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return BeneficiaryList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return BeneficiaryList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return BeneficiaryList.fromJson({});
  }

  @override
  T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
    return BeneficiaryModel.fromJson(params) as T;
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
      "nameBeneficiary": "Nombre",
      "lastNameBeneficiary": "Apellidos",
      "ciBeneficiary": "Documento de Identidad",
      "phoneBeneficiary": "Teléfono",
      "addressBeneficiary": "Dirección",
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
        "nameBeneficiary": nameBeneficiary,
        "lastNameBeneficiary": lastNameBeneficiary,
        "ciBeneficiary": ciBeneficiary,
        "phoneBeneficiary": phoneBeneficiary,
        "addressBeneficiary": addressBeneficiary,
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
      String key, Map<dynamic, dynamic> json, T defaultValue,
      {JsonReader<T>? reader}) {
    return EntityModel.getValueFromJson<T>(key, json, defaultValue,
        reader: reader);
  }
}
