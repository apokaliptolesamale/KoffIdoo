// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import 'package:xml/xml.dart';

import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/balance.dart';

BalanceList balanceListModelFromJson(String str) =>
    BalanceList.fromJson(json.decode(str));

BalanceModel balanceModelFromJson(String str) =>
    BalanceModel.fromJson(json.decode(str));

String balanceModelToJson(BalanceModel data) => json.encode(data.toJson());

class BalanceList<T extends BalanceModel> implements EntityModelList<T> {
  final List<T> balances;

  BalanceList({
    required this.balances,
  });

  factory BalanceList.fromJson(Map<String, dynamic> json) => BalanceList(
        balances:
            List<T>.from(json["balances"].map((x) => BalanceModel.fromJson(x))),
      );

  factory BalanceList.fromStringJson(String strJson) =>
      BalanceList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return BalanceList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!balances.contains(element)) balances.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return BalanceList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => balances;

  Map<String, dynamic> toJson() => {
        "balances": List<dynamic>.from(balances.map((x) => x.toJson())),
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
class BalanceModel extends Balance implements EntityModel {
  @override
  final String bankAccount;
  @override
  final double balance;
  @override
  final double balanceAvailable;
  @override
  final int statusCode;
  @override
  final String statusDenom;
  @override
  final String transactionSignature;
  @override
  final String currency;
  @override
  final double balanceCred;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  BalanceModel({
    required this.bankAccount,
    required this.balance,
    required this.balanceAvailable,
    required this.statusCode,
    required this.statusDenom,
    required this.transactionSignature,
    required this.currency,
    required this.balanceCred,
  }) : super(
          bankAccount: bankAccount,
          balance: balance,
          balanceAvailable: balanceAvailable,
          statusCode: statusCode,
          statusDenom: statusDenom,
          transactionSignature: transactionSignature,
          currency: currency,
          balanceCred: balanceCred,
        );

  factory BalanceModel.fromJson(Map<String, dynamic> json) => BalanceModel(
        bankAccount: json["bank_account"],
        balance: json["balance"],
        balanceAvailable: json["balance_available"],
        statusCode: json["status_code"],
        statusDenom: json["status_denom"],
        transactionSignature: json["transaction_signature"],
        currency: json["currency"],
        balanceCred: json["balance_cred"],
      );

  factory BalanceModel.fromXml(
          XmlElement element, BalanceModel Function(XmlElement el) process) =>
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
        return BalanceList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return BalanceList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return BalanceList.fromJson({});
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
    return {"id_balance": "ID"};
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
        "bank_account": bankAccount,
        "balance": balance,
        "balance_available": balanceAvailable,
        "status_code": statusCode,
        "status_denom": statusDenom,
        "transaction_signature": transactionSignature,
        "currency": currency,
        "balance_cred": balanceCred,
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
