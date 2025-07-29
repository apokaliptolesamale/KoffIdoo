import '/app/modules/transaction/widgets/payments_widgets/invoice_month_gas_widget.dart';

import '/app/modules/transaction/domain/entities/clientinvoice.dart';
import '/app/modules/transaction/domain/models/clientinvoice_model.dart';
import 'package:flutter/material.dart';
import '/app/modules/transaction/widgets/client_id_listt_tile_widget.dart';

class ClientInvoiceWidget extends StatelessWidget {
  final ClientInvoiceList? facturas;
  BuildContext context;

  ClientInvoiceWidget({this.facturas, required this.context});

  @override
  Widget build(BuildContext context) {
    List<ClientInvoice> invoiceList = facturas!.clientinvoices;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: invoiceList.length,
            itemBuilder: (context, index) {
              final factura = invoiceList[index];
              return Column(
                children: [
                  ClientIdListTileWidget(
                      context: context, clientInvoiceModel: invoiceList[index]),
                  InvoiceMonthGasWidget(
                    invoice: factura.invoices!.invoices[index],
                    isPayed: factura.invoices!.invoices[index] ==
                        factura.invoices!.invoices[0],
                    mensualidad: factura.invoices!.invoices[index].mensualidad!,
                    amount: factura.invoices!.invoices[index].importe!,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
