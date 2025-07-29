class Balance {
  Balance({
    required this.balance,
    required this.bankAccount,
    required this.balanceAvailable,
    required this.statusCode,
    required this.statusDenom,
    required this.transactionSignature,
    required this.currency,
    required this.balanceCred,
  });

  String bankAccount;
  double balance;
  double balanceAvailable;
  int statusCode;
  String statusDenom;
  String transactionSignature;
  String currency;
  double balanceCred;
}
