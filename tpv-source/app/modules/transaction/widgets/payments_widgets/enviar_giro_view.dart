import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/modules/transaction/controllers/invoice_controller.dart';
import '/app/modules/transaction/widgets/payments_widgets/editar_giro_form_widget.dart';
import '/app/routes/app_pages.dart';

class EnviarGiroView extends GetView<InvoiceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Enviar Giro'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/fondo_inicio_2.png"),
                    fit: BoxFit.fill)),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.toNamed(Routes.getInstance.getPath("CUBAN_EMAIL"));
            },
          ),
        ),
        body: EditarGiroFormWidget());
  }
}
