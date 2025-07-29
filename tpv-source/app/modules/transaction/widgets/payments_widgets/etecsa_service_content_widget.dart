import 'package:flutter/material.dart';

import '/app/modules/transaction/widgets/option_widget.dart';

class EtecsaServiceContentWidget extends StatefulWidget {
  const EtecsaServiceContentWidget({Key? key});

  @override
  State<EtecsaServiceContentWidget> createState() =>
      _EtecsaServiceContentWidgetState();
}

class _EtecsaServiceContentWidgetState
    extends State<EtecsaServiceContentWidget> {
  @override
  Widget build(BuildContext context) {
    //EtecsaServiceController controller = EtecsaServiceController(Get.find());
    return ListView(
      children: [
        OptionWidget(
            icono: Icon(Icons.arrow_forward_ios),
            rutaAsset: "assets/images/pagar_factura.png",
            texto: "Pagar factura",
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Container();
                    //return EtecsaPaymentWidget();
                  });
            }),
        OptionWidget(
            icono: Icon(Icons.arrow_forward_ios),
            rutaAsset: "assets/images/mis_facturas.png",
            texto: "Mis ID Cliente",
            onPressed: () {
              // Get.to(()=>AddUserEtecsaView(),transition: Transition.native, duration: Duration(milliseconds: 500 ));
            }),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.025,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.73,
          child: Card(
            elevation: 2,
            child: ListView(
              children: [
                Text(
                  "Mis facturas a pagar",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.691,
                  child: FutureBuilder(
                      //future: controller.getEtecsaInvoice(),
                      builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      // InvoiceList electricityInvoiceList = snapshot.data as InvoiceList;
                      return Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
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
