class Recipient {
  int? pan;
  String? fundingRecipientAvatar;
  String? fundingRecipientUsername;
  String? fundingRecipientName;
  String? fundingRecipientLastName;
  dynamic fundingRecipientVerified;
  int? fundingRecipientLast4;
  dynamic fundingRecipientBank;
  String? merchantAlias;
  String? merchantAvatar;
  Recipient({
    required this.pan,
    required this.fundingRecipientUsername,
    required this.fundingRecipientVerified,
    required this.fundingRecipientLast4,
    required this.fundingRecipientBank,
    required this.fundingRecipientName,
    required this.fundingRecipientLastName,
    required this.fundingRecipientAvatar,
    required this.merchantAlias,
    required this.merchantAvatar,
  });
}
