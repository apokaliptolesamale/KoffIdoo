import 'recipient_gift.dart';
import 'source_gift.dart';

class ListGift {
  ListGift({required this.avatars, required this.listGift});
  Map<String, dynamic> avatars;
  List<Gift> listGift;
}

class Gift {
  Gift({
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
    required this.recipient,
  });
  String uuid;
  int transactionCode;
  int statusCode;
  String statusDenom;
  String description;
  double amount;
  String createdAt;
  String transactionSignature;
  String currency;
  String cardGiftUuid;
  String cardReference;
  SourceGift source;
  RecipientGift recipient;
}
