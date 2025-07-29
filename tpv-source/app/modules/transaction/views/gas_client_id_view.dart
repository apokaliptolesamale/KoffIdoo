import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/modules/transaction/clientinvoice_exporting.dart';
import '/app/modules/transaction/domain/models/clientinvoice_model.dart';
import '/app/modules/transaction/widgets/payments_widgets/Electricity_id_clients_search_widget.dart';
import '/app/modules/transaction/widgets/payments_widgets/add_user_electricity_id_client.dart';
import '/app/widgets/utils/size_constraints.dart';
import '../../../routes/app_routes.dart';
import 'client_id_li_frame_view.dart';

class GasClientIdView extends GetView<ClientInvoiceController> {
  ClientInvoiceList<ClientInvoiceModel>? clienIds;

  GasClientIdView({this.clienIds});

  @override
  Widget build(BuildContext context) {
    SizeConstraints sizeConstraints = SizeConstraints(context: context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mis ID cliente'),
          titleSpacing: sizeConstraints.getHeightByPercent(-2),
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
              Get.offNamed(Routes.getInstance.getPath("GAS"));
              //Get.back();
            },
          ),
        ),
        body: Container(
          // color: Colors.red,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: ListView(
              children: [
                //ClientIdListFrameView()
                AddUserElectricityIdClientWidget(
                  press: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SearchElectricityIdClientWidget(
                            context: context,
                            code: 1111,
                          );
                        });
                  },
                ),
                ClientIdListFrame(
                  codeS: "1111",
                  type: "Pago de Factura del Gas",
                )
              ],
            ),
          ),
        ));
  }
}
