import 'package:flutter/material.dart';

import '/app/modules/transaction/domain/entities/invoice.dart';
import '../custom_detail_list_tile.dart';

class InvoicePropertiesEz extends StatefulWidget {
  String? consumption;
  Invoice? invoice;
  InvoicePropertiesEz({super.key, this.invoice, this.consumption});

  @override
  State<InvoicePropertiesEz> createState() => _InvoicePropertiesEzState();
}

class _InvoicePropertiesEzState extends State<InvoicePropertiesEz> {
  @override
  Widget build(BuildContext context) {
    DateTime period = DateTime.parse(widget.invoice!.period!);
    return Card(
      elevation: 1,
      child: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.invoice!.clientId != ""
                ? CustomDetailListTile(
                    titulo: "Id. Cliente",
                    value: widget.invoice!.clientId.toString(),
                    fontWeight: false,
                    context: context,
                  )
                : widget.invoice!.code != ""
                    ? CustomDetailListTile(
                        titulo: "Id. Cliente",
                        value: widget.invoice!.code.toString(),
                        fontWeight: false,
                        context: context,
                      )
                    : Container(
                        height: 0,
                      ),
            widget.invoice!.owner != ""
                ? CustomDetailListTile(
                    titulo: "Titular",
                    value: widget.invoice!.owner,
                    fontWeight: false,
                    context: context,
                  )
                : widget.invoice!.name != ""
                    ? CustomDetailListTile(
                        titulo: "Titular",
                        value: widget.invoice!.name,
                        fontWeight: false,
                        context: context,
                      )
                    : Container(
                        height: 0,
                      ),
            widget.invoice!.period != ""
                ? CustomDetailListTile(
                    titulo: "Fecha",
                    value: "${period.month}/${period.year}",
                    fontWeight: false,
                    context: context,
                  )
                : widget.invoice!.mensualidad != DateTime.now()
                    ? CustomDetailListTile(
                        titulo: "Fecha",
                        value:
                            "${widget.invoice!.mensualidad!.month}/${widget.invoice!.mensualidad!.year}",
                        fontWeight: false,
                        context: context,
                      )
                    : Container(
                        height: 0,
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
            widget.invoice!.gasConsumption != ""
                ? CustomDetailListTile(
                    titulo: "Consumo",
                    value: "${widget.invoice!.gasConsumption}" " m cubicos",
                    fontWeight: false,
                    context: context,
                  )
                : widget.invoice!.consumption != ""
                    ? CustomDetailListTile(
                        titulo: "Consumo",
                        value: "${widget.invoice!.consumption}" "kw/h",
                        fontWeight: false,
                        context: context,
                      )
                    : Container(
                        height: 0,
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
              value: '${widget.invoice!.invoiceEz}',
              fontWeight: false,
              context: context,
            ),
            CustomDetailListTile(
              titulo: "No. Operacion",
              value: '${widget.invoice!.transactionSignature}',
              fontWeight: false,
              context: context,
            ),
            widget.invoice!.metadata!["ruta"] != ""
                ? CustomDetailListTile(
                    titulo: "Ruta",
                    value: '${widget.invoice!.metadata!["ruta"]}',
                    fontWeight: false,
                    context: context,
                  )
                : Container(
                    height: 0,
                  ),
            widget.invoice!.metadata!["folio"] != ""
                ? CustomDetailListTile(
                    titulo: "Folio",
                    value: '${widget.invoice!.metadata!["folio"]}',
                    fontWeight: false,
                    context: context,
                  )
                : Container(
                    height: 0,
                  ),
            CustomDetailListTile(
              titulo: "Bonficacion",
              value: '3' '',
              fontWeight: true,
              context: context,
            ),
            CustomDetailListTile(
              titulo: "Bonficacion REDSA",
              value: '1',
              fontWeight: true,
              context: context,
            )
          ],
        ),
      ),
    );
  }
}
