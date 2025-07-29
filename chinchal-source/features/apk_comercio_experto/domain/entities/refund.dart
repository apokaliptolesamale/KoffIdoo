class Refund{
  final String? transactionUuid;
  final String? status;
  final String? transactionStatusCode;
  final String? createdAt;
  final String? updatedAt;
  final Map<String,dynamic>? amount;
  final String? parentPaymentUuid;
  final String? description;
  final String? transactionDenom;
  final List<dynamic>? links;
  final String? refundName;
  final String? refundLastName;
  final String? refundAvatar;
   

    Refund({
      this.transactionUuid, this.status, this.transactionStatusCode, this.createdAt, this.updatedAt, this.amount, this.parentPaymentUuid, this.description, this.transactionDenom, this.links, this.refundName,this.refundLastName, this.refundAvatar,    
        
    });
}

class HRefRefund{

  final String? rel;
  final String? method;
  final String? href;
  HRefRefund( {
    this.rel, this.method, this.href
  });
   
}

class AddRefund{
  final Map<String,dynamic> amount;
  final String commerceRefundId;
  final String username;
  final String description;
  AddRefund({
    required this.amount,
    required this.commerceRefundId,
    required this.username,
    required this.description,
  });
}