// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/app/modules/transaction/domain/entities/invoice.dart';
import '/app/modules/transaction/widgets/payments_widgets/invoice_detail_widget.dart';
//import 'package:intl/intl.dart';

class ListTileinvoice extends StatelessWidget {
  Invoice invoice;
  BuildContext context;
  ListTileinvoice({Key? key, required this.invoice, required this.context});

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat().add_jm();
    Widget colorByStatus = getColorByinvoiceStatus(invoice);
    //DateTime invoiceDate = invoice.transactionCreatedAt!;
    DateTime invoiceDate = DateTime.parse(
        invoice.transactionCreatedAt.toString().substring(0, 19));
    return Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height / 30,
          top: MediaQuery.of(context).size.height / 200),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.12,
        child: ListTile(
          dense: false,
          visualDensity: VisualDensity(vertical: 4),
          onTap: () {
            Get.to(() => InvoiceDetailWidget(
                  invoice: invoice,
                ));
          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${invoice.clientId!}',
                style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
                overflow: TextOverflow.clip,
              ),
              //SizedBox(width: MediaQuery.of(context).size.height/1.7,),
              Row(
                children: [
                  Text(
                    "-${invoice.totalAmount}",
                    style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 50,
                  ),
                  Text(
                    invoice.currency!.toUpperCase(),
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        overflow: TextOverflow.clip),
                  )
                ],
              )
            ],
          ),
          leading: Container(
              width: MediaQuery.of(context).size.width / 7,
              height: MediaQuery.of(context).size.height / 5,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CircleAvatar(
                    radius: 35,
                    child: Image.asset(
                      'assets/images/backgrounds/enzona/ic_pago_electricidad.png',
                      scale: 0.1,
                    ),
                  ),
                )
              ])),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                    //padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width / 2.7,
                    child: Text(
                      invoice.owner!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontFamily: 'Roboto'),
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                      "${invoice.transactionCreatedAt!.day}/${invoice.transactionCreatedAt!.month}/${invoice.transactionCreatedAt!.year}",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  colorByStatus,
                  Expanded(child: Container()),
                  Text(formatter.format(invoice.transactionCreatedAt!),
                      style: TextStyle(
                        fontFamily: 'Roboto',
                      ))
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Divider(
                height: 2,
                thickness: 1,
                indent: 0,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getColorByinvoiceStatus(Invoice invoice) {
    String? status = invoice.transactionStatus!;
    Color color;
    switch (invoice.transactionStatus) {
      case "Aceptada":
        color = Colors.green;
        break;
      case "Fallida":
        color = Colors.red;
        break;
      case "Pendiente":
        color = Colors.orange;
        break;
      default:
        color = Colors.transparent;
    }
    return Container(
      //height: MediaQuery.of(context).size.height/20,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
      child: Text(
        status,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto'),
      ),
    );
  }

  /*Widget showPicture( invoice invoice, BuildContext context){
   if(getPicture(invoice)==null) {
     return Container(
      decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
       clipBehavior: Clip.antiAlias,
       child: CircleAvatar(
             radius: 35,
             child: Image.asset(
             "assets/images/backgrounds/enzona/im_foto_usuario.png",
             scale: 0.1,
             
           ),
         ),
     );
   }else if(invoice.invoiceDenom != "Transferencia" &&
    invoice.invoiceDenom != "Pago a Persona" 
   ){
    imagen = true;
    return Container(
      decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
       clipBehavior: Clip.antiAlias,
       child: CircleAvatar(
             radius: 35,
             child: Image.asset(
             getPicureService(context,invoice),
             scale: 0.1,
             
           ),
         ),
     ); 
   }
   else{
    return CircleAvatar(
      radius: 35,
      backgroundImage: getPicture(invoice)
      );
   }
  }*/

  String getPicureService(BuildContext context, Invoice invoice) {
    String picture;
    switch (invoice.transactionDenom) {
      case "Activación de tarjetas":
        picture = "assets/images/backgrounds/enzona/im_foto_tarjeta.png";
        break;
      case "Pagos a Comercios":
        picture = "assets/images/backgrounds/enzona/ic_pago_comercio.png";
        break;
      case "Donaciones":
        picture = "assets/images/backgrounds/enzona/ic_tranferencia.png";
        break;
      case "Electricidad":
        picture = "assets/images/backgrounds/enzona/electricidad.png";
        break;
      case "Pago de factura ETECSA":
        picture = "assets/images/backgrounds/enzona/ic_pago_telefono.png";
        break;
      case "Pago de servicio nauta ETECSA":
        picture = "assets/images/backgrounds/enzona/ic_pago_telefono.png";
        break;
      case "Pago del servicio propia ETECSA":
        picture = "assets/images/backgrounds/enzona/ic_pago_telefono.png";
        break;
      case "Giros de Correos de Cuba":
        picture = "assets/images/backgrounds/enzona/correos.png";
        break;
      case "Pago de Factura del Gas":
        picture = "assets/images/backgrounds/enzona/ic_pago_gas.png";
        break;
      case "Pago de Tributo a la ONAT ":
        picture = "assets/images/backgrounds/enzona/ic_onat.png";
        break;
      case "Regalo":
        picture = "assets/images/backgrounds/enzona/im_foto_tarjeta.png";
        break;
      default:
        return "";
    }

    return picture;
  }
}
