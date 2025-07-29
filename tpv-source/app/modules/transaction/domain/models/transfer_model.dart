// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import 'package:xml/xml.dart';

import '../../../../core/interfaces/entity_model.dart';
import '../entities/transfer.dart';

TransferList transferListModelFromJson(String str) =>
    TransferList.fromJson(json.decode(str));

TransferModel transferModelFromJson(String str) =>
    TransferModel.fromJson(json.decode(str));

String transferModelToJson(TransferModel data) => json.encode(data.toJson());

class Recipient {
  String? last4;
  String? bank;
  String? avatar;
  String? name;
  String? lastName;
  String? userName;
  String? phone;
  String? verified;
  String? fundingRecipientUuid;
  String? currencyRecipientDenom;
  Recipient(
      {this.last4,
      this.bank,
      this.avatar,
      this.name,
      this.lastName,
      this.userName,
      this.phone,
      this.verified,
      this.fundingRecipientUuid,
      this.currencyRecipientDenom
      // required this.fundingRecipientUsername,
      // required this.fundingRecipientVerified,
      // required this.fundingRecipientLast4,
      // required this.fundingRecipientBank,
      // required this.fundingRecipientName,
      // required this.fundingRecipientLastName,
      // required this.fundingRecipientAvatar,
      // required this.pan,
      // required this.merchantAlias,
      // required this.merchantAvatar,
      });
  // String? fundingRecipientAvatar;
  // String fundingRecipientUsername;
  // String? fundingRecipientName;
  // String? fundingRecipientLastName;
  // String? fundingRecipientVerified;
  // int? fundingRecipientLast4;
  // int? fundingRecipientBank;
  // bool? pan;
  // bool? merchantAlias;
  // bool? merchantAvatar;

  factory Recipient.fromJson(Map<String, dynamic> json) => Recipient(
        last4: json.containsKey("last4") && json["last4"] != null
            ? json["last4"].toString()
            : null,
        bank: json.containsKey("bank") && json["bank"] != null
            ? json["bank"].toString()
            : null,
        avatar: json.containsKey("avatar") && json["avatar"] != null
            ? json["avatar"].toString()
            : null,
        name: json.containsKey("name") && json["name"] != null
            ? json["name"].toString()
            : null,
        lastName: json.containsKey("lastname") && json["lastname"] != null
            ? json["lastname"].toString()
            : null,
        userName: json.containsKey("username") && json["username"] != null
            ? json["username"].toString()
            : null,
        phone: json.containsKey("phone") && json["phone"] != null
            ? json["phone"].toString()
            : null,
        verified: json.containsKey("verified") && json["verified"] != null
            ? json["verified"].toString()
            : null,
        fundingRecipientUuid: json.containsKey("funding_recipient_uuid") &&
                json["funding_recipient_uuid"] != null
            ? json["funding_recipient_uuid"].toString()
            : null,
        currencyRecipientDenom: json.containsKey("currency_recipient_denom") &&
                json["currency_recipient_denom"] != null
            ? json["currency_recipient_denom"].toString()
            : null,
        // fundingRecipientName: json.containsKey("funding_recipient_name") &&
        //         json["funding_recipient_name"] != null &&
        //         json["funding_recipient_name"] != false
        //     ? json["funding_recipient_name"]
        //     : "",
        // fundingRecipientLastName:
        //     json.containsKey("funding_recipient_lastname") &&
        //             json["funding_recipient_lastname"] != null &&
        //             json["funding_recipient_lastname"] != false
        //         ? json["funding_recipient_lastname"]
        //         : null,
        // fundingRecipientUsername:
        //     json.containsKey("funding_recipient_username") &&
        //             json["funding_recipient_username"] != null
        //         ? json["funding_recipient_username"]
        //         : "",
        // fundingRecipientVerified:
        //     json.containsKey("funding_recipient_verified") &&
        //             json["funding_recipient_verified"] != null
        //         ? json["funding_recipient_verified"].toString()
        //         : "",
        // fundingRecipientLast4: json.containsKey("funding_recipient_last4") &&
        //         json["funding_recipient_last4"] != null
        //     ? json["funding_recipient_last4"]
        //     : null,
        // fundingRecipientBank: json.containsKey("funding_recipient_bank") &&
        //         json["funding_recipient_bank"] != null &&
        //         json["funding_recipient_bank"] != false
        //     ? json["funding_recipient_bank"]
        //     : null,
        // fundingRecipientAvatar: json.containsKey("funding_recipient_avatar") &&
        //         json["funding_recipient_avatar"] != null
        //     ? json["funding_recipient_avatar"].toString()
        //     : "",
        // pan:
        //     json.containsKey("pan") && json["pan"] != null ? json["pan"] : null,
        // merchantAlias: json.containsKey("merchant_alias") &&
        //         json["merchant_alias"] != null &&
        //         json["merchant_alias"] != false
        //     ? json["merchant_alias"]
        //     : null,
        // merchantAvatar: json.containsKey("merchant_avatar") &&
        //         json["merchant_avatar"] != null &&
        //         json["merchant_avatar"] != false
        //     ? json["merchant_avatar"]
        //     : null,
      );

