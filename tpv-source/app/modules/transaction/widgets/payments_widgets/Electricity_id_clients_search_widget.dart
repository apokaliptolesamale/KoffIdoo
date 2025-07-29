import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '/app/core/services/store_service.dart';
import '/app/routes/app_pages.dart';

import '../../domain/models/payment_model.dart';

class SearchElectricityIdClientWidget extends StatelessWidget {
  BuildContext context;
  int? code;
  SearchElectricityIdClientWidget(
      {Key? key, required this.context, required this.code});

  @override
  Widget build(BuildContext context) {
    //ClientInvoiceController controller = Get.find<ClientInvoiceController>();
    final form = StoreService().getStore("IdClientsForm");
    TextEditingController controllerEdit = TextEditingController();
    ServicesPayment.byName("Electricidad");
    return AlertDialog(
      actions: [
        Align(
          alignment: Alignment.center,
          child: TextButton(
              onPressed: () async {
                String value = controllerEdit.text;
                form.add("clientId", value);
                form.add("serviceCode", code);
                if (code == 2222) {
                  Get.toNamed(
                      Routes.getInstance.getPath("ELECTRICITY_ADD_CLIENT_ID"));
                } else if (code == 1111) {
                  Get.toNamed(Routes.getInstance.getPath("GAS_CLIENT_ID_ADD"));
                }
                //Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.30,
                height: MediaQuery.of(context).size.height * 0.070,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Aceptar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Colors.white),
                  ),
                ),
              )),
        )
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      scrollable: true,
      titlePadding:
          EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
      title: Center(child: Text("Buscar Id Cliente")),
      contentPadding: EdgeInsets.only(
          left: 5, right: 5, top: MediaQuery.of(context).size.height / 30),
      elevation: 10,
      //title: Text('Material Dialog'),
      // ignore: sized_box_for_whitespace
      content: Container(
          //color: Colors.red,
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.15,
          child: Form(
            child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  value = controllerEdit.text;
                  //log(controllerEdit.text);
                },
                controller: controllerEdit,
                decoration: InputDecoration(
                    errorBorder: InputBorder.none,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          controllerEdit.clear();
                        },
                        child: Icon(Icons.close)),
                    label: Text("Id Cliente"),
                    border: OutlineInputBorder())),
          )),
    );
  }
}
