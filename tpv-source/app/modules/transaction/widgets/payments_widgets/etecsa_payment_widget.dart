import 'package:flutter/material.dart';

class EtecsaPaymentWidget extends StatelessWidget {
  const EtecsaPaymentWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerEdit = TextEditingController();
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(vertical: 100),
      actions: [
        Align(
          alignment: Alignment.center,
          child: TextButton(
              onPressed: () {},
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
          EdgeInsets.only(top: MediaQuery.of(context).size.height / 50),
      title: Center(child: Text("Pagar factura")),
      contentPadding: EdgeInsets.only(
          left: 5, right: 5, top: MediaQuery.of(context).size.height / 50),
      elevation: 10,
      content: Container(
        height: MediaQuery.of(context).size.height / 4,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              // width: 200,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              // margin: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 4)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    isExpanded: true,
                    iconSize: 30,
                    hint: Text("Seleccionar servicio"),
                    icon: Icon(Icons.arrow_drop_down),
                    items: [
                      DropdownMenuItem(
                          value: "Propia",
                          child: Container(
                            color: Colors.red,
                            // width: MediaQuery.of(context).size.width*0.50,
                            child: Text("Propia"),
                          )),
                      DropdownMenuItem(
                          value: "Nauta",
                          child: Container(
                            color: Colors.green,
                            //width: MediaQuery.of(context).size.width*0.50,
                            child: Text("Nauta"),
                          ))
                    ],
                    onChanged: (dynamic value) {}),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Form(
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
                      label: Text("Identificador de Pago"),
                      border: OutlineInputBorder())),
            ),
          ],
        ),
      ),
    );
  }
}
