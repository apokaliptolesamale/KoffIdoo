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
import '../entities/gift.dart';
import 'recipient_gift_model.dart';
import 'source_gift_model.dart';

GiftModel giftModelFromJson(String str) => GiftModel.fromJson(json.decode(str));

GiftList giftListModelFromJson(String str) =>
    GiftList.fromJson(json.decode(str));

String giftModelToJson(GiftModel data) => json.encode(data.toJson());

class GiftList<T extends GiftModel> implements EntityModelList<T> {
  Map<String, dynamic> avatars;
  List<T> gifts;

  GiftList({
    required this.avatars,
    required this.gifts,
  });

  factory GiftList.fromStringJson(String strJson) =>
      GiftList.fromJson(json.decode(strJson));

  factory GiftList.fromJson(Map<String, dynamic> json) => GiftList(
        avatars: json.containsKey("avatars") && json["avatars"] != null
            ? json["avatars"]
            : '',
        gifts: List<T>.from(json["gift"].map((x) => GiftModel.fromJson(x))),
        /* gifts: json.containsKey("gift") && json["gift"] != null && json["gift"].toString().contains('[]')
        ? List<T>.from(json["gift"].map((x) => GiftModel.fromJson(x)))
        : json["gift"], */
      );

  Map<String, dynamic> toJson() => {
        "avatars": avatars,
        "gift": List<dynamic>.from(gifts.map((x) => x.toJson())),
      };

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return GiftList.fromJson(json);
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return GiftList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => gifts;

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!gifts.contains(element)) gifts.add(element);
    }
    return this;
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
class GiftModel extends Gift implements EntityModel {
  //method generated by wizard
  @override
  T cloneWith<T extends EntityModel>(T other) {
    return GiftModel.fromJson(other.toJson()) as T;
  }

  @override
  T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
    return GiftModel.fromJson(params) as T;
  }

  List<Object?> get props => [];

  bool? get stringify => true;
  @override
  final String uuid;
  @override
  final int transactionCode;
  @override
  final int statusCode;
  @override
  final String statusDenom;
  @override
  final String description;
  @override
  final double amount;
  @override
  final String createdAt;
  @override
  final String transactionSignature;
  @override
  final String currency;
  @override
  final String cardGiftUuid;
  @override
  final String cardReference;
  @override
  final SourceGiftModel source;
  @override
  final RecipientGiftModel recipients;

  GiftModel({
    required this.uuid,
    required this.transactionCode,
    required this.statusCode,
    required this.statusDenom,
    required this.description,
    required this.amount,
    required this.createdAt,
    required this.transactionSignature,
    required this.currency,
    required this.cardGiftUuid,
    required this.cardReference,
    required this.source,
    required this.recipients,
  }) : super(
            uuid: uuid,
            transactionCode: transactionCode,
            statusCode: statusCode,
            statusDenom: statusDenom,
            description: description,
            amount: amount,
            createdAt: createdAt,
            transactionSignature: transactionSignature,
            currency: currency,
            cardGiftUuid: cardGiftUuid,
            cardReference: cardReference,
            source: source,
            recipient: recipients);

  factory GiftModel.fromJson(Map<String, dynamic> json) => GiftModel(
        uuid: json.containsKey("uuid") && json["uuid"] != null
            ? json["uuid"]
            : '', //json["uuid"],
        transactionCode: json.containsKey("transaction_code") &&
                json["transaction_code"] != null
            ? json["transaction_code"]
            : '', //json["transaction_code"],
        statusCode:
            json.containsKey("status_code") && json["status_code"] != null
                ? json["status_code"]
                : '', //json["status_code"],
        statusDenom:
            json.containsKey("status_denom") && json["status_denom"] != null
                ? json["status_denom"]
                : '', //json["status_denom"],
        description: json.containsKey("description") &&
                json["description"] != null
            ? json["description"]
            : '', //json["description"] == null ? null : json["description"],
        amount: json.containsKey("amount") && json["amount"] != null
            ? json["amount"]
            : '', //json["amount"].toDouble(),
        createdAt: json.containsKey("created_at") && json["created_at"] != null
            ? json["created_at"]
            : '', //json["created_at"],
        transactionSignature: json.containsKey("transaction_signature") &&
                json["transaction_signature"] != null
            ? json["transaction_signature"]
            : '', //json["transaction_signature"],
        currency: json.containsKey("currency") && json["currency"] != null
            ? json["currency"]
            : '', //json["currency"],
        cardGiftUuid:
            json.containsKey("card_gift_uuid") && json["card_gift_uuid"] != null
                ? json["card_gift_uuid"]
                : '', //json["card_gift_uuid"],
        cardReference:
            json.containsKey("card_reference") && json["card_reference"] != null
                ? json["card_reference"]
                : '', //json["card_reference"],
        source: SourceGiftModel.fromJson(json["source"]),
        recipients: RecipientGiftModel.fromJson(json["recipient"]),
      );

  factory GiftModel.fromXml(
          XmlElement element, GiftModel Function(XmlElement el) process) =>
      process(element);

  @override
  static T getValueFrom<T>(
      String key, Map<dynamic, dynamic> json, T defaultValue,
      {JsonReader<T>? reader}) {
    return EntityModel.getValueFromJson<T>(key, json, defaultValue,
        reader: reader);
  }

  @override
  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "transaction_code": transactionCode,
        "status_code": statusCode,
        "status_denom": statusDenom,
        "description": description,
        "amount": amount,
        "created_at": createdAt,
        "transaction_signature": transactionSignature,
        "currency": currency,
        "card_gift_uuid": cardGiftUuid,
        "card_reference": cardReference,
        "source": source.toJson(),
        "recipient": recipients.toJson(),
      };

  @override
  Map<String, String> getColumnNames() {
    return {"id_gift": "ID"};
  }

  @override
  List<String> getColumnNamesList() {
    return getColumnNames().values.toList();
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return GiftList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return GiftList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return GiftList.fromJson({});
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
  Map<String, ColumnMetaModel>? get getMetaModel => getColumnMetaModel();

  @override
  set setMetaModel(Map<String, ColumnMetaModel> newMetaModel) {
    metaModel = newMetaModel;
  }

  @override
  Map<String, ColumnMetaModel>? metaModel;

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
}
