// ignore_for_file: must_be_immutable

//import '/app/modules/operation/widgets/layout_user_general_info.dart';
import 'package:flutter/material.dart';

class CustomInfo extends StatelessWidget {
  Text? textoinfo;
  //IncidentsModel? incident;

  CustomInfo({
    Key? key,
    this.textoinfo,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Container(
          width: 125,
          height: 40,
          child:
              Container() /* WidgetInfo(
              texto: "Fecha de Apertura:", fontWeight: FontWeight.bold)*/
          ,
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          width: 80,
          height: 40,
          child:
              Container() /*WidgetInfo(
            texto: "dfsdfs",
          )*/
          ,
        ),
        SizedBox(width: 20),
        Container(
            width: 120,
            height: 40,
            child:
                Container() /*WidgetInfo(
              texto: "Fecha de Cierre:",
              fontWeight: FontWeight.bold,
            )*/
            ),
        SizedBox(
          width: 10,
        ),
        Container(
            width: 80,
            height: 40,
            child:
                Container() /*WidgetInfo(
              texto: "01-03-2021",
            )*/
            ),
      ]),
      Row(children: [
        Container(
            width: 80,
            height: 40,
            child:
                Container() /*WidgetInfo(
              texto: "Problema:",
              fontWeight: FontWeight.bold,
            )*/
            ),
        SizedBox(
          width: 5,
        ),
        Container(
            width: 100,
            height: 40,
            child:
                Container() /*WidgetInfo(
              texto: "Autenticacion",
            )*/
            ),
      ]),
      Row(children: [
        Container(
            width: 80,
            height: 40,
            child:
                Container() /*WidgetInfo(
              texto: "Solucion:",
              fontWeight: FontWeight.bold,
            )*/
            ),
        Container(
            width: 80,
            height: 40,
            child:
                Container() /*WidgetInfo(
              texto: "$textoinfo",
            )*/
            ),
      ]),
    ]);
  }
}
