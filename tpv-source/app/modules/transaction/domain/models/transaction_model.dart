// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
// ignore_for_file: overridden_fields, empty_catches, override_on_non_overriding_member
import 'dart:convert';
import 'dart:developer';

import '/app/modules/transaction/domain/entities/recipient.dart';
import '/app/modules/transaction/domain/entities/source.dart';
import '/app/modules/transaction/domain/models/bank_debit_detail_model.dart';
import '/app/modules/transaction/domain/models/recipient_model.dart';
import '/app/modules/transaction/domain/models/source_model.dart';
import '../../../../../app/core/config/errors/exceptions.dart';
import '../../../../../app/core/interfaces/entity_model.dart';
import '../entities/transaction.dart';

TransactionList transactionListFromJson(String str) {
  Map<String, dynamic> tmp = json.decode(str);
  log(tmp.toString());
  return TransactionList.fromJson(tmp);
}

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionList data) =>
    json.encode(data.toJson());

class TransactionList<T extends TransactionModel>
    implements EntityModelList<T> {
  final List<T> transactions;
  PaginationModel paginationModel;

  TransactionList({required this.transactions, required this.paginationModel});

  factory TransactionList.fromModels(List<T> models) => TransactionList(
        transactions: models,
        paginationModel: PaginationModel.fromJson({}),
      );

  factory TransactionList.fromJson(Map<String, dynamic> json) {
    return TransactionList(
      transactions: json.isNotEmpty
          ? List<T>.from(
              json["transaction"].map((x) => TransactionModel.fromJson(x)))
          : [],
      paginationModel: PaginationModel.fromJson(json["pagination"]),
    );
  }

  factory TransactionList.fromStringJson(String strJson) =>
      TransactionList.fromJson(json.decode(strJson));

  @override
  int get getTotal => getList().length;

  Map<String, dynamic> toJson() => {
        "transaction": List<dynamic>.from(transactions.map((x) => x.toJson())),
        "pagination": paginationModel.toJson(),
      };

  @override
  EntityModelList<T> add(T element) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  EntityModelList<T> fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  EntityModelList<T> fromList(List<T> list) {
    // TODO: implement fromList
    throw UnimplementedError();
  }

  @override
  EntityModelList<T> fromStringJson(String strJson) {
    // TODO: implement fromStringJson
    throw UnimplementedError();
  }

  @override
  List<T> getList() => transactions;
}

class TransactionModel extends Transaction implements EntityModel {
  TransactionModel(
      {required this.invoice,
      required this.owner,
      required this.transactionStatusCode,
      required this.transactionStatus,
      required this.transactionCreatedAt,
      required this.transactionSignature,
      required this.amount,
      required this.currency,
      required this.transactionDenom,
      required this.transactionCode,
      required this.barcode,
      required this.totalAmount,
      required this.transactionDescription,
      required this.source,
      required this.recipient,
      required this.statusCode,
      required this.statusDenom,
      required this.merchantAlias,
      required this.merchantAvatar,
      required this.merchantName,
      required this.clientId,
      required this.bankDebitDetail,
      required this.period})
      : super(
          owner: owner,
          clientId: clientId,
          transactionStatusCode: transactionStatusCode,
          transactionStatus: transactionStatus,
          transactionCreatedAt: transactionCreatedAt,
          transactionSignature: transactionSignature,
          amount: amount,
          currency: currency,
          transactionDenom: transactionDenom,
          transactionCode: transactionCode,
          barcode: barcode,
          totalAmount: totalAmount,
          transactionDescription: transactionDescription,
          source: source,
          recipient: recipient,
          statusCode: statusCode,
          statusDenom: statusDenom,
          merchantAlias: merchantAlias,
          merchantAvatar: merchantAvatar,
          merchantName: merchantName,
          bankDebtitDetail: bankDebitDetail,
          period: period,
        );

