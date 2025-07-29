import 'package:flutter/material.dart';

class ImporteWidget extends StatelessWidget {
  final TextEditingController controllerImp;
  final GlobalKey<FormState> formKeyImporte;
  const ImporteWidget(
      {key, required this.controllerImp, required this.formKeyImporte});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: size.height / 80,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKeyImporte,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty || value == '0') {
                    return "Campo requerido";
                  }
                  return null;
                },
                cursorColor: Colors.grey,
                //textAlign: TextAlign.end,
                keyboardType: TextInputType.number,
                controller: controllerImp,
                decoration: InputDecoration(
                  label: Text('Importe'),
                  border: OutlineInputBorder(),
                  /* enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none, */
                  isDense: true,
                  prefixStyle: TextStyle(color: Colors.black),
                  /* prefixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(' Importe'),
                    ],
                  ), */
                  hintText: "\$0.00",
                ),
                /* inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ], */
              ),
            ),
          ),
          SizedBox(
            height: size.height / 80,
          ),
        ],
      ),
    );
  }
}
