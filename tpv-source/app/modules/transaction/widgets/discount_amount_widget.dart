// ignore_for_file: must_be_immutable

import '/app/modules/transaction/domain/entities/invoice.dart';

import '/app/modules/transaction/domain/entities/transaction.dart';
import 'package:flutter/material.dart';

class DiscountAmountWidget extends StatelessWidget {
  Transaction transaction;
  int plusBonus;
  BuildContext context;
  DiscountAmountWidget(
      {Key? key,
      required this.transaction,
      required this.plusBonus,
      required this.context});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(height: MediaQuery.of(context).size.height / 400),
          Text(
            "-400 CUP",
            //"${transaction.amount} ${transaction.currency!.toUpperCase()}",
            //"${transaction.amount}",
            style: TextStyle(
                decoration: TextDecoration.lineThrough,
                fontSize: MediaQuery.of(context).size.width / 24,
                fontFamily: "Roboto",
                color: Colors.grey),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 150,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              Text(
                "-200 CUP",
                //"${transaction.bankDebtitDetail!.debited} ${transaction.currency!.toUpperCase()}",
                //  "${transaction.bankDebtitDetail!.debited}",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 18,
                    fontFamily: "Roboto"),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
              ),
              Chip(
                label: Text(
                  "-10%",
                  //"-${plusBonus(transaction)}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width / 24,
                      fontFamily: "Roboto"),
                ),
                backgroundColor: Colors.red,
              )
            ],
          ),
        ]),
      )
    ]);
  }
}

class DiscountPriceWidget extends StatelessWidget {
  Invoice invoice;
  final double originalPrice;
  final String discountPrice;
  final String discount;
  final String currency;
  BuildContext context;

  DiscountPriceWidget(
      {required this.originalPrice,
      required this.discountPrice,
      required this.discount,
      required this.currency,
      required this.context,
      required this.invoice});

  /*int plusBonus(Invoice invoice) {
    var bonus = invoice.bankDebtitDetail[""]
    var redsa = invoice.bankDebtitDetail!.redsa;
    int bonu = int.parse(bonus!);
    int reds = int.parse(redsa!);
    return bonu + reds;
  }*/

  @override
  Widget build(BuildContext context) {
    //double discountPercent = ((originalPrice - discountPrice) / originalPrice) * 100;
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: size.width * 0.15,
          child: FittedBox(
            child: Text(
              '${originalPrice.toStringAsFixed(2)} CUP',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                color: Colors.grey[600],
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ),
        ),
        SizedBox(width: size.width / 10),
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.15,
                child: FittedBox(
                  child: Text(
                    '$discountPrice CUP',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: size.width / 50),

              /*FittedBox(
                    child: Text(
                      currency,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width*0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),*/

              Chip(
                label: Text(
                  '3' '%',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 70,
        ),
      ],
    );
  }
}
