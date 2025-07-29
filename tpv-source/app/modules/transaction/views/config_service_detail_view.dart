// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/modules/transaction/bindings/clientinvoice_binding.dart';
import '/app/modules/transaction/domain/models/clientinvoice_model.dart';
import '../domain/entities/config_service.dart';
import '../widgets/alert_dialog_delete_client_id_form_transaction.dart';
import '../widgets/custom_detail_list_tile.dart';

class ConfigServiceDetailView extends StatelessWidget {
  ClientInvoiceList<ClientInvoiceModel>? clientModel;
  ClientService? clientService;

  ConfigServiceDetailView({this.clientModel, this.clientService});

  @override
  Widget build(BuildContext context) {
    Get.put<ClientInvoiceBinding>(ClientInvoiceBinding());
    //ClientInvoiceController clientController = Get.find<ClientInvoiceController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuracion'),
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
            //Get.toNamed(Routes.getInstance.getPath("ELECTRICITY"));
            Get.back();
            /*final named =
                      Routes.getInstance.getPath("GAS_CLIENT_ID_LIST");
                  Get.offNamed(named);*/
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.30,
            child: Card(
              elevation: 1,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        CustomDetailListTile(
                          titulo: "Id. Cliente",
                          value: clientService!.clientId,
                          fontWeight: false,
                          context: context,
                        ),
                        CustomDetailListTile(
                          titulo: "Titular",
                          value: clientService!.owner,
                          fontWeight: false,
                          context: context,
                        ),
                        clientService!.metadata!["route"] != null
                            ? CustomDetailListTile(
                                titulo: "Ruta",
                                value: "${clientService!.metadata!["route"]}",
                                fontWeight: false,
                                context: context,
                              )
                            : Container(
                                height: 0,
                              ),
                        clientService!.metadata!["folio"] != null
                            ? CustomDetailListTile(
                                titulo: "Folio",
                                value: "${clientService!.metadata!["folio"]}",
                                fontWeight: false,
                                context: context,
                              )
                            : Container(
                                height: 0,
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              // Crea un objeto AlertDialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialogDeleteClientIdFormTransaction(
                    serviceUuid: clientService!.serviceUuid!,
                    clientId: clientService!.clientId!,
                  );
                },
              );
            },
            child: Card(
              elevation: 1,
              child: Container(
                color: Colors.white,
                child: ListTile(
                    style: ListTileStyle.list,
                    leading: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: CircleAvatar(
                        radius: 20,
                        child: Image.asset(
                          "assets/images/icons/app/enzona/eliminar.png",
                          scale: 0.5,
                        ),
                      ),
                    ),
                    title: Text(
                      "Eliminar",
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: MediaQuery.of(context).size.width / 25),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
