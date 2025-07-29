import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/modules/tpv/controllers/tpv_controller.dart';

class TpvSettingsView extends GetResponsiveView<TpvController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Ajustes'),
        ),
        body: OrientationBuilder(builder: ((context, orientation) {
          return Padding(
            padding: const EdgeInsets.all(16),
            // Glue the SettingsController to the theme selection DropdownButton.
            //
            // When a user selects a theme from the dropdown list, the
            // SettingsController is updated, which rebuilds the MaterialApp.
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      //ir a login
                    },
                    child: const Text('Cerrar Sesion')),
              ],
            ),
          );
        })));
  }
}
