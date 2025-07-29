class Payment {

  Payment({
     this.merchantUuId,
     this.merchantName,
     this.merchantAlias,
     this.merchantAvatar,
     this.merchantOpId,
     this.transactionUuId,
     this.statusCode,
     this.transactionCreatedAt,
     this.transactionUpdatedAt,
     this.transctionSignature,
     this.leaf,
     this.refundedAmount,
     this.currency,
     this.transactionDescription,
     this.transactionDenom,
     this.transactionCode,
     this.comission,
     this.terminalId,
     this.invoiceNumber,
     this.userName,
     this.name,
     this.lastName,
     this.avatar,
     this.items,
     this.invoiceService,
     this.verified,
     this.userUuid,
    
  });

 String? merchantUuId;
 String? merchantName;
 String? merchantAlias;
 String? merchantAvatar;
 String? merchantOpId;
 String? transactionUuId;
 String? statusCode;
 DateTime? transactionCreatedAt;
 DateTime? transactionUpdatedAt;
 String? transctionSignature;
 String? leaf;
 String? refundedAmount;
 String? currency;
 String? transactionDescription;
 String? transactionDenom;
 String? transactionCode;
 String? comission;
 String? terminalId;
 String? invoiceNumber;
 String? userName;
 String? name;
 String? lastName;
 String? avatar;
 Map<String,dynamic>? items;
 Map<String,dynamic>? invoiceService;
 String? verified;
 String? userUuid;


}