// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../domain/models/client_service_model.dart';
import '/app/modules/transaction/views/config_service_detail_view.dart';

class ClientServiceWidget extends StatelessWidget {
  ClientServiceModel clientInvoice;
  BuildContext context;
  String invoiceType;
  int? index;
  ClientServiceWidget(
      {Key? key,
      required this.invoiceType,
      required this.clientInvoice,
      required this.context,
      this.index});

  @override
  Widget build(BuildContext context) {
    String? owner = clientInvoice.owner;
    String image;
    Size size = MediaQuery.of(context).size;
    Widget gesture;
    switch (invoiceType) {
      case "Electricidad":
        image = "assets/images/backgrounds/enzona/factura_conf_elect.png";
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
        image = "assets/images/backgrounds/enzona/factura_conf_cupet_elect.png";
        break;
      case "Pago de Tributo a la ONAT ":
        image = "assets/images/backgrounds/enzona/factur_conf_onat.png";
        break;
      default:
        image = "assets/images/backgrounds/enzona/factura_conf_elect.png";
    }
    gesture = GestureDetector(
      onTap: () {
        Get.to(() => ConfigServiceDetailView(
              clientService: clientInvoice,
            ));
      },
      child: Container(
        height: size.height / 7,
        width: size.width,
        decoration: BoxDecoration(
            //color: Colors.blue,
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        padding: const EdgeInsets.only(left: 30),
        child: Stack(children: [
          Positioned(
            bottom: size.height / 30,
            left: size.width / 7,
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: size.width * 0.30,
                    height: size.height / 20,
                    child: FittedBox(
                      child: Text(
                        "${clientInvoice.clientId}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: size.width * 0.04,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 150,
                  ),
                  Container(
                    width: size.width * 0.30,
                    height: size.height / 20,
                    child: FittedBox(
                      child: Text(
                        "$owner",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: size.width * 0.04,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
    return gesture;
  }
}
