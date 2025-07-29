// ignore_for_file: must_be_immutable

import '/app/core/services/logger_service.dart';
import '/app/modules/security/domain/models/account_model.dart';
import '/app/modules/transaction/domain/entities/transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UtilWidget extends StatelessWidget {
  Transaction transaction;
  UtilWidget({Key? key, required this.transaction});

  Map<String, dynamic> addEntrie(Transaction transaction) {
    Map<String, dynamic> map;
    if (transaction.bankDebtitDetail !=
            null /*&&
        transaction.bankDebtitDetail!.discount != null &&
        transaction.bankDebtitDetail!.redsa != null*/
        ) {
      map = <String, dynamic>{
        "Bonficacion REDSA": "", //transaction.bankDebtitDetail!.redsa,
        "Bonficacion": "" //transaction.bankDebtitDetail!.redsa
      };
      return map;
    } else if (transaction.bankDebtitDetail == null) {
      return map = {};
    } else if (transaction.bankDebtitDetail is String) {
      return map = {};
    } else {
      return map = {};
    }
  }

  List<Widget> getMapByInfo(
      Transaction transaction, BuildContext context, AccountModel account) {
    // bool haveBank = itHaveBank(bank);
    /*BankDebitDetail bankDebitDetail ;
   bankDebitDetail = transaction.bankDebtitDetail as BankDebitDetail;*/
    Card info = Card(
      elevation: 2,
      child: Row(children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.08,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          /*child: Container(
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.height * 0.15,
                child: Image.asset(bank) : Icon(Icons.credit_card))*/
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 15,
        ),
        FittedBox(
          child: Text(
            "${account.name} ${account.lastname}",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: MediaQuery.of(context).size.width / 30,
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width / 15),
        /*FittedBox(
            fit: BoxFit.contain, child: getLast4BySource(transaction, context)),
        Text(
          transaction.currency!.toUpperCase(),
          style: TextStyle(fontSize: MediaQuery.of(context).size.width / 30),
        )*/
      ]),
    );
    List<Widget> mapWidgets = [];
    Map<String, dynamic> map = {};
    map.addIf(
        transaction.clientId != null, "Id. Cliente", transaction.clientId);
    map.addIf(transaction.transactionDescription != "", "Descripción",
        transaction.transactionDescription);
    map.addIf(
        transaction.owner != "", "Titular", transaction.owner!.toUpperCase());
    // map.addIf(transaction.transactionCreatedAt !=null, "Fecha", transaction.transactionCreatedAt);
    map.addIf(transaction.invoice != "", "No. Factura", transaction.invoice);
    map.addIf(transaction.transactionSignature != null, "No. Operación",
        transaction.transactionSignature);
    map.addEntries(addEntrie(transaction).entries);

    log(map.entries);
    for (var entry in map.entries) {
      ListTile listile = ListTile();
      if (map.containsKey("Bonficacion REDSA") &&
          map.containsKey("Bonficacion ")) {
        listile = ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 1),
          leading: Text(
            "${entry.key}:",
            maxLines: 5,
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: MediaQuery.of(context).size.width / 23,
                fontWeight: FontWeight.w500),
          ),
          trailing: Text(
            entry.value,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: TextStyle(
                color: Colors.grey.shade600,
                fontFamily: 'Roboto',
                fontSize: MediaQuery.of(context).size.width / 30,
                fontWeight: FontWeight.w500),
          ),
        );
      } else {
        listile = ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 1),
          leading: Text(
            "${entry.key}:",
            maxLines: 5,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: MediaQuery.of(context).size.width / 23,
            ),
          ),
          trailing: Text(
            entry.value,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontFamily: 'Roboto',
              fontSize: MediaQuery.of(context).size.width / 30,
            ),
          ),
        );
      }
      mapWidgets.add(listile);
      mapWidgets.add(Divider(
        thickness: 1,
      ));
    }
    mapWidgets.add(info);
    return mapWidgets;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

/*Map<String, dynamic> addEntrie(Transaction transaction) {
  Map<String, dynamic> map;
  if (transaction.bankDebtitDetail !=
          null /*&&
        transaction.bankDebtitDetail!.discount != null &&
        transaction.bankDebtitDetail!.redsa != null*/
      ) {
    map = <String, dynamic>{
      "Bonficacion REDSA": "", //transaction.bankDebtitDetail!.redsa,
      "Bonficacion": "" //transaction.bankDebtitDetail!.redsa
    };
    return map;
  } else if (transaction.bankDebtitDetail == null) {
    return map = {};
  } else if (transaction.bankDebtitDetail is String) {
    return map = {};
  } else {
    return map = {};
  }
}*/
  /* bool itHaveBank(String picture) {
    if (bank == "") {
      return false;
    } else {
      return true;
    }
  }*/
}
