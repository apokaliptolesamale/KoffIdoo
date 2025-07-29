import 'package:flutter/material.dart';

class PayGasServiceWidget extends StatelessWidget {
  const PayGasServiceWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerEdit = TextEditingController();
    return AlertDialog(
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
          EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
      title: Center(child: Text("Pagar factura")),
      contentPadding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 30,
          right: MediaQuery.of(context).size.width / 30,
          top: MediaQuery.of(context).size.height / 30),
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
