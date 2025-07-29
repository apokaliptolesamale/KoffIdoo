class DonationList {
  DonationList({
    required this.donation,
  });

  List<Donation> donation;
}

class Donation {
  Donation({
    required this.uuid,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.images,
    required this.currency,
    required this.tipoDeCambio,
    required this.statusCode,
    required this.statusDenom,
  });

  String? uuid;
  String? title;
  String? description;
  String? createdAt;
  Map<String, dynamic>? images;
  String? currency;
  String? tipoDeCambio;
  String? statusCode;
  String? statusDenom;
}

class CreateDonation {
  CreateDonation({
    required this.fundingSourceUuid,
    required this.description,
    required this.donationUuid,
    required this.amount,
    required this.currency,
    required this.paymentPassword,
    required this.fingerprint,
  });

  String? fundingSourceUuid;
  String? description;
  String? donationUuid;
  String? amount;
  String? currency;
  String? paymentPassword;
  String? fingerprint;
}