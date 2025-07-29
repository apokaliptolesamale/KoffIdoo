class ListCard {
  ListCard({
    required this.card,
  });
  List<Card> card;
}

class Card {
  Card(
      {required this.cardUuid,
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
      required this.bankCertificate});
  String cardUuid;
  String last4;
  String cardholder;
  String expdate;
  String createdAt;
  String updatedAt;
  String status;
  String currency;
  String fundingSourceId;
  String fundingSourceUuid;
  String primarySource;
  String bankName;
  String bankCode;
  String verified;
  String bankCertificate;
}

enum BankName {
  BANCO_POPULAR_DE_AHORRO_BPA,
  BANCO_METROPOLITANO_S_A,
  BANCO_INTERNACIONAL_DE_COMERCIO_S_A_BICSA,
  BANCO_DE_CRDITO_Y_COMERCIO_BANDEC
}

enum Currency { CUP, USD, CUC }

class AddCard {
  AddCard({
    required this.pan,
    required this.cardholder,
    required this.expdate,
    required this.cadenaEncript,
    this.cm,
  });

  String pan;
  String cardholder;
  String expdate;
  String cadenaEncript;
  String? cm;
}

class SetAsDefaultCard {
  SetAsDefaultCard({
    required this.primary_source,
  });
  String primary_source;
}
