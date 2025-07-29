// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/modules/tpv/controllers/tpv_controller.dart';

class SalesHistoryView extends GetResponsiveView<TpvController> {
  DateTime selectedDate = DateTime.now();
  String formattedDate = '';

  @override
  Widget build(
    BuildContext context,
  ) {
    String formattedDate =
        "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
    return Scaffold(
        drawer: const Drawer(
          backgroundColor: Color(0xFFDCE4E7),
        ),
        backgroundColor: const Color(0xFFDCE4E7),
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: const Color(0xFFDCE4E7),
            actions: [
              Row(
                children: const [
                  Text(
                    'XETID',
                    style: TextStyle(color: Colors.black),
                  ),
                  Icon(
                    Icons.store,
                    color: Colors.black,
                  )
                ],
              )
            ]),
        body: OrientationBuilder(builder: (((context, orientation) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => selectDate(context),
                        child: const Icon(
                          Icons.date_range,
                          color: Color(0xFF5091C9),
                        ),
                      ),
                      Text(formattedDate),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: const TextField(),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cerrar')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Buscar')),
                            ],
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.search,
                      color: Color(0xFF5091C9),
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 10 / 1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: 12,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.shop_two_rounded,
                          color: Color(0xFF024869),
                        ),
                        Text(
                          '52165464651846481651',
                          style: TextStyle(
                            color: Color(0xFF024869),
                          ),
                        ),
                        Text(
                          'POS #1',
                          style: TextStyle(
                            color: Color(0xFF024869),
                          ),
                        ),
                        Text(
                          '19.75 MLC',
                          style: TextStyle(
                            color: Color(0xFF024869),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ))
            ],
          );
        }))));
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2024)); // set lastDate to a date after initialDate
    if (picked != null) {
      selectedDate = picked;
      TpvController().update();
    }
  }
}
