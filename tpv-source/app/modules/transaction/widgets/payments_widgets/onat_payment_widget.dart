import 'package:flutter/material.dart';

import '/app/modules/transaction/widgets/option_widget.dart';

class ShowTaxesWidget extends StatefulWidget {
  const ShowTaxesWidget({Key? key});

  @override
  State<ShowTaxesWidget> createState() => _ShowTaxesWidgetState();
}

class _ShowTaxesWidgetState extends State<ShowTaxesWidget> {
  @override
  Widget build(BuildContext context) {
    // OnatPaymentsController controller = Get.find();
    return ListView(
      children: [
        OptionWidget(
            icono: Icon(Icons.arrow_forward_ios),
            rutaAsset: "assets/images/pagar_factura.png",
            texto: "Pagar vector fiscal",
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Container();
                    //return PayTaxesWidget();
                  });
            }),
        OptionWidget(
            icono: Icon(Icons.arrow_forward_ios),
            rutaAsset: "assets/images/mis_facturas.png",
            texto: "Mis RC-05",
            onPressed: () {
              //Get.to(()=>AddOnatView(), transition: Transition.native, duration: Duration(milliseconds: 700));
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
                  "Mis tributos a pagar",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.691,
                  child: FutureBuilder(
                      // future: controller.getOnatInvoice(),
                      builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      // InvoiceList electricityInvoiceList = snapshot.data as InvoiceList;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: ListView.builder(
                                  // itemCount: electricityInvoiceList.invoice.length,
                                  padding: const EdgeInsets.all(1.0),
                                  itemBuilder: (context, index) {
                                    //return Container();
                                    return ListTile(
                                        //  leading:Text( electricityInvoiceList.invoice[index].transactionDenom.toString()),

                                        );
                                  }))
                        ],
                      );
                    }
                  }),
                )
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
