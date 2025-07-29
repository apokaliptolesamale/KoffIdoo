// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/modules/transaction/domain/models/invoice_model.dart';
import '/app/modules/transaction/widgets/option_widget.dart';
import '/app/modules/transaction/widgets/payments_widgets/add_user_cuban_email_widget.dart';
import '/app/modules/transaction/widgets/payments_widgets/enviar_giro_view.dart';

class OnatServiceInvoices extends StatefulWidget {
  InvoiceList<InvoiceModel> invoices;
  OnatServiceInvoices({Key? key, required this.invoices});

  @override
  State<OnatServiceInvoices> createState() => _OnatServiceInvoicesState();
}

class _OnatServiceInvoicesState extends State<OnatServiceInvoices> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OptionWidget(
            icono: Icon(Icons.arrow_forward_ios),
            rutaAsset: "assets/images/pagar_factura.png",
            texto: "Enviar Giro",
            onPressed: () {
              Get.to(() => EnviarGiroView());
            }),
        OptionWidget(
            icono: Icon(Icons.arrow_forward_ios),
            rutaAsset: "assets/images/mis_facturas.png",
            texto: "Mis destinatarios",
            onPressed: () {
              Get.to(() => AddUserOnat(
                    press: () {},
                  ));
            }),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.025,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.73,
          child: Card(
            elevation: 2,
            child: Column(
              children: [
                Text(
                  "Giros",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.691,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: ListView.builder(
                                itemCount: widget.invoices.getTotal,
                                padding: const EdgeInsets.all(1.0),
                                itemBuilder: (context, index) {
                                  //return Container();
                                  return ListTile(
                                    leading: Text(widget.invoices
                                        .getList()
                                        .elementAt(index)
                                        .invoiceEz!),
                                  );
                                }))
                      ],
                    ))
              ],
            ),
          ),
        ),
        /* Container(
               width: MediaQuery.of(context).size.width,
               height: MediaQuery.of(context).size.height/5,
               child: ListView()
             )*/
      ],
    );
  }
}
