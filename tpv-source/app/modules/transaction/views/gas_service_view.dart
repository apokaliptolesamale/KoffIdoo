import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/modules/transaction/widgets/option_widget.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../domain/models/payment_model.dart';
import '../widgets/payments_widgets/pay_electricity_invoice_widget.dart';
import 'invoice_list_frame.dart';

class GasServiceView extends StatefulWidget {
  const GasServiceView({Key? key});

  @override
  State<GasServiceView> createState() => _GasServiceViewState();
}

class _GasServiceViewState extends State<GasServiceView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConstraints sizeContrains = SizeConstraints(context: context);
    // GasServiceController controller = GasServiceController(Get.find());
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  Get.toNamed(Routes.getInstance.getPath("GAS_HISTORICAL"));
                },
                child: Text(
                  'Historial',
                  style: TextStyle(
                      color: Colors.blue.shade200, fontSize: size.width / 40),
                ))
          ],
          title: const Text('Gas Manufacturado'),
          titleSpacing: sizeContrains.getHeightByPercent(-2),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/backgrounds/enzona/fondo_inicio_2.png"),
                    fit: BoxFit.fill)),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              // Get.toNamed(Routes.getInstance.getPath("ezhome"));
              Get.offAndToNamed(Routes.getInstance.getPath("ezhome"));
            },
          ),
        ),
        body: Column(
          children: [
            OptionWidget(
                icono: Icon(Icons.arrow_forward_ios),
                rutaAsset: "assets/images/icons/app/enzona/pagar_factura.png",
                texto: "Pagar factura",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        //return Container();
                        return PayElectricityInvoiceWidget(
                          context: context,
                          serviceCode: ServicesPayment.byCodeName("Gas"),
                        );
                      });
                }),
            OptionWidget(
                icono: Icon(Icons.arrow_forward_ios),
                rutaAsset: "assets/images/backgrounds/enzona/mis_facturas.png",
                texto: "Mis ID Cliente",
                onPressed: () {
                  // InvoiceBinding.loadPages();
                  final named =
                      Routes.getInstance.getPath("GAS_CLIENT_ID_LIST");
                  Get.toNamed(named);
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.4,
              child: Card(
                elevation: 2,
                child: ListView(
                  children: [
                    Center(
                      child: Text(
                        "Mis facturas a pagar",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width * 0.05),
                      ),
                    ),

                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.691,
                        child:
                            /* FutureBuilder(
                            future: ,
                            builder: ,)*/
                            InvoiceListFrameView(
                          serviceCode: "1111",
                        )) // InvoiceListFrameView())
                  ],
                ),
              ),
            ),
            /* Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.4,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height*0.1 ,
                    child: Card(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Mis facturas a pagar",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.width * 0.05),
                        ),
                      ),
                    ),
                  ),
                  ListView(
                    children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.691,
                        child:
                         /* FutureBuilder(
                            future: ,
                            builder: ,)*/
                            InvoiceListFrameView(
                              serviceCode: "1111" ,
                            )
                            
                            ) 
                    ],
                  ),
                ],
              ),
            ),*/
          ],
        ));
  }
}
