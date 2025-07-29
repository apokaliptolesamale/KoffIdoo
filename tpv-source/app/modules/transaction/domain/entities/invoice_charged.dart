class InvoiceCharged {
  
    String? amount;
    String leaf;
    String? invoiceNumber;
    String? uuid;
    String rootTransactionId;
    String createdAt;
    String updatedAt;
    String? currency;
    String? transactionDenom;
    int? transactionCode;
    String description;
    String status;
    String statusCode;
    Map<String,dynamic>? bankDebitDetail;
    String? fundingSourceUuid;
    String? clientId;
    String? transactionSignature;
    int? discount;
   

  InvoiceCharged({
    required this.amount,
    required this.bankDebitDetail,
    required this.clientId,
    required this.currency,
    required this.fundingSourceUuid,
    required this.transactionCode,
    required this.transactionDenom,
    required this.transactionSignature,
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    required this.invoiceNumber,
    required this.leaf,
    required this.rootTransactionId,
    required this.status,
    required this.statusCode,
    required this.discount

  });

  
}