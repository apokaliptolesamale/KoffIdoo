import '/app/widgets/utils/size_constraints.dart';
import 'package:flutter/material.dart';

import '../../views/search_invoice_view.dart';
import 'invoice_detail_widget.dart';

class InvoiceMonthWidget extends StatefulWidget {
  bool? isPayed;
  String year;
  String month;
  String image;
  String amount;
  InvoiceMonthWidget(
      {super.key,
      required this.isPayed,
      required this.image,
      required this.month,
      required this.year,
      required this.amount});

  @override
  State<InvoiceMonthWidget> createState() => _InvoiceMonthWidgetState();
}

class _InvoiceMonthWidgetState extends State<InvoiceMonthWidget> {
  @override
  Widget build(BuildContext context) {
    SizeConstraints sizeC = SizeConstraints(context: context);
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 7,
      width: size.width,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(widget.image))),
      // padding: const EdgeInsets.only(left: 30),
      child: Stack(children: [
        Positioned(
          bottom: size.height / 30,
          left: size.width / 70,
          child: Container(
            width: size.width * 0.30,
            height: size.height / 20,
            child: widget.isPayed!
                ? Center(
                    child: Text(
                      widget.year,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: size.width * 0.04,
                      ),
                    ),
                  )
                : Center(
                    child: Column(
                      children: [
                        Text(
                          "${widget.month}"
                          "/${widget.year}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: size.width * 0.04,
                          ),
                        ),
                        Text(
                          widget.amount,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: size.width * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        Positioned(
            top: size.height / 30,
            right: size.width / 70,
            child: widget.isPayed!
                ? GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => SearchInvoiceView(
                            codeService: 1111,

                            //clientId: clientId,
                          ),
                        ),
                      );
                      /* Get.to(() => InvoiceDetailWidget(
                                invoice: invoices!.invoices[v],
                              ));*/
                    },
                    child: Container(
                      width: size.width * 0.30,
                      height: size.height / 20,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/backgrounds/enzona/ic_pagado.png")),
                      ),
                    ),
                  )
                : Container(
                    width: size.width * 0.30,
                    height: size.height / 20,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                InvoiceDetailWidget(
                                    //chargedI: charged,
                                    ),
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        height: MediaQuery.of(context).size.height * 0.10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Pagar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ))
      ]),
    );
  }
}
