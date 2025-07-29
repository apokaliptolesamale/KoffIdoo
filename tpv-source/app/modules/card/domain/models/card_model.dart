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
import '../entities/card.dart';

CardList cardListModelFromJson(String str) =>
    CardList.fromJson(json.decode(str));

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

class AddCardModel extends AddCard {
  @override
  String pan;

  @override
  String cardholder;

  @override
  String expdate;

  @override
  String cadenaEncript;

  @override
  String? cm;

  AddCardModel({
    required this.pan,
    required this.cardholder,
    required this.expdate,
    required this.cadenaEncript,
    this.cm,
  }) : super(
            pan: pan,
            cardholder: cardholder,
            expdate: expdate,
            cadenaEncript: cadenaEncript,
            cm: cm);

  factory AddCardModel.fromJson(Map<String, dynamic> json) {
    return AddCardModel(
      pan: json["pan"],
      cardholder: json["cardholder"],
      expdate: json["expdate"],
      cadenaEncript: json["cadenaEncript"],
      cm: json["cm"],
    );
  }

  Map<String, dynamic> toJson() => {
        "pan": pan,
        "cardholder": cardholder,
        "expdate": expdate,
        "cadenaEncript": cadenaEncript,
        "CM": cm,
      };
}

class CardList<T extends CardModel> implements EntityModelList<T> {
  final List<T> cards;

  CardList({
    required this.cards,
  });

  factory CardList.fromJson(Map<String, dynamic> json) => CardList(
        cards: List<T>.from(json["card"].map((x) => CardModel.fromJson(x))),
      );

  factory CardList.fromStringJson(String strJson) =>
      CardList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return CardList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!cards.contains(element)) cards.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return CardList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => cards;

  Map<String, dynamic> toJson() => {
        "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
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
class CardModel extends Card implements EntityModel {
  @override
  final String cardUuid;
  @override
  final String last4;
  @override
  final String cardholder;
  @override
  final String expdate;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final String status;
  @override
  final String currency;
  @override
  final String fundingSourceId;
  @override
  final String fundingSourceUuid;
  @override
  final String primarySource;
  @override
  final String bankName;
  @override
  final String bankCode;
  @override
  final String verified;
  @override
  final String bankCertificate;

  @override
  Map<String, ColumnMetaModel>? metaModel;

  CardModel({
    required this.cardUuid,
    required this.last4,
    required this.cardholder,
    required this.expdate,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.currency,
    required this.fundingSourceId,
    required this.fundingSourceUuid,
    required this.primarySource,
    required this.bankName,
    required this.bankCode,
    required this.verified,
    required this.bankCertificate,
  }) : super(
          cardUuid: cardUuid,
          last4: last4,
          cardholder: cardholder,
          expdate: expdate,
          createdAt: createdAt,
          updatedAt: updatedAt,
          status: status,
          currency: currency,
          fundingSourceId: fundingSourceId,
          fundingSourceUuid: fundingSourceUuid,
          primarySource: primarySource,
          bankName: bankName,
          bankCode: bankCode,
          verified: verified,
          bankCertificate: bankCertificate,
        );

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        cardUuid: json.containsKey("card_uuid") && json["card_uuid"] != null
            ? json["card_uuid"]
            : '',
        last4: json.containsKey("last4") && json["last4"] != null
            ? json["last4"].toString()
            : '',
        cardholder: json.containsKey("cardholder") && json["cardholder"] != null
            ? json["cardholder"]
            : '',
        expdate: json.containsKey("expdate") && json["expdate"] != null
            ? json["expdate"].toString()
            : '',
        createdAt: json.containsKey("created_at") && json["created_at"] != null
            ? json["created_at"]
            : '',
        updatedAt: json.containsKey("updated_at") && json["updated_at"] != null
            ? json["updated_at"]
            : '',
        status: json.containsKey("status") && json["status"] != null
            ? json["status"].toString()
            : '',
        currency: json.containsKey("currency") && json["currency"] != null
            ? json["currency"]
            : '',
        fundingSourceId: json.containsKey("funding_source_id") &&
                json["funding_source_id"] != null
            ? json["funding_source_id"]
            : '',
        fundingSourceUuid: json.containsKey("funding_source_uuid") &&
                json["funding_source_uuid"] != null
            ? json["funding_source_uuid"]
            : '',
        primarySource:
            json.containsKey("primary_source") && json["primary_source"] != null
                ? json["primary_source"].toString()
                : '',
        bankName: json.containsKey("bank_name") && json["bank_name"] != null
            ? json["bank_name"]
            : '',
        bankCode: json.containsKey("bank_code") && json["bank_code"] != null
            ? json["bank_code"].toString()
            : '',
        verified: json.containsKey("verified") && json["verified"] != null
            ? json["verified"].toString()
            : '',
        bankCertificate: json.containsKey("bank_certificate") &&
                json["bank_certificate"] != null
            ? json["bank_certificate"]
            : '',
      );

  factory CardModel.fromXml(
          XmlElement element, CardModel Function(XmlElement el) process) =>
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
        return CardList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return CardList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return CardList.fromJson({});
  }

  @override
  Map<String, ColumnMetaModel> getColumnMetaModel() {
    /////Map<String, String> colNames = getColumnNames();
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
    return {"id_card": "ID"};
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
        "card_uuid": cardUuid,
        "last4": last4,
        "cardholder": cardholder,
        "expdate": expdate,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "status": status,
        "currency": currency,
        // "currency": currencyValues.reverse[currency],
        "funding_source_id": fundingSourceId,
        "funding_source_uuid": fundingSourceUuid,
        "primary_source": primarySource,
        "bank_name": bankName,
        "bank_code": bankCode,
        "verified": verified,
        "bank_certificate": bankCertificate,
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

class SetAsDefaultCardModel extends SetAsDefaultCard {
  @override
  String primary_source;
  SetAsDefaultCardModel({required this.primary_source})
      : super(primary_source: primary_source);

  factory SetAsDefaultCardModel.fromJson(Map<String, dynamic> json) {
    return SetAsDefaultCardModel(primary_source: json['primary_source']);
  }
  Map<String, dynamic> toJson() => {
        "primary_source": primary_source,
      };
}
