class OperationMerchant{
  final String? status;
    final String? transactionId;
    final String? username;
    final String? type;
    final String? currency;
    final String? createdAt;
    final String? updateAt;
    final String? description;
    final String? total;
    final String? shipping;
    final String? tax;
    final String? discount;
    final String? tip;
    final String? refundedAmount;
    final String? merchantOpId;
    final String? accountUuid;
    final String? name;
    final String? lastname;
    final String? avatar;
    final String? transactionUuid;
    final String? commissionCup;
    final String? commission;

    OperationMerchant({
        this.status,
        this.transactionId,
        this.username,
        this.type,
        this.currency,
        this.createdAt,
        this.updateAt,
        this.description,
        this.total,
        this.shipping,
        this.tax,
        this.discount,
        this.tip,
        this.refundedAmount,
        this.merchantOpId,
        this.accountUuid,
        this.name,
        this.lastname,
        this.avatar,
        this.transactionUuid,
        this.commissionCup,
        this.commission
    });
}