import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final _UsNumberTextInputFormatter _birthDate = _UsNumberTextInputFormatter();

class EditarGiroFormWidget extends StatefulWidget {
  const EditarGiroFormWidget({Key? key});

  @override
  State<EditarGiroFormWidget> createState() => _EditarGiroFormWidgetState();
}

class _EditarGiroFormWidgetState extends State<EditarGiroFormWidget> {
  TextEditingController controllerImport = TextEditingController();
  TextEditingController controllerCarne = TextEditingController();
  TextEditingController controllerMovil = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 10, 15),
      child: Column(
        children: [
          TextFormField(
              keyboardType: TextInputType.number,
              controller: controllerImport,
              onChanged: (value) {
                value = "\$${controllerImport.text}";
              },
              decoration: InputDecoration(
                hintText: "Importe",
                suffixIcon: GestureDetector(
                    onTap: () {
                      controllerImport.clear();
                    },
                    child: Icon(Icons.close)),
              )),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: controllerCarne,
            onChanged: (value) {
              value = controllerCarne.text;
            },
            decoration: InputDecoration(
              hintText: "Carnet del usuario destino",
              suffixIcon: GestureDetector(
                  onTap: () {
                    controllerCarne.clear();
                  },
                  child: Icon(Icons.close)),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: controllerMovil,
            onChanged: (value) {
              value = controllerMovil.text;
            },
            decoration: InputDecoration(
              hintText: "Movil a confirmar del usuario destino",
              suffixIcon: GestureDetector(
                  onTap: () {
                    controllerMovil.clear();
                  },
                  child: Icon(Icons.close)),
            ),
          ),
          TextFormField(
            controller: controllerDescription,
            onChanged: (value) {
              value = controllerDescription.text;
            },
            decoration: InputDecoration(
              hintText: "Descripcion",
              suffixIcon: GestureDetector(
                  onTap: () {
                    controllerDescription.clear();
                  },
                  child: Icon(Icons.close)),
            ),
          ),
          /*DropdownButton(
            onChanged: (dynamic value){},
            items: [],

          ),*/
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          TextButton(
              onPressed: () {},
              child: Container(
                width: MediaQuery.of(context).size.width * 0.50,
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
        ],
      ),
    ));
  }
}

class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 3) {
      newText.write('${newValue.text.substring(0, usedSubstringIndex = 2)}/');
      if (newValue.selection.end >= 2) {
        selectionIndex++;
      }
    }
    if (newTextLength >= 5) {
      newText.write('${newValue.text.substring(2, usedSubstringIndex = 4)}/');
      if (newValue.selection.end >= 4) {
        selectionIndex++;
      }
    }
    if (newTextLength >= 9) {
      newText.write(newValue.text.substring(4, usedSubstringIndex = 8));
      if (newValue.selection.end >= 8) {
        selectionIndex++;
      }
    }
// Dump the rest.
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
