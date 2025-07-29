// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/modules/transaction/domain/models/payment_model.dart';
import '/app/modules/transaction/payment_exporting.dart';
import '/app/modules/transaction/views/invoice_list_frame.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../widgets/option_widget.dart';
import '../widgets/payments_widgets/pay_electricity_invoice_widget.dart';

class OnatServiceView extends GetView<PaymentController> {
  OnatServiceView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*FloatingActionButtonAnimator myButton =
        FloatingActionButtonAnimator.scaling;*/
    Size size = MediaQuery.of(context).size;
    SizeConstraints sizeContrains = SizeConstraints(context: context);
    return
        // GasServiceController controller = GasServiceController(Get.find());
        Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: () {
                      Get.toNamed(
                          Routes.getInstance.getPath("ONAT_HISTORICAL"));
                    },
                    child: Text(
                      'Historial',
                      style: TextStyle(
                          color: Colors.blue.shade200,
                          fontSize: size.width / 40),
                    ))
              ],
              title: const Text('Impuestos'),
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
                  Get.back();
                  // Get.toNamed(Routes.getInstance.getPath("ezhome"));
                  //Get.offAndToNamed(Routes.getInstance.getPath("ezhome"));
                },
              ),
            ),
            body: Column(
              children: [
                OptionWidget(
                    icono: Icon(Icons.arrow_forward_ios),
                    rutaAsset:
                        "assets/images/icons/app/enzona/pagar_factura.png",
                    texto: "Pagar Vector Fiscal",
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            //return Container();
                            return PayElectricityInvoiceWidget(
                              context: context,
                              serviceCode: ServicesPayment.byCodeName("Onat"),
                            );
                          });
                    }),
                OptionWidget(
                    icono: Icon(Icons.arrow_forward_ios),
                    rutaAsset:
                        "assets/images/backgrounds/enzona/mis_facturas.png",
                    texto: "Mis RC-05",
                    onPressed: () {
                      // InvoiceBinding.loadPages();
                      final named = Routes.getInstance.getPath("ONAT_RC_05");
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
                            "Mis tributos a pagar",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
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
                              serviceCode: "3333",
                            )) // InvoiceListFrameView())
                      ],
                    ),
                  ),
                ),
              ],
            ));
  }
}
