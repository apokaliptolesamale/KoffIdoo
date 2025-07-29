import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import 'package:get/get.dart';

import '/app/routes/app_pages.dart';
import 'filter_tabbar.dart';

class FilterTransactionsWidget extends StatefulWidget {
  BuildContext context;
  FilterTransactionsWidget({Key? key, required this.context}) : super(key: key);

  @override
  State<FilterTransactionsWidget> createState() =>
      _FilterTransactionsWidgetState();
}

class _FilterTransactionsWidgetState extends State<FilterTransactionsWidget> {
  @override
  Widget build(BuildContext context) {
    /*Size contextsize = MediaQuery.of(context).size;
    TransactionController transactionController =
        Get.find<TransactionController>();*/
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.7,
      child: AlertDialog(
        contentPadding: EdgeInsets.only(left: 5, right: 5, top: 2),
        elevation: 10,
        //title: Text('Material Dialog'),
        // ignore: sized_box_for_whitespace
        content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            child: FilterTabbar()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.30,
              height: MediaQuery.of(context).size.height * 0.070,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.blue),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Volver',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                log("OK");
                log("${Routes.getInstance.getRouteMap.entries}");
                Get.offAndToNamed("/transactions");
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.30,
                height: MediaQuery.of(context).size.height * 0.070,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Aceptar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Colors.white),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
