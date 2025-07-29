import 'package:flutter/material.dart';

import '/app/modules/transaction/domain/entities/invoice.dart';
import '../custom_detail_list_tile.dart';

class InvoiceUnPaidWidget extends StatefulWidget {
  String? consumption;
  Invoice? invoice;
  String? month;
  InvoiceUnPaidWidget(
      {super.key, this.invoice, this.consumption, required this.month});

  @override
  State<InvoiceUnPaidWidget> createState() => _InvoiceUnPaidWidgetState();
}

class _InvoiceUnPaidWidgetState extends State<InvoiceUnPaidWidget> {
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
              value: widget.invoice!.code.toString(),
              fontWeight: false,
              context: context,
            ),
            CustomDetailListTile(
              titulo: "Titular",
              value: widget.invoice!.name,
              fontWeight: false,
              context: context,
            ),
            CustomDetailListTile(
              titulo: "Fecha",
              value: "${widget.month}/${widget.invoice!.mensualidad!.year}",
              fontWeight: false,
              context: context,
            ),
            widget.invoice!.lectura != ""
                ? CustomDetailListTile(
                    titulo: "Lectura",
                    value: '${widget.invoice!.lectura}',
                    fontWeight: false,
                    context: context,
                  )
                : Container(
                    height: 0,
                  ),
            CustomDetailListTile(
              titulo: "Consumo",
              value: "${widget.invoice!.gasConsumption}" " m cubicos",
              fontWeight: false,
              context: context,
            ),
            widget.invoice!.importe != ""
                ? CustomDetailListTile(
                    titulo: "Importe",
                    value: '${widget.invoice!.importe}',
                    fontWeight: false,
                    context: context,
                  )
                : Container(
                    height: 0,
                  ),
            widget.invoice!.postVenta != ""
                ? CustomDetailListTile(
                    titulo: "Post-venta",
                    value: '${widget.invoice!.postVenta}',
                    fontWeight: false,
                    context: context,
                  )
                : Container(
                    height: 0,
                  ),
            widget.invoice!.saldo != ""
                ? CustomDetailListTile(
                    titulo: "Saldo",
                    value: '${widget.invoice!.saldo}',
                    fontWeight: false,
                    context: context,
                  )
                : Container(
                    height: 0,
                  ),
            widget.invoice!.cobrador != ""
                ? CustomDetailListTile(
                    titulo: "ID del cobrador",
                    value: '${widget.invoice!.cobrador}',
                    fontWeight: false,
                    context: context,
                  )
                : Container(
                    height: 0,
                  ),
            widget.invoice!.metro != ""
                ? CustomDetailListTile(
                    titulo: "Metrocontador",
                    value: '${widget.invoice!.metro}',
                    fontWeight: false,
                    context: context,
                  )
                : Container(
                    height: 0,
                  ),
            CustomDetailListTile(
              titulo: "No. Factura",
              value: '${widget.invoice!.noFactura}',
              fontWeight: false,
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
