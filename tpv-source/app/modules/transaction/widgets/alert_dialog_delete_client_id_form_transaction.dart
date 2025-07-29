import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import 'package:get/get.dart';

import '/app/modules/transaction/clientinvoice_exporting.dart';

class AlertDialogDeleteClientIdFormTransaction extends StatefulWidget {
  String serviceUuid;
  String? clientId;
  AlertDialogDeleteClientIdFormTransaction(
      {super.key, required this.serviceUuid, this.clientId});

  @override
  State<AlertDialogDeleteClientIdFormTransaction> createState() =>
      _AlertDialogDeleteClientIdFormTransactionState();
}

class _AlertDialogDeleteClientIdFormTransactionState
    extends State<AlertDialogDeleteClientIdFormTransaction> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //title: Text('Eliminar ${widget.itemName}'),
      content: Text('¿Estás seguro de que deseas eliminar ${widget.clientId}?'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                ClientInvoiceController controller =
                    Get.find<ClientInvoiceController>();
                //int serviceUuid = int.parse(widget.serviceUuid);
                Map<String, dynamic> params = {
                  "serviceUuid": widget.serviceUuid
                };
                controller.deleteClientClientIdUseCase.setParamsFromMap(params);
                controller.deleteClientClientIdUseCase.deleteClientID();
                final named =
                    Routes.getInstance.getPath("ELECTRICITY_ADD_CLIENT_ID");
                Get.toNamed(named);
              },
            ),
          ],
        ),
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      scrollable: true,
      titlePadding:
          EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
      title: Center(child: Text("Pagar factura")),
      contentPadding: EdgeInsets.only(
          left: 5, right: 5, top: MediaQuery.of(context).size.height / 30),
      elevation: 10,
    );
  }
}
