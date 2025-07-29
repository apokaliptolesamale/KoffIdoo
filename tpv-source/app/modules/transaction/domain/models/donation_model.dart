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
import '../entities/donation.dart';

DonationList donationListModelFromJson(String str) =>
    DonationList.fromJson(json.decode(str));

DonationModel donationModelFromJson(String str) =>
    DonationModel.fromJson(json.decode(str));

String donationModelToJson(DonationModel data) => json.encode(data.toJson());

class CreateDonationModel extends CreateDonation {
  @override
  String? fundingSourceUuid;

  @override
  String? description;
  @override
  String? donationUuid;
  @override
  String? amount;
  @override
  String? currency;
  @override
  String? paymentPassword;
  @override
  String? fingerprint;
  CreateDonationModel({
    required this.fundingSourceUuid,
    required this.description,
    required this.donationUuid,
    required this.amount,
    required this.currency,
    required this.paymentPassword,
    required this.fingerprint,
  }) : super(
            amount: amount,
            currency: currency,
            description: description,
            donationUuid: donationUuid,
            fingerprint: fingerprint,
            fundingSourceUuid: fundingSourceUuid,
            paymentPassword: paymentPassword);

  factory CreateDonationModel.fromJson(Map<String, dynamic> json) {
    return CreateDonationModel(
      fundingSourceUuid: json.containsKey("fundingSourceUuid") &&
              json["fundingSourceUuid"] != null
          ? json["fundingSourceUuid"]
          : "",
      description:
          json.containsKey("description") && json["description"] != null
              ? json["description"]
              : "",
      donationUuid:
          json.containsKey("donationUuid") && json["donationUuid"] != null
              ? json["donationUuid"]
              : "",
      amount: json.containsKey("amount") && json["amount"] != null
          ? json["amount"]
          : "",
      currency: json.containsKey("currency") && json["currency"] != null
          ? json["currency"]
          : "",
      paymentPassword: json.containsKey("payment_password") &&
              json["currepayment_passwordncy"] != null
          ? json["payment_password"]
          : "", //json["payment_password"],
      fingerprint:
          json.containsKey("fingerprint") && json["fingerprint"] != null
              ? json["fingerprint"]
              : "",
    );
  }

  Map<String, dynamic> toJson() => {
        "funding_source_uuid": fundingSourceUuid,
        "description": description,
        "donation_uuid": donationUuid,
        "amount": amount,
        "currency": currency,
        "payment_password": paymentPassword,
        "fingerprint": fingerprint,
      };
}

class DonationList<T extends DonationModel> implements EntityModelList<T> {
  final List<T> donations;

  DonationList({
    required this.donations,
  });

  factory DonationList.fromJson(Map<String, dynamic> json) => DonationList(
        donations: List<T>.from(
            json["donation"].map((x) => DonationModel.fromJson(x))),
      );

  factory DonationList.fromStringJson(String strJson) =>
      DonationList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return DonationList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!donations.contains(element)) donations.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return DonationList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => donations;

  Map<String, dynamic> toJson() => {
        "donation": List<dynamic>.from(donations.map((x) => x.toJson())),
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
class DonationModel extends Donation implements EntityModel {
  @override
  final String? uuid;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? createdAt;
  @override
  final Map<String, dynamic>? images;
  @override
  final String? currency;
  @override
  final String? tipoDeCambio;
  @override
  final String? statusCode;
  @override
  final String? statusDenom;

  @override
  Map<String, ColumnMetaModel>? metaModel;
  DonationModel({
    required this.uuid,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.images,
    required this.currency,
    required this.tipoDeCambio,
    required this.statusCode,
    required this.statusDenom,
  }) : super(
          uuid: uuid,
          title: title,
          description: description,
          createdAt: createdAt,
          images: images,
          currency: currency,
          tipoDeCambio: tipoDeCambio,
          statusCode: statusCode,
          statusDenom: statusDenom,
        );
  factory DonationModel.fromJson(Map<String, dynamic> json) => DonationModel(
        uuid: json.containsKey("uuid") && json["uuid"] != null
            ? json["uuid"].toString()
            : '',
        title: json.containsKey("title") && json["title"] != null
            ? json["title"].toString()
            : '',
        description:
            json.containsKey("description") && json["description"] != null
                ? json["description"].toString()
                : '',
        createdAt: json.containsKey("created_at") && json["created_at"] != null
            ? json["created_at"].toString()
            : '', //json["created_at"],
        images: json.containsKey('images') && json["created_at"] != null
            ? json['images']
            : {}, //json["images"],
        currency: json.containsKey("currency") && json["currency"] != null
            ? json["currency"].toString()
            : '',
        tipoDeCambio:
            json.containsKey("tipo_cambio") && json["tipo_cambio"] != null
                ? json["tipo_cambio"].toString()
                : '',
        statusCode:
            json.containsKey("status_code") && json["status_code"] != null
                ? json["status_code"].toString()
                : '',
        statusDenom:
            json.containsKey("status_denom") && json["status_denom"] != null
                ? json["status_denom"].toString()
                : '',
      );

  factory DonationModel.fromXml(
          XmlElement element, DonationModel Function(XmlElement el) process) =>
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
    return DonationModel.fromJson(other.toJson()) as T;
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return DonationList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return DonationList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return DonationList.fromJson({});
  }

  @override
  T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
    return DonationModel.fromJson(params) as T;
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
    return {"id_donation": "ID"};
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
        "uuid": uuid,
        "title": title,
        "description": description,
        "created_at": createdAt,
        "images": images,
        "currency": currency,
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
