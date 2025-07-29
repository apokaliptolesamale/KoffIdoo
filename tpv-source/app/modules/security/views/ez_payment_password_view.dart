// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/config/errors/errors.dart';
import '../../../widgets/botton/rounded_button.dart';
import '../../../widgets/utils/loading.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../controllers/account_controller.dart';
import '../domain/models/account_model.dart';

class EzPaymentPasswordView extends GetView<AccountController> {
  EzPaymentPasswordView({Key? key}) : super(key: key);

  GlobalKey<FormState> sinPayPass = GlobalKey<FormState>();
  GlobalKey<FormState> conPayPass = GlobalKey<FormState>();

  TextEditingController controladorPaymentPassActual = TextEditingController();
  TextEditingController controladorConfirmPaymentPass = TextEditingController();
  TextEditingController controladorNewPaymentPass = TextEditingController();
  TextEditingController controladorCrearPaymentPass = TextEditingController();
  TextEditingController controladorConfirmCrearPaymentPass =
      TextEditingController();

  String crearPayPass = "";
  String confirmCrearPayPass = "";
  String payPassActual = "";
  String newPayPass = "";
  String confirmPayPass = "";
  var accountModel = Get.find<AccountModel>();

  setPaymentPassword() async {
    String aux = "";

    if (accountModel.paymentPassword == "false" &&
        crearPayPass == confirmCrearPayPass) {
      aux = confirmCrearPayPass;
      var cifrada = await controller.cifrar(aux);
      // accountModel.paymentPassword = cifrada;
      // accountModel.oldPaymentPassword = "";
      Map<String, dynamic> params = {"payment_password": cifrada};
      controller.updateAccount.setParamsFromMap(params);
      Either<Failure, AccountModel> resp =
          await controller.getFutureByUseCase(controller.updateAccount);

      resp.fold((l) {
        Get.back();
        Get.snackbar("Atencion!!!", l.message, duration: Duration(seconds: 5));
      }, (r) {
        Get.back();
        Get.snackbar(
            "Atencion!!!", "Contraseña de pago configurada correctamente",
            duration: Duration(seconds: 5));
        controller.update(["PaymentConfigView"]);
      });
      // await controller.updatePaymentPassword(accountModel);
    }
  }

  updateNewPayPassword() async {
    String confirmNewP = "";
    if (newPayPass == confirmPayPass) {
      confirmNewP = confirmPayPass;
    } else {
      throw Exception("Verifique que las contraseñas sean iguales.");
    }

    // var paypassNew = utf8.encode(confirmNewP);
    // var diggest = sha256.convert(paypassNew);
    var last = await controller.cifrar(confirmNewP);

    return last;
  }

  updateOldPayPassword() async {
    var last = await controller.cifrar(payPassActual);
    return last;
  }

