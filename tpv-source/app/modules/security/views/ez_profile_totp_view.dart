// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '/app/modules/security/domain/models/account_model.dart';
import '../../../core/config/errors/errors.dart';
import '../../../widgets/qrflutter/src/qr_image.dart';
import '../../../widgets/qrflutter/src/qr_versions.dart';
import '../../../widgets/qrflutter/src/types.dart';
import '../../../widgets/utils/loading.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../controllers/account_controller.dart';
import 'ez_totp_code_entry_view.dart';

// class ToTPCodeView extends StatefulWidget {
//   final String code;
//   const ToTPCodeView({Key? key ,required this.code}) : super(key: key);

//   @override
//   _ToTPCodeViewState createState() => _ToTPCodeViewState();
// }

class EzProfileToTPCodeView extends GetView<AccountController> {
  bool swch = false;
  AccountModel? accountModel;
  String mensaje = "";

  EzProfileToTPCodeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConstraints size = SizeConstraints(context: context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Código ToTP"),
          leading: IconButton(
              iconSize: 25,
              splashRadius: 25,
              onPressed: (() => Get.back()),
              icon: const Icon(Icons.arrow_back_ios)),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/backgrounds/enzona/fondo_inicio_2.png"),
                    fit: BoxFit.fill)),
          ),
        ),
        body: FutureBuilder(
            future: controller.getToTPCode(),
            builder: ((context,
                AsyncSnapshot<dartz.Either<Failure, AccountModel>> snapshot) {
              if (!snapshot.hasData) {
                return Loading(
                  text: "Cargando ToTP...",
                  backgroundColor: Colors.lightBlue.shade700,
                  animationColor: AlwaysStoppedAnimation<Color>(
                      Colors.lightBlue.withOpacity(0.8)),
                  containerColor: Colors.lightBlueAccent.withOpacity(0.2),
                );
              } else {
                snapshot.data!.fold((l) {
                  // Get.back();
                  // Get.defaultDialog(middleText: l.toString());
                  mensaje = l.toString();
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return AlertDialog(
                  //         title: Text("Error!!!"),
                  //         content: Text(l.toString()),
                  //       );
                  //     });
                }, (r) {
                  accountModel = r;
                });

                // final aux = resultData.value as AccountModel;
                var code = accountModel!.totpCode as String;
                log("ESTE ES EL CODE >>>>>>>>>>>>>>>>>>>>>>>>>>>>$code");
                return mensaje == ""
                    ? Container(
                        height: size.getHeightByPercent(100),
                        width: size.getWidthByPercent(100),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    "assets/images/backgrounds/enzona/fondo_pagar.png"))),
                        child: Center(
                          child: Stack(children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  height: 350,
                                  width: 350,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        partirStringTOTP(code),
                                        style: TextStyle(fontSize: 22),
                                      ),
                                      QrImage(
                                        embeddedImageStyle:
                                            QrEmbeddedImageStyle(
                                          size: Size(40, 40),
                                        ),
                                        embeddedImage: AssetImage(
                                            'assets/images/backgrounds/enzona/ez.png'),
                                        data: code,
                                        version: QrVersions.auto,
                                        size: 250.0,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Clipboard.setData(ClipboardData(
                                                    text: partirStringTOTP(
                                                        code)));
                                              },
                                              child: Text("Copiar")),
                                          TextButton(
                                              onPressed: () {},
                                              child: Text("Renovar")),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Clipboard.setData(ClipboardData(
                                              text: partirStringTOTP(code)));
                                        },
                                        child: Text("Copiar")),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text("Renovar")),
                                  ],
                                ),
                                Container(
                                  // height: 80,
                                  width: 350,
                                  color: Colors.transparent,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          // If the button is pressed, return green, otherwise blue
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return Color.fromARGB(
                                                    255, 92, 214, 163)
                                                .withOpacity(0.7);
                                          }
                                          return Colors.blue.withOpacity(0.7);
                                        }),
                                        textStyle:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          // If the button is pressed, return size 40, otherwise 20
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return TextStyle(fontSize: 40);
                                          }
                                          return TextStyle(fontSize: 20);
                                        }),
                                      ),
                                      onPressed: () {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return EzToTPCodeEntryView();
                                            });
                                      },
                                      child: Text("Activar")),
                                )
                              ],
                            )
                          ]),
                        ),
                      )
                    : AlertDialog(
                        title: Text("Error!!!"),
                        content: Text(mensaje),
                      );
              }
            })));
  }

  String partirStringTOTP(String txt) {
    var baseDecoded = base64Decode(txt);
    var charCode = String.fromCharCodes(baseDecoded);
    var split1 = charCode.split("=");
    var split2 = split1[1].split("&");
    log("+++++++++++ESTE ES EL ToTP CODE  CON SPLITX2 +++++++++++++++++: $split2");
    log("+++++++++++ESTE ES EL ToTP CODE  CON SPLITX2 +++++++++++++++++: ${split2[0]}");
    log("+++++++++++ESTE ES EL ToTP CODE  CON SPLITX2 +++++++++++++++++: ${split2[1]}");

    return split2[0];
  }
}
