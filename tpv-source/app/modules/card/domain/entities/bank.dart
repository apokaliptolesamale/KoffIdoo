class ListBank {
  ListBank({
    required this.bank,
  });

  List<Bank> bank;
}

class Bank {
  String name;
  String code;
  String certificate;
  Bank({required this.name, required this.code, required this.certificate});
}
