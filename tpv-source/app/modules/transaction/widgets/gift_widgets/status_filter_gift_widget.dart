import 'dart:developer';
import '/app/core/services/store_service.dart';
import 'package:flutter/material.dart';

class StatusGiftFilter extends StatefulWidget {
  StatusGiftFilter({
    Key? key,
  });
  /* on("change", ChangeState, this);
     
     }*/

/*  ChangeState(Publisher<Subscriber<dynamic>> pub) {
    Map<String, dynamic> args = pub.getFiredArgs();
    if (args["selected"] == true) {

      return args["selected"];
    } else {

    }
  }*/

  @override
  State<StatusGiftFilter> createState() => _StatusGiftFilterState();
}

class _StatusGiftFilterState extends State<StatusGiftFilter> {
  bool selected = false;
  bool activeA = false;
  bool activeP = false;
  bool activeR = true;
  bool ocuped = false;
  int id = 0;
  Color acceptColor = Color.fromARGB(255, 175, 231, 163);
  Color pendingColor = Color.fromARGB(255, 248, 197, 145);
  Color rejectColor = Color.fromARGB(255, 241, 110, 106);
  int? _selectedIndex;
  List<String> options = ["Aceptada", "Pendiente", "Fallida"];

  // funcion para añadir el state al filtro
  int getStatusFilter(String status) {
    int? statuscode;
    switch (status) {
      case 'Aceptada':
        statuscode = 1111;
        break;
      case 'Pendiente':
        statuscode = 1121;
        break;
      case 'Fallida':
        statuscode = 1112;
        break;
      default:
    }
    return statuscode!;
  }

  Color getColorByStatusfilter(String status) {
    Color? color;
    switch (status) {
      case 'Aceptada':
        color = Color.fromARGB(255, 16, 207, 23);
        break;
      case 'Pendiente':
        color = Color.fromARGB(255, 192, 118, 8);
        break;
      case 'Fallida':
        color = Color.fromARGB(255, 223, 32, 18);
        break;
      default:
    }
    return color!;
  }

  Color getUnselectedColorByStatusfilter(String status) {
    Color? color;
    switch (status) {
      case 'Aceptada':
        color = Color.fromARGB(255, 156, 231, 158);
        break;
      case 'Pendiente':
        color = Color.fromARGB(255, 206, 158, 86);
        break;
      case 'Fallida':
        color = Color.fromARGB(255, 216, 95, 86);
        break;
      default:
    }
    return color!;
  }

  Widget buildChips() {
    List<Widget> chips = [];
    for (int i = 0; i < options.length; i++) {
      FilterChip choiceChip = FilterChip(
        labelPadding: EdgeInsets.all(2),
        label: Text(options[i]),
        selected: _selectedIndex == i,
        backgroundColor: getUnselectedColorByStatusfilter(options[i]),
        selectedColor: getColorByStatusfilter(options[i]),
        checkmarkColor: Colors.white,
        onSelected: (selected) {
          setState(() {
            if (selected) {
              _selectedIndex = i;
            }
          });
          int? status = getStatusFilter(options[i]);
          final typeFilterFormField = StoreService().getStore("filterGifts");
          if (typeFilterFormField.hasKey("giftStatus")) {
            typeFilterFormField.set("giftStatus", status);
          } else {
            typeFilterFormField.add("giftStatus", status);
          }
          log(typeFilterFormField.getMapFields.values.toString());
        },
      );
      chips.add(
        choiceChip,
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {
    /* FilterTransactionsParamsUseCase filtro =
        Get.put(FilterTransactionsParamsUseCase());*/
    return Padding(padding: EdgeInsets.all(5), child: buildChips());
  }
}
