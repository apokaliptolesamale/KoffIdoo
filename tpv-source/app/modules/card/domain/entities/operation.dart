class Operations {
  Operations({
    required this.operation,
  });

  List<Operation> operation;
}

class Operation {
  Operation({
    required this.operationDate,
    required this.action,
    required this.channel,
    required this.description,
    required this.amount,
    required this.codigo,
    required this.avatar,
    required this.alias,
  });

  String operationDate;
  String action;
  String channel;
  String description;
  String amount;
  String codigo;
  String avatar;
  String alias;
}

enum Channel { POS, ATM }

//enum OperationDate { THE_160822 }

enum Action { DB }
