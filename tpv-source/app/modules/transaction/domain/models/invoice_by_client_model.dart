// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import '/app/modules/transaction/domain/entities/invoice_by_client.dart';

import '/app/modules/transaction/domain/models/bank_debit_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xml/xml.dart';

import '../../../../../app/core/interfaces/entity_model.dart';

InvoiceByClientModel InvoiceByClientModelFromJson(String str) =>
    InvoiceByClientModel.fromJson(json.decode(str));

InvoiceListByClientModel InvoiceListByClientModelModelFromJson(String str) {
  return InvoiceListByClientModel.fromJson(json.decode(str));
}

String InvoiceByClientModelToJson(InvoiceByClientModel data) => json.encode(data.toJson());

class InvoiceListByClientModel<T extends InvoiceByClientModel> implements EntityModelList<T> {
  final List<T> invoices;

  InvoiceListByClientModel({
    this.invoices = const [],
  });

  factory InvoiceListByClientModel.fromStringJson(String strJson) =>
      InvoiceListByClientModel.fromJson(json.decode(strJson));

  factory InvoiceListByClientModel.fromJson(Map<String, dynamic> json) {
    return InvoiceListByClientModel(
      invoices:
          List<T>.from(json["invoice"].map((x) => InvoiceByClientModel.fromJson(x))),
    );
  }
  factory InvoiceListByClientModel.fromEmpty() => InvoiceListByClientModel(
        invoices: List<T>.from([].map((x) => InvoiceListByClientModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "invoices": List<dynamic>.from(invoices.map((x) => x.toJson())),
      };

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    return InvoiceListByClientModel.fromJson(json);
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    return InvoiceListByClientModel.fromStringJson(strJson);
  }

  @override
  List<T> getList() => invoices;

  @override
  int get getTotal => getList().length;

  @override
  EntityModelList<T> add(T element) => fromList([element]);

  @override
  EntityModelList<T> fromList(List<T> list) {
    for (var element in list) {
      if (!invoices.contains(element)) invoices.add(element);
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
class InvoiceByClientModel extends InvoiceByClient implements EntityModel {
  @override
  String? paymentServiceId;
  @override
  int? transactionId;
  @override
  String? amount;
  @override
  double? totalAmount;
  @override
  String? branch;
  @override
  String? invoiceEz;
  @override
  String? owner;
  @override
  String? metadata;
  @override
  String? period;
  @override
  String? transactionUuid;
  @override
  DateTime? transactionCreatedAt;
  @override
  int? transactionStatusCode;
  @override
  String? transactionStatus;
  @override
  String? last4;
  @override
  String? currency;
  @override
  String? transactionDescription;
  @override
  String? transactionDenom;
  @override
  int? transactionCode;
  @override
  String? merchantAlias;
  @override
  String? merchantAvatar;
  @override
  String? bankCode;
  @override
  String? username;
  @override
  String? privuse2;
  @override
  dynamic bankDebitDetail;
  @override
  String? fundingSourceUuid;
  @override
  String? clientId;
  @override
  String? transactionSignature;
  @override
  String? rc04;
  @override
  String? folio;
  @override
  String? tomo;
  @override
  String? route;
  @override
  String? month;
  @override
  String? year;
  @override
  String? charged;
  @override
  String? invoiceDate;
  @override
  String? discount;
  @override
  String? consumption;

  InvoiceByClientModel({
    this.amount,
    this.bankCode,
    this.bankDebitDetail,
    this.branch,
    this.clientId,
    this.currency,
    this.fundingSourceUuid,
    this.invoiceEz,
    this.last4,
    this.merchantAlias,
    this.merchantAvatar,
    this.metadata,
    this.owner,
    this.paymentServiceId,
    this.period,
    this.privuse2,
    this.rc04,
    this.totalAmount,
    this.transactionCode,
    this.transactionCreatedAt,
    this.transactionDenom,
    this.transactionDescription,
    this.transactionId,
    this.transactionSignature,
    this.transactionStatus,
    this.transactionStatusCode,
    this.transactionUuid,
    this.username,
    this.charged,
    this.consumption,
    this.discount,
    this.folio,
    this.invoiceDate,
    this.month,
    this.route,
    this.tomo,
    this.year,
  }) : super(
            amount: amount,
            bankCode: bankCode,
            bankDebitDetail: bankDebitDetail,
            branch: branch,
            clientId: clientId,
            currency: currency,
            fundingSourceUuid: fundingSourceUuid,
            invoiceEz: invoiceEz,
            last4: last4,
            merchantAlias: merchantAlias,
            merchantAvatar: merchantAvatar,
            metadata: metadata,
            owner: owner,
            paymentServiceId: paymentServiceId,
            period: period,
            privuse2: privuse2,
            rc04: rc04,
            totalAmount: totalAmount,
            transactionCode: transactionCode,
            transactionCreatedAt: transactionCreatedAt,
            transactionDenom: transactionDenom,
            transactionDescription: transactionDescription,
            transactionId: transactionId,
            transactionSignature: transactionSignature,
            transactionStatus: transactionStatus,
            transactionStatusCode: transactionStatusCode,
            transactionUuid: transactionUuid,
            username: username,
            folio: folio,
            route: route,
            month: month,
            year: year,
            charged: charged,
            invoiceDate: invoiceDate,
            discount: discount,
            consumption: consumption);

  factory InvoiceByClientModel.fromJson(Map<String, dynamic> json) {
   json = json["invoice"];
    return InvoiceByClientModel(
      amount: getValueFrom(
        "amount",
        json,
        null,
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is double) {
            return (json[key].toString());
          } else if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is int) {
            return (json[key].toString());
          } else if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is String) {
            return (json[key].toString());
          } else {
            return defaultValue;
          }
        },
      ),
      bankCode: getValueFrom(
        "bank_code",
        json,
        null,
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) && json[key] != null && json[key] is int) {
            return json[key].toString();
          } else {
            return defaultValue;
          }
        },
      ),
      bankDebitDetail: getValueFrom(
        "bank_debit_detail",
        json,
        "",
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is Map<String, dynamic>) {
            return BankDebitDetailModel.fromStringJson(json[key]);
          } else if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is String) {
            return defaultValue;
          }
        },
      ),
      branch: getValueFrom("branch", json, ""),
      clientId: getValueFrom("client_id", json, ""),
      currency: getValueFrom("currency", json, ""),
      fundingSourceUuid: getValueFrom("funding_source_uuid", json, ""),
      invoiceEz: getValueFrom("invoice_ez", json, ""),
      last4: getValueFrom(
        "last4",
        json,
        "",
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) && json[key] != null && json[key] is int) {
            return json[key].toString();
          } else {
            return defaultValue;
          }
        },
      ),
      merchantAlias: getValueFrom("merchant_alias", json, ""),
      merchantAvatar: getValueFrom("merchant_avatar", json, ""),
      metadata: getValueFrom("metadata", json, ""),
      owner: getValueFrom("owner", json, ""),
      paymentServiceId: getValueFrom(
        "payment_service_id",
        json,
        "",
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) && json[key] != null && json[key] is int) {
            return json[key].toString();
          } else {
            return defaultValue;
          }
        },
      ),
      period: getValueFrom("period", json, ""),
      privuse2: getValueFrom("privuse2", json, ""),
      rc04: getValueFrom("rc04", json, ""),

      totalAmount: getValueFrom(
        "total_amount",
        json,
        null,
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is String) {
            double toInt = double.parse(json[key]);
            return toInt;
          } else if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is double) {
            return json[key];
          } else if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is int) {
            int numero = json[key];
            double toDouble = double.parse('$numero');
            return toDouble;
          }
          return null;
        },
      ),
      transactionCode: getValueFrom("transaction_code", json, null),
      transactionCreatedAt: getValueFrom(
        "transaction_created_at",
        json,
        DateTime.now(),
        reader: (key, data, defaultValue) {
          return json.containsKey(key) &&
                  json[key] != null &&
                  json[key] is String
              ? DateTime.parse(json["transaction_created_at"])
              : defaultValue;
        },
      ),
      // transactionCreatedAt:  DateTime.parse(json["transaction_created_at"].toString().substring(0,19)) ,
      transactionDenom: getValueFrom("transaction_denom", json, ""),
      transactionDescription: getValueFrom("transaction_description", json, ""),
      transactionId: getValueFrom(
        "transaction_id",
        json,
        null,
        reader: (key, data, defaultValue) {
          if (json.containsKey(key) &&
              json[key] != null &&
              json[key] is String) {
            return json[key] as int;
          } else {
            return json[key];
          }
        },
      ),

      transactionSignature: getValueFrom("transaction_signature", json, ""),
      transactionStatus: getValueFrom("transaction_status", json, ""),
      transactionStatusCode: getValueFrom("transaction_status_code", json, 1),
      transactionUuid: getValueFrom("transaction_uuid", json, ""),
      username: getValueFrom("username", json, ""),
      folio: getValueFrom("folio", json, ""),
      route: getValueFrom("route", json, ""),
      month: getValueFrom("month", json, ""),
      year: getValueFrom("year", json, ""),
      charged: getValueFrom(
        "charged",
        json,
        "",
      ),
      invoiceDate: getValueFrom(
        "invoice_date",
        json,
        "",
      ),
      discount: getValueFrom("discount", json, ""),
      consumption: getValueFrom("consumption", json, ""),
    );
  }
  factory InvoiceByClientModel.fromXml(
          XmlElement element, InvoiceByClientModel Function(XmlElement el) process) =>
      process(element);

  @override
  static T getValueFrom<T>(
    String key,
    Map<dynamic, dynamic> json,
    T defaultValue, {
    JsonReader<T>? reader,
  }) {
    return EntityModel.getValueFromJson<T>(
      key,
      json,
      defaultValue,
      reader: reader,
    );
  }

  @override
  Map<String, dynamic> toJson() => {};

  @override
  Map<String, String> getColumnNames() {
    return {"id_invoice": "ID"};
  }

  @override
  List<String> getColumnNamesList() {
    return getColumnNames().values.toList();
  }

  @override
  EntityModelList createModelListFrom(dynamic data) {
    try {
      if (data is Map) {
        return InvoiceListByClientModel.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return InvoiceListByClientModel.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return InvoiceListByClientModel.fromJson({});
  }

  @override
  Map<String, ColumnMetaModel> getColumnMetaModel() {
    Map<String, String> colNames = getColumnNames();
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