  Map<String, dynamic> toJson() => {
        "bank": bank,
        "last4": last4,
        "avatar": avatar,
        "name": name,
        "lastname": lastName,
        "username": userName,
        "phone": phone,
        "verified": verified,
        "funding_recipient_uuid": fundingRecipientUuid,
        "currency_recipient_denom": currencyRecipientDenom
        // "funding_recipient_username": fundingRecipientUsername,
        // "funding_recipient_verified": fundingRecipientVerified,
        // "funding_recipient_last4": fundingRecipientLast4,
        // "funding_recipient_bank": fundingRecipientBank,
        // "pan": pan,
        // "merchant_alias": merchantAlias,
        // "merchant_avatar": merchantAvatar
      };
}

class Source {
  String fundingSourceAmount;

  String avatar;
  String userName;
  String verified;
  String name;
  String lastName;
  String last4;
  String bank;
  Source({
    required this.fundingSourceAmount,
    required this.avatar,
    required this.userName,
    required this.verified,
    required this.name,
    required this.lastName,
    required this.last4,
    required this.bank,

    // required this.fundingSourceAvatar,
    // required this.fundingSourceName,
    // required this.fundingSourceLastname,
    // required this.fundingSourceAmount,
    // required this.fundingSourceUsername,
    // required this.fundingSourceVerified,
    // required this.foundingSourceLast4,
    // required this.foundignSourceBank
  });
  // String? foundingSourceLast4;
  // String? foundignSourceBank;
  // String? fundingSourceAvatar;
  // String? fundingSourceName;
  // String? fundingSourceLastname;
  // String fundingSourceAmount;
  // String fundingSourceUsername;
  // int fundingSourceVerified;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        fundingSourceAmount: json.containsKey("funding_source_amount") &&
                json["funding_source_amount"] != null
            ? json["funding_source_amount"].toString()
            : "",
        avatar: json.containsKey("avatar") && json["avatar"] != null
            ? json["avatar"].toString()
            : "",
        userName: json.containsKey("username") && json["username"] != null
            ? json["username"].toString()
            : "",
        verified: json.containsKey("verified") && json["verified"] != null
            ? json["verified"].toString()
            : "",
        name: json.containsKey("name") && json["name"] != null
            ? json["name"].toString()
            : "",
        lastName: json.containsKey("lastname") && json["lastname"] != null
            ? json["lastname"].toString()
            : "",
        bank: json.containsKey("bank") && json["bank"] != null
            ? json["bank"].toString()
            : "",
        last4: json.containsKey("last4") && json["last4"] != null
            ? json["last4"].toString()
            : "",
        // foundignSourceBank: json.containsKey('funding_source_bank') &&
        //         json['funding_source_bank'] != null
        //     ? json['funding_source_bank'].toString()
        //     : "",
        // foundingSourceLast4: json.containsKey("funding_source_last4") &&
        //         json['funding_source_last4'] != null
        //     ? json['funding_source_last4'].toString()
        //     : "",
        // fundingSourceAvatar: json.containsKey("funding_source_avatar") &&
        //         json['funding_source_avatar'] != null &&
        //         json['funding_source_avatar'] != false
        //     ? json['funding_source_avatar'].toString()
        //     : "",
        // fundingSourceName: json.containsKey("funding_source_name") &&
        //         json["funding_source_name"] != null
        //     ? json["funding_source_name"]
        //     : null,
        // fundingSourceLastname: json.containsKey("funding_source_lastname") &&
        //         json["funding_source_lastname"] != null
        //     ? json["funding_source_lastname"]
        //     : null,
        // fundingSourceAmount: json.containsKey("funding_source_amount") &&
        //         json["funding_source_amount"] != null
        //     ? json["funding_source_amount"].toString()
        //     : "",
        // fundingSourceUsername: json.containsKey("funding_source_username") &&
        //         json["funding_source_username"] != null
        //     ? json["funding_source_username"]
        //     : '',
        // fundingSourceVerified: json.containsKey("funding_source_verified") &&
        //         json["funding_source_verified"] != null
        //     ? json["funding_source_verified"]
        //     : "",
      );

  Map<String, dynamic> toJson() => {
        "funding_source_amount": fundingSourceAmount,
        "avatar": avatar,
        "username": userName,
        "verified": verified,
        "name": name,
        "lastname": lastName,
        "last4": last4,
        "bank": bank,
        // "funding_source_last4": foundingSourceLast4,
        // "funding_source_bank": foundignSourceBank,
        // "funding_source_avatar": fundingSourceAvatar,
        // "funding_source_name": fundingSourceName,
        // "funding_source_lastname": fundingSourceLastname,
        // "funding_source_amount": fundingSourceAmount,
        // "funding_source_username": fundingSourceUsername,
        // "funding_source_verified": fundingSourceVerified,
      };
}