  updatePayPass() async {
    var oldPaymentPass = await updateOldPayPassword();
    var newPaymentPass = await updateNewPayPassword();
    Map<String, dynamic> oldNull = {};
    Map<String, dynamic> params = {};
    if (oldPaymentPass == null) {
      // accountModel.paymentPassword = newPaymentPass;
      oldNull = {
        "payment_password": newPaymentPass,
      };
      controller.updateAccount.setParamsFromMap(oldNull);
      await controller.getFutureByUseCase(controller.updateAccount);
      // await controller.updateAccounts(accountModel);
    } else {
      var aux = accountModel.paymentPassword;
      var auxx = accountModel.oldPaymentPassword;
      accountModel.paymentPassword = newPaymentPass;
      accountModel.oldPaymentPassword = oldPaymentPass;
      params = {
        "payment_password": newPaymentPass,
        "old_payment_password": oldPaymentPass,
      };
      controller.updateAccount.setParamsFromMap(params);
      await controller.getFutureByUseCase(controller.updateAccount);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConstraints sizeConst = SizeConstraints(context: context);
    if (accountModel.paymentPassword == "false") {
      return GetBuilder<AccountController>(builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Establecer una contraseña de pago",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: sizeConst.getWidthByPercent(5.5),
                color: Colors.white,
              ),
              textAlign: TextAlign.start,
            ),
            leading: IconButton(
                iconSize: 25,
                splashRadius: 25,
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios)),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/backgrounds/enzona/fondo_inicio_2.png"),
                      fit: BoxFit.fill)),
            ),
          ),
          // elevation: 15,
          // backgroundColor: Colors.white,
          // scrollable: true,
          // title: Center(child: Text("Establecer una contraseña de pago.")),
          body: Form(
            key: sinPayPass,
            child: Column(children: [
              TextFormField(
                  autofocus: true,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  controller: controladorCrearPaymentPass,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                  ],
                  onChanged: (texto) {
                    crearPayPass = texto;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo requerido";
                    }
                    if (value.length < 6) {
                      return "La contraseña de pago debe tener 6 dígitos";
                    }
                    if (!GetUtils.isNumericOnly(value)) {
                      return "La contraseña de pago debe contener solamente números";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            controladorCrearPaymentPass.clear();
                          },
                          child: Icon(Icons.close)),
                      prefixIcon: Icon(Icons.password),
                      label: Text(
                        "Contraseña de pago",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.normal,
                          fontSize: sizeConst.getWidthByPercent(4),
                          // color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      border: OutlineInputBorder())),
              Divider(
                height: 10,
                color: Colors.transparent,
              ),
              TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  onChanged: (texto) {
                    confirmCrearPayPass = texto;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo requerido";
                    }
                    if (value.length < 6) {
                      return "La contraseña de pago debe tener 6 dígitos";
                    }
                    if (!GetUtils.isNumericOnly(value)) {
                      return "La contraseña de pago debe contener solamente números";
                    }
                    return null;
                  },
                  controller: controladorConfirmCrearPaymentPass,
                  decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            controladorConfirmCrearPaymentPass.clear();
                          },
                          child: Icon(Icons.close)),
                      prefixIcon: Icon(Icons.password),
                      label: Text(
                        "Confirmar contraseña de pago",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.normal,
                          fontSize: sizeConst.getWidthByPercent(4),
                          // color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      border: OutlineInputBorder())),
              Divider(
                height: 10,
                color: Colors.transparent,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Get.back();
                      },
                      child: Text("Cancelar", style: TextStyle(fontSize: 18))),
                  ElevatedButton(
                      child: Text("Aceptar", style: TextStyle(fontSize: 18)),
                      // splashColor: Colors.indigo,
                      // color: Colors.blueAccent,
                      onPressed: (() async {
                        Navigator.pop(context);
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return Loading(
                                text: "Estableciendo su contraseña...",
                                backgroundColor: Colors.lightBlue.shade700,
                                animationColor: AlwaysStoppedAnimation<Color>(
                                    Colors.lightBlue.withOpacity(0.8)),
                                containerColor:
                                    Colors.lightBlueAccent.withOpacity(0.2),
                              );
                            });

                        await setPaymentPassword();
                        // Get.back();
                        // controller.update(["PaymentConfigView"]);
                        controladorCrearPaymentPass.clear();
                        controladorConfirmCrearPaymentPass.clear();

                        // FocusScope.of(context).unfocus();

                        // Get.offAndToNamed("/configView");
                        log("Pulsado setPaymentPassword");
                        // controller.updatePayPass();
                        // controladorCrearPaymentPass.clear();
                        // controladorConfirmCrearPaymentPass.clear();

                        // FocusScope.of(context).unfocus();
                      })),
                ],
              )
            ]),
          ),
        );
      });
    } else {
      return GetBuilder<AccountController>(
          // id: "ConPass",
          builder: (controller) {
        return Scaffold(
          // elevation: 15,
          // backgroundColor: Colors.white,
          // scrollable: true,
          // title: Container(
          //   child: Center(
          //     child: Text(
          //       "Cambiar contraseña de pago de la cuenta.",
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          // ),
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            titleSpacing: sizeConst.getHeightByPercent(-2),
            title: Text(
              "Cambiar contraseña de pago",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: sizeConst.getWidthByPercent(5),
                color: Colors.white,
              ),
              textAlign: TextAlign.start,
            ),
            leading: IconButton(
                iconSize: 25,
                splashRadius: 25,
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios)),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/backgrounds/enzona/fondo_inicio_2.png"),
                      fit: BoxFit.fill)),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              // color: Colors.amber,
              // height: 500,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: conPayPass,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Divider(
                        //   height: 15.0,
                        //   color: Colors.transparent,
                        // ),
                        Container(
                          // color: Colors.red,
                          height: sizeConst.getHeightByPercent(12),
                          width: sizeConst.getWidthByPercent(80),
                          child: Center(
                            child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                // autofocus: true,
                                obscureText: true,
                                keyboardType: TextInputType.number,
                                controller: controladorPaymentPassActual,
                                onChanged: (texto) {
                                  payPassActual = texto;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Campo requerido";
                                  }
                                  if (value.length < 6) {
                                    return "La contraseña de pago debe tener 6 dígitos";
                                  }
                                  if (!GetUtils.isNumericOnly(value)) {
                                    return "La contraseña de pago debe contener solamente números";
                                  }
                                  return null;
                                  // return null;
                                },
                                decoration: InputDecoration(

                                    // textAlign: TextAlign.start,

                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          controladorPaymentPassActual.clear();
                                        },
                                        child: Icon(Icons.close)),
                                    prefixIcon: Icon(Icons.password),
                                    // hintText: "******",
                                    label: Text(
                                      "Contraseña actual",
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.normal,
                                        fontSize:
                                            sizeConst.getWidthByPercent(4),
                                        // color: Colors.white,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    border: OutlineInputBorder())),
                          ),
                        ),
                        // Divider(
                        //   height: 15.0,
                        // ),
                        Container(
                          // color: Colors.amber,
                          height: sizeConst.getHeightByPercent(12),
                          width: sizeConst.getWidthByPercent(80),
                          child: Center(
                            child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                obscureText: true,
                                keyboardType: TextInputType.number,
                                onChanged: (texto) {
                                  newPayPass = texto;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Campo requerido";
                                  }
                                  if (value.length < 6) {
                                    return "La contraseña de pago debe tener 6 dígitos";
                                  }
                                  if (!GetUtils.isNumericOnly(value)) {
                                    return "La contraseña de pago debe contener solamente números";
                                  }
                                  return null;
                                },
                                controller: controladorNewPaymentPass,
                                decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          controladorNewPaymentPass.clear();
                                        },
                                        child: Icon(Icons.close)),
                                    prefixIcon: Icon(Icons.password),
                                    label: Text(
                                      "Nueva contraseña",
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.normal,
                                        fontSize:
                                            sizeConst.getWidthByPercent(4),
                                        // color: Colors.white,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    border: OutlineInputBorder())),
                          ),
                        ),
                        // Divider(
                        //   height: 15.0,
                        // ),
                        Container(
                          height: sizeConst.getHeightByPercent(12),
                          width: sizeConst.getWidthByPercent(80),
                          child: Center(
                            child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                obscureText: true,
                                keyboardType: TextInputType.number,
                                onChanged: (texto) {
                                  confirmPayPass = texto;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Campo requerido";
                                  }
                                  if (value.length < 6) {
                                    return "La contraseña de pago debe tener 6 dígitos";
                                  }
                                  if (!GetUtils.isNumericOnly(value)) {
                                    return "La contraseña de pago debe contener solamente números";
                                  }
                                  if (newPayPass != value) {
                                    return "Esta contraseña no coincide con la definida anteriormente";
                                  }
                                  return null;
                                },
                                controller: controladorConfirmPaymentPass,
                                decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          controladorConfirmPaymentPass.clear();
                                        },
                                        child: Icon(Icons.close)),
                                    prefixIcon: Icon(Icons.password),
                                    label: Text(
                                      "Confirmar nueva contraseña",
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.normal,
                                        fontSize:
                                            sizeConst.getWidthByPercent(4),
                                        // color: Colors.white,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    border: OutlineInputBorder())),
                          ),
                        ),
                        Divider(
                          height: 15.0,
                          color: Colors.transparent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundedButton(
                              text: "Cancelar",
                              press: () {
                                Get.back();
                                FocusScope.of(context).unfocus();
                              },
                            ),
                            RoundedButton(
                              text: "Aceptar",
                              press: () async {
                                // FocusScope.of(context).unfocus();
                                if (conPayPass.currentState!.validate()) {
                                  Navigator.pop(context);
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return Loading(
                                          text: "Actualizando su contraseña...",
                                          backgroundColor:
                                              Colors.lightBlue.shade700,
                                          animationColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.lightBlue
                                                      .withOpacity(0.8)),
                                          containerColor: Colors.lightBlueAccent
                                              .withOpacity(0.2),
                                        );
                                      });
                                  await updatePayPass();
                                  controladorNewPaymentPass.clear();
                                  controladorConfirmPaymentPass.clear();
                                  controladorPaymentPassActual.clear();
                                  Get.back();
                                  controller.update();
                                }
                                // else {
                                //   Get.snackbar("Atencion", "OJO");
                                //   controller.update();

                                // }
                              },
                            ),
                            // ElevatedButton(
                            //     onPressed: () {
                            //       Get.back();
                            //       FocusScope.of(context).unfocus();
                            //     },
                            //     child: Text("Cancelar",
                            //         style: TextStyle(fontSize: 18))),

                            // ElevatedButton(
                            //     child:
                            //         Text("Aceptar", style: TextStyle(fontSize: 18)),
                            //     // splashColor: Colors.indigo,
                            //     // color: Colors.blueAccent,
                            //     onPressed: (() async {
                            //       FocusScope.of(context).unfocus();
                            //       if (conPayPass.currentState!.validate()) {
                            //         Navigator.pop(context);
                            //         showDialog(
                            //             barrierDismissible: false,
                            //             context: context,
                            //             builder: (context) {
                            //               return Loading(
                            //                 text: "Actualizando su contraseña...",
                            //                 backgroundColor:
                            //                     Colors.lightBlue.shade700,
                            //                 animationColor: AlwaysStoppedAnimation<
                            //                         Color>(
                            //                     Colors.lightBlue.withOpacity(0.8)),
                            //                 containerColor: Colors.lightBlueAccent
                            //                     .withOpacity(0.2),
                            //               );
                            //             });
                            //         await updatePayPass();
                            //         controladorNewPaymentPass.clear();
                            //         controladorConfirmPaymentPass.clear();
                            //         controladorPaymentPassActual.clear();
                            //         Get.back();
                            //         controller.update();
                            //       }
                            //       // else {
                            //       //   SnackBar(
                            //       //       content: Text(
                            //       //           "Los datos registrados no son correctos, por favor verifiquélos"));
                            //       //   // Get.back();
                            //       // }
                            //     })),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      });
    }
  }
}
