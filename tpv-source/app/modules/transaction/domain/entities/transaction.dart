

import '/app/modules/transaction/domain/entities/bank_debit_detail.dart';

import '/app/modules/transaction/domain/entities/recipient.dart';
import '/app/modules/transaction/domain/entities/source.dart';

class Pagination {
  dynamic first;
  dynamic prev;
  dynamic next;
  dynamic last;
  int? total;

  Pagination({
    this.first,
    this.prev,
    this.next,
    this.last,
    this.total,
  });
}

class Transaction {
  BankDebitDetail? bankDebtitDetail;
  int? clientId;
  String? invoice;
  String? owner;
  String? merchantName;
  String? merchantAlias;
  String? merchantAvatar;
  int? transactionStatusCode;
  String? transactionStatus;
  DateTime transactionCreatedAt;
  DateTime? period;
  String? transactionSignature;
  double? amount;
  String? currency;
  String? transactionDenom;
  String? statusDenom;
  int? transactionCode;
  bool? barcode;
  bool? totalAmount;
  String? transactionDescription;
  Source? source;
  Recipient? recipient;
  int? statusCode;
  Transaction({
    required this.bankDebtitDetail,
    required this.owner,
    required this.clientId,
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
    required this.merchantName,
    required this.merchantAlias,
    required this.merchantAvatar,
    required this.period
    
  });
}
