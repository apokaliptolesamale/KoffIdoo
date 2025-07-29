import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/gift_controller.dart';

class UserDialog extends StatelessWidget {
  const UserDialog({key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<GiftController>(builder: (controller) {
      return AlertDialog(
        scrollable: true,
        title: Text(
          'Regalar a una cuenta',
          style: TextStyle(fontSize: size.width / 25),
        ),
        content: TextFormField(
          keyboardType: TextInputType.text,
          //controller: controller.usuarioController,
          decoration: InputDecoration(
              hintText: 'Usuario/Correo/Teléfono',
              hintStyle: TextStyle(fontSize: size.width / 25),
              label: Text('Cuenta')),
        ),
        actions: [
          Center(
            child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                onPressed: () {},
                child: Text(
                  'ACEPTAR',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
          )
        ],
      );
    });
  }
}