class TransferList<T extends TransferModel> implements EntityModelList<T> {
  final List<T> transfers;

  TransferList({
    required this.transfers,
  });

  factory TransferList.fromJson(Map<String, dynamic> json) => TransferList(
        transfers: List<T>.from(
            json["transfers"].map((x) => TransferModel.fromJson(x))),
      );

  factory TransferList.fromStringJson(String strJson) =>
      TransferList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return TransferList.fromJson(json);
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!transfers.contains(element)) transfers.add(element);
    }
    return this;
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return TransferList.fromStringJson(strJson);
  }

  @override
  List<T> getList() => transfers;

  Map<String, dynamic> toJson() => {
        "transfers": List<dynamic>.from(transfers.map((x) => x.toJson())),
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
class TransferModel extends Transfer implements EntityModel {
  @override
  final String idTransfer;

  @override
  String amount;

  @override
  String pan;

  @override
  String cardFundingSourceUuid;
  @override
  String? description;
  @override
  String currency;
  @override
  String paymentPassword;
  @override
  String? fingerprint;
  @override
  String? phone;
  @override
  String transferUUID;
  @override
  String transactionCode;
  @override
  String transactionSignature;
  @override
  String statusCode;

  @override
  String statusDenom;
  @override
  DateTime createAt;
  @override
  Source source;
  @override
  Recipient recipient;
  @override
  String recipientUsername;
  @override
  String tipoCambio;
  @override
  Map<String, ColumnMetaModel>? metaModel;
  TransferModel({
    required this.idTransfer,
    required this.transferUUID,
    required this.transactionCode,
    required this.transactionSignature,
    required this.statusCode,
    required this.statusDenom,
    required this.createAt,
    required this.source,
    required this.recipient,
    required this.recipientUsername,
    required this.tipoCambio,
    required this.amount,
    required this.pan,
    required this.cardFundingSourceUuid,
    this.description,
    required this.currency,
    required this.paymentPassword,
    this.fingerprint,
    this.phone,
  }) : super(
            idTransfer: idTransfer,
            transferUUID: transferUUID,
            transactionCode: transactionCode,
            transactionSignature: transactionSignature,
            statusCode: statusCode,
            statusDenom: statusDenom,
            createAt: createAt,
            source: source,
            recipient: recipient,
            recipientUsername: recipientUsername,
            tipoCambio: tipoCambio,
            amount: amount,
            pan: pan,
            cardFundingSourceUuid: cardFundingSourceUuid,
            description: description,
            currency: currency,
            paymentPassword: paymentPassword,
            fingerprint: fingerprint,
            phone: phone);
  factory TransferModel.fromJson(Map<String, dynamic> json) => TransferModel(
        idTransfer:
            json.containsKey("id_transfer") && json["id_transfer"] != null
                ? json["id_transfer"].toString()
                : "",
        transferUUID: json.containsKey("uuid") && json["uuid"] != null
            ? json["uuid"].toString()
            : "",
        transactionCode: json.containsKey("transaction_code") &&
                json["transaction_code"] != null
            ? json["transaction_code"].toString()
            : "",
        transactionSignature: json.containsKey("transaction_signature") &&
                json["transaction_signature"] != null
            ? json["transaction_signature"].toString()
            : "",
        statusCode:
            json.containsKey("status_code") && json["status_code"] != null
                ? json["status_code"].toString()
                : "",
        statusDenom:
            json.containsKey("status_denom") && json["status_denom"] != null
                ? json["status_denom"].toString()
                : "",
        createAt: DateTime.parse(json["created_at"]),
        // json.containsKey("created_at") && json["created_at"] != null
        //     ? json["created_at"].toString()
        //     : "",
        source: Source.fromJson(json["source"]),

        /*json.containsKey("source") && json["source"] != null
            ? json["source"]
            : "",*/
        recipient: Recipient.fromJson(json["recipient"]),

        /*json.containsKey("recipient") && json["recipient"] != null
            ? json["recipient"]
            : "",*/
        recipientUsername: json.containsKey("recipient_username") &&
                json["recipient_username"] != null
            ? json["recipient_username"].toString()
            : "",
        tipoCambio:
            json.containsKey("tipo_cambio") && json["tipo_cambio"] != null
                ? json["tipo_cambio"].toString()
                : "",
        amount: json.containsKey("amount") && json["amount"] != null
            ? json["amount"].toString()
            : "",
        pan: json.containsKey("pan") && json["pan"] != null
            ? json["pan"].toString()
            : "",
        cardFundingSourceUuid: json.containsKey("funding_source_uuid") &&
                json["funding_source_uuid"] != null
            ? json["funding_source_uuid"].toString()
            : "",
        description:
            json.containsKey("description") && json["description"] != null
                ? json["description"].toString()
                : "",
        currency: json.containsKey("currency") && json["currency"] != null
            ? json["currency"].toString()
            : "",
        paymentPassword: json.containsKey("payment_password") &&
                json["payment_password"] != null
            ? json["payment_password"].toString()
            : "",
        fingerprint:
            json.containsKey("fingerprint") && json["fingerprint"] != null
                ? json["fingerprint"].toString()
                : "",
        phone: json.containsKey("phone") && json["phone"] != null
            ? json["phone"].toString()
            : "",
      );
  factory TransferModel.fromXml(
          XmlElement element, TransferModel Function(XmlElement el) process) =>
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
    return TransferModel.fromJson(other.toJson()) as T;
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return TransferList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return TransferList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return TransferList.fromJson({});
  }

  @override
  T fromJson<T extends EntityModel>(Map<String, dynamic> params) {
    return TransferModel.fromJson(params) as T;
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
    return {"id_transfer": "ID"};
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
        "id_transfer": idTransfer,
        "uuid": transferUUID,
        "transaction_code": transactionCode,
        "transaction_signature": transactionSignature,
        "status_code": statusCode,
        "status_denom": statusDenom,
        "created_at": createAt,
        "source": source,
        "recipient": recipient,
        "recipient_username": recipientUsername,
        "tipo_cambio": tipoCambio,
        "amount": amount,
        "pan": pan,
        "funding_source_uuid": cardFundingSourceUuid,
        "description": description,
        "currency": currency,
        "payment_password": paymentPassword,
        "fingerprint": fingerprint,
        "phone": phone,
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
