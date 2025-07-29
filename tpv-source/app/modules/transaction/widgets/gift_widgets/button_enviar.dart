import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/gift_controller.dart';

class ButtonEnviarGift extends StatelessWidget {
  const ButtonEnviarGift({key});

  @override
  Widget build(BuildContext context) {
    final paymentPassController = TextEditingController();
    return GetBuilder<GiftController>(
      builder: (_) => AlertDialog(
        title: Text('Contraseña de Pago'),
        content: TextFormField(
          obscureText: true,
          controller: paymentPassController,
          decoration: InputDecoration(),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
              onPressed: () async {
                /* Navigator.pop(context);
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return FutureBuilder(
                                            future: controller.createDonation(),
                                            builder: ((context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Loading(
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                );
                                              } else {
                                                final textDonation =
                                                    snapshot.data as String;
                                                return AlertDialog(
                                                  title: textDonation !=
                                                          'Donación realizada satisfactoriamente'
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Alerta',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Icon(
                                                                Icons
                                                                    .warning_amber_rounded,
                                                                color: Colors.red)
                                                          ],
                                                        )
                                                      : Container(),
                                                  backgroundColor: textDonation ==
                                                          'Donación realizada satisfactoriamente'
                                                      ? Colors.green
                                                      : Colors.black,
                                                  content: Text(
                                                    textDonation,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                );
                                              }
                                            }));
                                      });
                                  controller.importe.text = '';
                                  controller.paymentPassword.text =
                                      ''; /* await controller.createDonation();
                                  Navigator.pop(context); */ */
              },
              child: Text('Aceptar'))
        ],
      ),
    );
  }
}
