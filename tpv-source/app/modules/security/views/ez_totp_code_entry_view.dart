import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore_for_file: must_be_immutable

import '/app/modules/security/account_exporting.dart';
import '../../../core/config/errors/errors.dart';
import '../../../widgets/utils/loading.dart';
import '../domain/models/account_model.dart';

class EzToTPCodeEntryView extends GetView<AccountController> {
  TextEditingController controladorCodeEntry = TextEditingController();
  String codeEntry = "";

  /*verificarToTPCode(String txt) async {
    //  var test = {"new_password": newPassword, "old_password": oldPassword};
    Map<String, dynamic> params = {
      'verificationCode': txt,
    };

    controller.getVerifyTotpUseCase.setParamsFromMap(params);
    await controller.getFutureByUseCase(controller.getVerifyTotpUseCase);
    // String accessToken = await securityInstance.getLocalToken('access');
    // var code = await verificarToTPCodeUseCase.call(accessToken, txt);
    // log("Respuesta de VERIFICAR TOTP CODE EN PROFILE CONTROLLER >>>>>>>>>>>>> $code");
    // update();
    // return code;
  }*/

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: Container(
          child: TextField(
              autofocus: true,
              obscureText: true,
              keyboardType: TextInputType.number,
              controller: controladorCodeEntry,
              onChanged: (texto) {
                codeEntry = texto;
              },
              decoration: InputDecoration(
                  errorBorder: InputBorder.none,
                  prefixIcon: Icon(Icons.numbers),
                  label: Text("Código ToTP"),
                  border: OutlineInputBorder()))),
      actions: [
        TextButton(
            onPressed: () async {
              controladorCodeEntry.clear();
              Get.back();
              Get.back();
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return Loading(
                      text: "Añadiendo ToTP a su cuenta...",
                      backgroundColor: Colors.lightBlue.shade700,
                      animationColor: AlwaysStoppedAnimation<Color>(
                          Colors.lightBlue.withOpacity(0.8)),
                      containerColor: Colors.lightBlueAccent.withOpacity(0.2),
                    );
                  });

              await verificarToTPCode(codeEntry);
            },
            child: Text("Verificar"))
      ],
    );
  }

  verificarToTPCode(String txt) async {
    //  var test = {"new_password": newPassword, "old_password": oldPassword};
    Map<String, dynamic> params = {
      'verificationCode': txt,
    };

    controller.getVerifyTotpUseCase.setParamsFromMap(params);
    Either<Failure, AccountModel> resp =
        await controller.getFutureByUseCase(controller.getVerifyTotpUseCase);

    resp.fold((l) {
      Get.back();
      Get.snackbar("Atencion!!!", l.toString());
    }, (r) {
      Get.back();
      Get.snackbar("Atencion!!!", "ToTP verificado con exito");
      controller.update(["EzSecurityProfileView"]);
    });
    // String accessToken = await securityInstance.getLocalToken('access');
    // var code = await verificarToTPCodeUseCase.call(accessToken, txt);
    // log("Respuesta de VERIFICAR TOTP CODE EN PROFILE CONTROLLER >>>>>>>>>>>>> $code");
    // update();
    // return code;
  }
}
