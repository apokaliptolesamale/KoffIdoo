import 'package:flutter/material.dart';

import '/app/modules/transaction/domain/entities/invoice.dart';
import '../custom_detail_list_tile.dart';

class InvoicePropertiesWidget extends StatefulWidget {
  Invoice? invoice;
  InvoicePropertiesWidget({super.key, required this.invoice});

  @override
  State<InvoicePropertiesWidget> createState() =>
      _InvoicePropertiesWidgetState();
}

class _InvoicePropertiesWidgetState extends State<InvoicePropertiesWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomDetailListTile(
              titulo: "Id. Cliente",
              value: widget.invoice!.clientId.toString(),
              fontWeight: false,
              context: context,
            ),
            CustomDetailListTile(
              titulo: "Titular",
              value: widget.invoice!.owner,
              fontWeight: false,
              context: context,
            ),
            CustomDetailListTile(
              titulo: "Fecha",
              value: "${widget.invoice!.period}/${widget.invoice!.year}",
              fontWeight: false,
              context: context,
            ),
            CustomDetailListTile(
              titulo: "Consumo",
              value: "${widget.invoice!.consumption}" " kwh",
              fontWeight: false,
              context: context,
            ),
            CustomDetailListTile(
              titulo: "Ruta",
              value: '${widget.invoice!.route}',
              fontWeight: false,
              context: context,
            ),
            CustomDetailListTile(
              titulo: "Folio",
              value: '${widget.invoice!.folio}',
              fontWeight: false,
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
