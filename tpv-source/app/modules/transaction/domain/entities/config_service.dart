class ClientService {
  String? denom;
  String? serviceUuid;
  String? fundingSourceUuid;
  String? clientId;
  String? automatic;
  String? owner;
  Map<String,dynamic>? metadata;
  String? createdAt;
  String? updatedAt;
  String? merchantAlias;
  String? type;

  ClientService({
    required this.denom,
    required this.serviceUuid,
    required this.fundingSourceUuid,
    required this.clientId,
    required this.automatic,
    required this.owner,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
    required this.merchantAlias,
    required this.type,
  });
}
