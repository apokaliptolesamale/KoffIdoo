import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/app/widgets/utils/size_constraints.dart';
import '../../domain/entities/invoice.dart';
import 'invoice_gas_detail_widget.dart';

class InvoiceMonthGasWidget extends StatefulWidget {
  Invoice invoice;
  bool? isPayed;
  DateTime mensualidad;
  String? image;
  String amount;
  InvoiceMonthGasWidget(
      {super.key,
      required this.isPayed,
      this.image,
      required this.mensualidad,
      required this.amount,
      required this.invoice});

  @override
  State<InvoiceMonthGasWidget> createState() => _InvoiceMonthGasWidgetState();
}

class _InvoiceMonthGasWidgetState extends State<InvoiceMonthGasWidget> {
  @override
  Widget build(BuildContext context) {
    SizeConstraints sizeC = SizeConstraints(context: context);
    String month = DateFormat.MMMM('es').format(widget.mensualidad);

    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 7,
      width: size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "assets/images/backgrounds/enzona/factura_mensual_cupet.png"))),
      // padding: const EdgeInsets.only(left: 30),
      child: Stack(children: [
        Positioned(
          bottom: size.height / 20,
          left: size.width / 40,
          child: Container(
            width: size.width * 0.30,
            height: size.height / 15,
            child: Column(
              children: [
                Text(
                  "$month/${widget.mensualidad.year}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: size.width * 0.04,
                  ),
                ),
                SizedBox(
                  width: size.width / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.amount,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: size.width * 0.04,
                      ),
                    ),
                    SizedBox(
                      width: size.width / 70,
                    ),
                    Text(
                      "CUP",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: size.width * 0.04,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
            top: size.height / 30,
            right: size.width / 70,
            child: widget.isPayed!
                ? Container(
                    width: size.width * 0.30,
                    height: size.height / 20,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                InvoiceGasDetailWidget(
                                    month: month, invoice: widget.invoice
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
                  )
                : Container(
                    width: size.width * 0.30,
                    height: size.height / 20,
                    child: TextButton(
                      onPressed: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        height: MediaQuery.of(context).size.height * 0.10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey),
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
