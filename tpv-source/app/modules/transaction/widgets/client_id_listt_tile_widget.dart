// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '/app/modules/transaction/domain/entities/clientinvoice.dart';

class ClientIdListTileWidget extends StatelessWidget {
  ClientInvoice clientInvoiceModel;
  BuildContext context;
  final String? owner;
  final String? clientId;

  ClientIdListTileWidget(
      {this.owner,
      this.clientId,
      required this.context,
      required this.clientInvoiceModel});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double tileHeight = screenHeight / 12.0;
    final double fontSizeResponsive = 20 * screenHeight / 650.0;
    final double fontSizeResponsive2 = 15 * screenHeight / 650.0;
    String? owner = "";
    String? name = "";
    bool isGas = false;
    bool isElectricity = false;
    for (int i = 0; i <= 0; i++) {
      owner = clientInvoiceModel.invoices!.invoices[i].owner;
      name = clientInvoiceModel.invoices!.invoices[i].name;
      if (owner != null) {
        isElectricity = true;
      } else if (name != null) {
        isGas = true;
      }
    }
    return Card(
      elevation: 1,
      child: SizedBox(
        height: tileHeight,
        child: ListTile(
          tileColor: Colors.grey.shade100,
          title: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 100),
            child: isElectricity
                ? Text(
                    owner!,
                    style: TextStyle(
                        fontSize: fontSizeResponsive,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w300),
                  )
                : Text(
                    name!,
                    style: TextStyle(
                        fontSize: fontSizeResponsive,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w300),
                  ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 0),
            child: Text(
              'ID de cliente: ${clientInvoiceModel.clientId}',
              style: TextStyle(
                  fontSize: fontSizeResponsive2,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w200),
            ),
          ),
        ),
      ),
    );
  }
}
