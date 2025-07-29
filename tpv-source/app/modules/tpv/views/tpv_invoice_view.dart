// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/app/modules/product/domain/models/product_model.dart';
import '/app/modules/tpv/controllers/tpv_controller.dart';

class TpvInvoiceView extends GetResponsiveView<TpvController> {
  DateTime selectedDate = DateTime.now();
  DateTime now = DateTime.now();
  String nowFormatted = '';
  String formattedDate = '';
  double totalToPay = 0;
  List<ProductModel> products = [];

  @override
  Widget build(
    BuildContext context,
  ) {
    totalToPay = Get.arguments['total'];
    products = Get.arguments['products'];
    /*String formattedDate =
        "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";*/
    nowFormatted = DateFormat('yyyy-MM-dd').format(now);
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
        body: OrientationBuilder(builder: ((context, orientation) {
          return Container(
            margin:
                const EdgeInsets.only(left: 26, right: 26, bottom: 12, top: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: FittedBox(
                        child: Text(
                          'Factura',
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color(0xFF5091C9),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: ListView.builder(
                          itemCount: products.length,
                          itemExtent: 38,
                          padding: const EdgeInsets.only(
                              top: 6, bottom: 2, left: 10, right: 10),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FittedBox(
                                  child: Text(
                                    truncateString(products[index].name),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Text(
                                  '${products[index].salePrice * products[index].quantity} USD',
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            );
                          })),
                    ),
                    const Divider(
                      color: Color(0xFF5091C9),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '${totalToPay.toStringAsFixed(2)} USD',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 80,
                              child: Text(
                                'Fecha',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                            Container(
                              width: 80,
                            ),
                            Text(
                              nowFormatted,
                              style: TextStyle(color: Colors.grey[700]),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 80,
                              child: Text(
                                'Hora',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                            Container(
                              width: 80,
                            ),
                            Text(
                              now.hour.toString(),
                              style: TextStyle(color: Colors.grey[700]),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 80,
                              child: Text(
                                'Transaccion',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                            Container(
                              width: 80,
                            ),
                            Text(
                              '519497',
                              style: TextStyle(color: Colors.grey[700]),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Column(
                                children: [
                                  TextButton(
                                      onPressed: () {}, child: Text('Enzona')),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text('Transfermovil')),
                                  TextButton(
                                      onPressed: () {}, child: Text('POS')),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text('Efectivo')),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cerrar'))
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Seleccionar metodo de pago')),
              ],
            ),
          );
        })));
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

  String truncateString(String str) {
    List<String> words = str.split(' ');
    if (words.length > 5) {
      words = words.sublist(1, 5);
      return '${words.join(' ')}...';
    } else {
      return str;
    }
  }
}
