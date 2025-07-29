// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/modules/transaction/clientinvoice_exporting.dart';
import '/app/modules/transaction/domain/models/clientinvoice_model.dart';
import '/app/modules/transaction/widgets/payments_widgets/Electricity_id_clients_search_widget.dart';
import '/app/modules/transaction/widgets/payments_widgets/add_user_electricity_id_client.dart';
import '../../../routes/app_routes.dart';
import 'client_id_li_frame_view.dart';

class ElectricityIdClientView extends GetView<ClientInvoiceController> {
  ClientInvoiceList<ClientInvoiceModel>? clienIds;

  ElectricityIdClientView({this.clienIds});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Configurar usuarios'),
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
              Get.offNamed(Routes.getInstance.getPath("ELECTRICITY"));
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
                            code: 2222,
                          );
                        });
                  },
                ),
                ClientIdListFrame(codeS: "2222", type: "Electricidad")
              ],
            ),
          ),
        ));
  }
}




/*class ElectricityIdClientView extends GetView<ClientInvoiceController> {
  ClientInvoiceList<ClientInvoiceModel>? clienIds;

  ElectricityIdClientView({this.clienIds});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Configurar usuarios'),
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
              Get.toNamed(Routes.getInstance.getPath("ELECTRICITY"));
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
                          return SearchElectricityIdClientWidget();
                        });
                  },
                ),
                ClientIdListFrameView()
              ],
            ),
          ),
        ));
  }*/

