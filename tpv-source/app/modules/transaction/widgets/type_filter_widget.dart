// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';

import '/app/core/services/store_service.dart';
import '/app/modules/transaction/controllers/transaction_controller.dart';

class TypeFilterWidget extends StatefulWidget {
  BuildContext context;
  TransactionController? controller;
  TypeFilterWidget({Key? key, this.controller, required this.context});

  @override
  State<TypeFilterWidget> createState() => _TypeFilterWidgetState();
}

class _TypeFilterWidgetState extends State<TypeFilterWidget> {
  int? _selectedIndex;
  bool isSelected = false;
  List<String> options = [
    "Transferencias",
    "Regalos",
    "Activación de tarjetas",
    "Pagos a Comercios",
    "Pagos a Personas",
    "Donaciones",
    "Electricidad",
    "Devoluciones",
    "Pago de factura ETECSA",
    "Pago de servicio nauta ETECSA",
    "Giros de Correos de Cuba",
    "Pago del servicio propia ETECSA",
    "Pago de Factura del Gas",
    "Pago de Tributo a la ONAT"
  ];

  int getTypeFilterWidget(String type) {
    int? typeCode;
    switch (type) {
      case "Transferencias":
        typeCode = 1000;
        break;
      case "Regalos":
        typeCode = 11;
        break;
      case "Activación de tarjetas":
        typeCode = 13;
        break;
      case "Pagos a Comercios":
        typeCode = 15;
        break;
      case "Pagos a Personas":
        typeCode = 16;
        break;
      case "Donaciones":
        typeCode = 17;
        break;
      case "Electricidad":
        typeCode = 19;
        break;
      case "Devoluciones":
        typeCode = 20;
        break;
      case "Pago de factura ETECSA":
        typeCode = 2102;
        break;
      case "Pago de servicio nauta ETECSA":
        typeCode = 2103;
        break;
      case "Pago del servicio propia ETECSA":
        typeCode = 2101;
        break;
      case "Giros de Correos de Cuba":
        typeCode = 24;
        break;
      case "Pago de Factura del Gas":
        typeCode = 25;
        break;
      case "Pago de Tributo a la ONAT ":
        typeCode = 30;
        break;
    }
    return typeCode!;
  }

  Widget buildChips() {
    List<Widget> chips = [];
    for (int i = 0; i < options.length; i++) {
      FilterChip choiceChip = FilterChip(
        label: Text(options[i]),
        selected: _selectedIndex == i,
        backgroundColor: Color.fromARGB(255, 126, 183, 230),
        selectedColor: Color.fromARGB(255, 5, 119, 212),
        checkmarkColor: Colors.white,
        onSelected: (selected) {
          setState(() {
            if (selected) {
              _selectedIndex = i;
            }
          });
          final typeFilterFormField =
              StoreService().getStore("filterTransactions");
          typeFilterFormField.add(
              "transactionType", getTypeFilterWidget(options[i]));
          log(typeFilterFormField.getMapFields.values.toString());
        },
      );
      chips.add(
        choiceChip,
      );
    }
    return Column(
      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {
    //Size size =MediaQuery.of(context).size.;
    return Align(
      alignment: Alignment.center,
      child: ListView(
        children: [buildChips()],
      ),
    );
  }
}
