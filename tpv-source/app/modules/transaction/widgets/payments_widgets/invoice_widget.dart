// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';


import '../../domain/models/invoice_model.dart';
import 'invoice_month_electricty_widget.dart';

class InvoiceWidget extends StatelessWidget {
  String? clientId;
  InvoiceList<InvoiceModel>? invoices;
  String? charged;
  BuildContext? context;
  InvoiceWidget(
      {Key? key, this.invoices, this.context, this.charged, this.clientId});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? image;
    bool? isPayed = false;

    List<Widget> listaFacturaMensual = [];
    Widget gesture = Container();

    if (invoices!.getTotal > 0) {
      String? amount;
      String? month;
      String? year;
      for (var v = 0; v < invoices!.getTotal;) {
        // isPayed = invoices!.invoices[v].charged!;
        if (invoices!.invoices[v].charged! == "true") {
          isPayed = true;
        } else if (invoices!.invoices[v].charged! == "false") {
          isPayed = false;
        }
        switch (invoices!.invoices[v].transactionDenom) {
          case "Pago de Factura Electrica":
            image =
                "assets/images/backgrounds/enzona/factura_mensual_elect.png";
            break;
          case "Pago de factura ETECSA":
            image =
                "assets/images/backgrounds/enzona/factura_conf_etecsa_elect.png";
            break;
          case "Pago de servicio nauta ETECSA":
            image = "assets/images/backgrounds/enzona/ic_pago_telefono.png";
            break;
          case "Pago del servicio propia ETECSA":
            image = "assets/images/backgrounds/enzona/ic_pago_telefono.png";
            break;
          case "Giros de Correos de Cuba":
            image =
                "assets/images/backgrounds/enzona/factura_conf_correo_elect.png";
            break;
          case "Pago de Factura del Gas":
            image =
                "assets/images/backgrounds/enzona/factura_conf_cupet_elect.png";
            break;
          case "Pago de Tributo a la ONAT ":
            image = "assets/images/backgrounds/enzona/factur_conf_onat.png";
            break;
          default:
            image =
                "assets/images/backgrounds/enzona/factura_mensual_elect.png";
        }
        /* amount = invoices!.invoices[v].amount!;
        month = invoices!.invoices[v].month!;
        year = invoices!.invoices[v].year!;
        // gesture = Container();*/
        listaFacturaMensual.add(InvoiceMonthWidget(
          isPayed: isPayed ?? false,
          image: image ?? "",
          month: month ?? "",
          year: year ?? "",
          amount: amount ?? "",
        ));
      }
      return Column(
        children: listaFacturaMensual,
      );
      /*return InvoiceMonthWidget(
          isPayed: isPayed,
           image: image,
            month: month ??"",
             year: year??"",
              amount: amount??"");*/
    } else if (invoices!.getTotal == 0) {
      gesture = Container(
        height: 0,
      );
    }

    return gesture;
  }
}

class UserWidget extends StatelessWidget {
  final String name;
  final String clientId;

  UserWidget({required this.name, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200], // Fondo gris claro
      padding: EdgeInsets.all(16), // Espacio interno
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold), // Tamaño de letra más grande
          ),
          Text(
            'ID de cliente: $clientId',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
