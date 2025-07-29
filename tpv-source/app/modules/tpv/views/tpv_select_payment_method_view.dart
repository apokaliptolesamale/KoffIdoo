// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/modules/tpv/controllers/tpv_controller.dart';
import '/app/modules/tpv/widgets/background_image/background_image.dart';

class TpvSelectPaymentMethodView extends GetResponsiveView<TpvController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: OrientationBuilder(builder: ((context, orientation) {
          return Stack(
            children: [
              BackgroundImage(),
              Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Seleccione el metodo de cobro:',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                Get.toNamed('/tpv-main');
                              },
                              child: const Text(
                                'Pago con tarjeta',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              )),
                          TextButton(
                              onPressed: () {
                                Get.toNamed('/tpv-opening');
                              },
                              child: const Text(
                                'Pago con efectivo',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              )),
                          TextButton(
                              onPressed: () {
                                Get.toNamed('/tpv-stcp');
                              },
                              child: const Text(
                                'Ambos',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        })));
  }
}
