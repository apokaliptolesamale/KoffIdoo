// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '/app/modules/transaction/domain/entities/invoice.dart';
import '/app/modules/transaction/domain/models/invoice_model.dart';
import '/app/modules/transaction/widgets/payments_widgets/listtile_invoice_widget.dart';

class ListElectricityHistoricalSimpleWidget extends StatefulWidget {
  int? total;
  InvoiceList<InvoiceModel> invoiceList;
  ListElectricityHistoricalSimpleWidget(
      {Key? key, required this.invoiceList, this.total});

  @override
  State<ListElectricityHistoricalSimpleWidget> createState() =>
      _ListElectricityHistoricalSimpleWidgetState();
}

class _ListElectricityHistoricalSimpleWidgetState
    extends State<ListElectricityHistoricalSimpleWidget> {
  @override
  Widget build(BuildContext context) {
    List<Invoice> transactionList = widget.invoiceList.invoices;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            //controller: controller,
            itemCount: transactionList.length,
            padding: const EdgeInsets.all(2.0),
            itemBuilder: (context, index) {
              return ListTileinvoice(
                invoice: transactionList[index],
                context: context,
              );
            },
          ),
        ),
      ],
    );
  }
}
