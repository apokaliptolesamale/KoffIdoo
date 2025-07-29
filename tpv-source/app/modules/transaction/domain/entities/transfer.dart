import '../models/transfer_model.dart';

class Transfer {
  final dynamic idTransfer;
  String transferUUID;
  String transactionCode;
  String transactionSignature;
  String statusCode;
  String statusDenom;
  DateTime createAt;
  Source source;
  Recipient recipient;
  String recipientUsername;
  String tipoCambio;
  String amount;
  String pan;
  String cardFundingSourceUuid;

  String? description;
  String currency;
  String paymentPassword;
  String? fingerprint;
  String? phone;
  Transfer(
      {required this.transferUUID,
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
      required this.currency,
      required this.paymentPassword,
      this.idTransfer,
      this.description,
      this.fingerprint,
      this.phone,
      required this.cardFundingSourceUuid});
}