  @override
  BankDebitDetailModel? bankDebitDetail;
  @override
  String? owner;
  @override
  String? invoice;
  @override
  int? clientId;
  @override
  String? merchantName;
  @override
  String? merchantAlias;
  @override
  String? merchantAvatar;
  @override
  int? transactionStatusCode;
  @override
  int? statusCode;
  @override
  String? transactionStatus;
  @override
  DateTime transactionCreatedAt;
  @override
  DateTime? period;
  @override
  String? transactionSignature;
  @override
  double? amount;
  @override
  String? currency;
  @override
  String? transactionDenom;
  @override
  String? statusDenom;
  @override
  int? transactionCode;
  @override
  bool? barcode;
  @override
  bool? totalAmount;
  @override
  String? transactionDescription;
  @override
  Source? source;
  @override
  Recipient? recipient;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
          owner: getValueFrom(
            "owner",
            json,
            "",
            reader: (key, data, defaultValue) {
              return json.containsKey(key) &&
                      json[key] is bool &&
                      json[key].toString().isNotEmpty
                  ? defaultValue
                  : json[key].toString();
            },
          ),
          clientId: getValueFrom(
            "client_id",
            json,
            null,
            reader: (key, data, defaultValue) {
              return json.containsKey(key) &&
                      json[key] is bool &&
                      json[key] != null
                  ? defaultValue
                  : json[key];
            },
          ),
          invoice: getValueFrom(
            "invoice",
            json,
            "",
            reader: (key, data, defaultValue) {
              return json.containsKey(key) &&
                      json[key] is bool &&
                      json[key].toString().isNotEmpty
                  ? defaultValue
                  : json[key].toString();
            },
          ),
          merchantAlias: getValueFrom("merchant_alias", json, ""),
          merchantAvatar: getValueFrom("merchant_avatar", json, ""),
          merchantName: getValueFrom("merchant_name", json, ""),
          transactionStatusCode:
              getValueFrom("transaction_status_code", json, 1),
          statusCode: getValueFrom("status_code", json, null),
          transactionStatus: getValueFrom("transaction_status", json, ""),
          transactionCreatedAt: //DateTime.utc(json["transaction_created_at"]),
              DateTime.parse(
                  json["transaction_created_at"].toString().substring(0, 19)),
          transactionSignature: getValueFrom("transaction_signature", json, ""),
          period: getValueFrom(
            "period",
            json,
            null,
            reader: (key, data, defaultValue) {
              if (json.containsKey(key) &&
                  json[key] is String &&
                  json[key] != null) {
                return defaultValue;
              } else if (json.containsKey(key) &&
                  json[key] is bool &&
                  json[key] != null) {
                return defaultValue;
              } else {
                return DateTime.parse(
                    json["period"].toString().substring(0, 19));
              }
            },
          ),
          amount: getValueFrom("amount", json, 0.0),
          currency: getValueFrom("currency", json, ""),
          transactionDenom: getValueFrom("transaction_denom", json, ""),
          statusDenom: getValueFrom("status_denom", json, ""),
          transactionCode: getValueFrom("transaction_code", json, null),
          barcode: getValueFrom("barcode", json, false),
          totalAmount: getValueFrom("total_amount", json, false),
          transactionDescription:
              getValueFrom("transaction_description", json, ""),
          source: SourceModel.fromJson(json["source"]),
          recipient: RecipientModel.fromJson(json["recipient"]),
          bankDebitDetail: /*json.containsKey("bank_debit_detail") && json["bank_debit_detail"] != null 
       && json["bank_debit_detail"] is Map<String,dynamic>
        ? BankDebitDetailModel.fromJson(json["bank_debit_detail"])
        : null*/
              getValueFrom(
            "bank_debit_detail",
            json,
            null,
            reader: (key, data, defaultValue) {
              if (json.containsKey(key) && json[key] is Map<String, dynamic>) {
                return BankDebitDetailModel.fromStringJson(json[key]);
              } else if (json[key] != null && json[key] is String) {
                defaultValue;
              }
              return null;
            },
          ));

  @override
  Map<String, dynamic> toJson() => {
        "transaction_status_code": transactionStatusCode,
        "transaction_status": transactionStatus,
        //"transaction_created_at": transactionCreatedAt.toIso8601String(),
        "transaction_signature": transactionSignature,
        "amount": amount,
        "currency": currency,
        "transaction_denom": transactionDenom,
        "transaction_code": transactionCode,
        "barcode": barcode,
        "total_amount": totalAmount,
        "transaction_description": transactionDescription
        /* "source": source.toJson(),
        "recipient": recipient.toJson()*/
      };

  @override
  Map<String, ColumnMetaModel>? metaModel;

  @override
  EntityModelList createModelListFrom(data) {
    try {
      if (data is Map) {
        return TransactionList.fromJson(data as Map<String, dynamic>);
      }
      if (data is String) {
        return TransactionList.fromStringJson(data);
      }
    } on Exception {
      log("Error al mapear el parámetro 'data'. Debe ser de tipo'Map<String, dynamic>' o String");
    }
    return TransactionList.fromJson({});
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
  Map<K1, V1> getMeta<K1, V1>(String searchKey, searchValue) {
    // TODO: implement getMeta
    throw UnimplementedError();
  }

  @override
  // TODO: implement getMetaModel
  Map<String, ColumnMetaModel>? get getMetaModel => throw UnimplementedError();

  @override
  Map<String, String> getVisibleColumnNames() {
    // TODO: implement getVisibleColumnNames
    throw UnimplementedError();
  }

  @override
  set setMetaModel(Map<String, ColumnMetaModel> metaModel) {
    // TODO: implement setMetaModel
  }

  @override
  Map<String, ColumnMetaModel> updateColumnMetaModel(
      String keySearch, valueSearch, newValue) {
    // TODO: implement updateColumnMetaModel
    throw UnimplementedError();
  }

  static T? getValueFrom<T>(
      String key, Map<dynamic, dynamic> json, dynamic defaultValue,
      {JsonReader<T?>? reader}) {
    if (defaultValue != null && defaultValue is ServerException) {
      throw defaultValue;
    }
    try {
      return EntityModel.getValueFromJson<T?>(key, json, defaultValue,
          reader: reader);
    } on Exception {
      throw CastErrorException();
    }
  }

  dynamic getValueFromBankDebitDetail(Map<String, dynamic> json) {
    if (json["bank_debit_detail"] is Map<String, dynamic>) {
      return BankDebitDetailModel.fromJson(json);
    } else {
      return json["bank_debit_detail"];
    }
  }

  Map<String, dynamic> getBankDebitDetail(String str) {
    Map<String, dynamic> tmp = json.decode(str);
    log(tmp.toString());
    return tmp;
  }
}

class PaginationModel extends Pagination {
  PaginationModel({
    this.first,
    this.prev,
    this.next,
    this.last,
    required this.total,
  });

  @override
  dynamic first;
  @override
  dynamic prev;
  @override
  dynamic next;
  @override
  dynamic last;
  @override
  int? total;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      PaginationModel(
        first: json["first"],
        prev: json["prev"],
        next: json["next"],
        last: json["last"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "prev": prev,
        "next": next,
        "last": last,
        "total": total,
      };
}
