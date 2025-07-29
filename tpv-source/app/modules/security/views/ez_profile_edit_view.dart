// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/services/logger_service.dart';
import '../../../widgets/utils/loading.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../bindings/account_binding.dart';
import '../controllers/account_controller.dart';
import '../domain/models/account_model.dart';

class EzProfileInfoEditView extends GetView<AccountController> {
  //EzHomeController ctl = Get.find<EzHomeController>();
  TextEditingController controladorC = TextEditingController();
  TextEditingController controladorT = TextEditingController();
  AccountBinding accountBinding = Get.put(AccountBinding());
  String valorEmail = "";
  String valorPhone = "";
  var accountModel = Get.find<AccountModel>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConstraints size = SizeConstraints(context: context);
    //EzHomeController ezHomeController = Get.find<EzHomeController>();
    //AccountController accountController = Get.find<AccountController>();

    {
      return AlertDialog(
        scrollable: true,
        title: Center(child: Text("Editar datos de perfil.")),
        elevation: 15,
        content: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(250),
                  ],
                  autofocus: true,
                  // obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  controller: controladorC,
                  onChanged: (texto) {
                    valorEmail = texto;
                  },
                  validator: (String? value) {
                    if ((value != null || value!.isNotEmpty) && value != "") {
                      if (!GetUtils.isEmail(value)) {
                        return "Introduzca un correo que sea válido";
                      }
                      if (value == accountModel.email) {
                        return "El nuevo correo no puede ser igual al actual";
                      }
                      if (value.contains(" ")) {
                        return "El nuevo correo no puede contener espacios en blancos";
                      }

                      // return validateEmail(value);
                    }
                    if ((valorPhone == "") && value == "") {
                      return "Ambos campos son vacíos, debe llenar al menos 1";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            controladorC.clear();
                          },
                          child: Icon(Icons.close)),
                      prefixIcon: Icon(Icons.email),
                      label: Text("Correo"),
                      border: OutlineInputBorder())),
              Divider(
                height: 10.0,
              ),
              TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(8),
                  ],
                  autofocus: true,
                  // obscureText: true,
                  keyboardType: TextInputType.number,
                  controller: controladorT,
                  onChanged: (texto) {
                    valorPhone = texto;
                  },
                  // validator: _validateOptional,
                  validator: (String? value) {
                    if ((value != null || value!.isNotEmpty) && value != "") {
                      if (value == accountModel.phone) {
                        return "El nuevo número de teléfono no puede ser igual al actual";
                      }

                      if (!GetUtils.isNum(value)) {
                        return "El nuevo número de teléfono debe contener solamente números";
                      }
                      if (value.length != 8) {
                        return "El nuevo número de teléfono es demasiado corto";
                      }
                      if (value[0] != 5) {
                        return "Número de teléfono no válido";
                      }
                      if (value.contains(" ")) {
                        return "El nuevo número de teléfono no puede contener espacios en blanco";
                      }
                    }
                    if ((valorEmail == "") && value == "") {
                      return "Ambos campos son vacíos, debe llenar al menos 1";
                    }
                    return null;

                    // if (value != null && value.isNotEmpty) {
                    //   return validatePhone(value);
                    // } else {
                    //   return null;
                    // }
                    // validate() {

                    // }

                    // if (value != null || value!.isNotEmpty) {
                    //   return validate();
                    // } else {
                    //   return null;
                    // }
                  },
                  decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            controladorC.clear();
                          },
                          child: Icon(Icons.close)),
                      prefixIcon: Icon(Icons.phone),
                      label: Text("Teléfono"),
                      border: OutlineInputBorder())),
              Divider(
                height: 2.0,
                color: Colors.transparent,
              ),
              Container(
                height: size.getHeightByPercent(25),
                color: Colors.grey[300],
                child: Column(
                  children: [
                    Flexible(
                      child: Center(
                        child: Container(
                            // color: Colors.black,
                            //  height: size.getHeightByPercent(14),
                            width: size.getWidthByPercent(75),
                            //margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/15),
                            child: FittedBox(
                              child: Text(
                                  "El nuevo número de teléfono será verificado por SMS.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.grey[500])),
                            )),
                      ),
                    ),
                    Divider(
                      height: 5,
                      color: Colors.transparent,
                    ),
                    Flexible(
                      child: Container(
                        // color: Colors.amber,
                        //  height: size.getHeightByPercent(5),
                        //  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/20),
                        child: ElevatedButton(
                            // padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/3 , right:  MediaQuery.of(context).size.width/3),
                            //disabledColor: Colors.grey[700],
                            child:
                                Text("Aceptar", style: TextStyle(fontSize: 18)),
                            // splashColor: Colors.indigo,
                            // color: Colors.blueAccent,
                            onPressed: (() async {
                              if (formKey.currentState!.validate()) {
                                Map<String, dynamic> params = {
                                  "email": valorEmail,
                                  "phone": valorPhone
                                };
                                Navigator.pop(context);
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return Loading(
                                        text: "Actualizando...",
                                        backgroundColor:
                                            Colors.lightBlue.shade700,
                                        animationColor: AlwaysStoppedAnimation<
                                                Color>(
                                            Colors.lightBlue.withOpacity(0.8)),
                                        containerColor: Colors.lightBlueAccent
                                            .withOpacity(0.2),
                                      );
                                    });

                                await updateDatosPerfil(params);
                                Get.back();
                                controller.update(["InfoView"]);
                              } else {
                                FocusScope.of(context).unfocus();
                                // final snackbar = SnackBar(
                                //   content: Text(
                                //       "Datos vacíos, entre al menos 1 para completar la actualización."),
                                //   action: SnackBarAction(
                                //       label: "Cerrar",
                                //       onPressed: () {
                                //         Get.back();
                                //       }),
                                // );

                                // ScaffoldMessenger.of(context)
                                //     .showSnackBar(snackbar);
                              }
                              // else {
                              //   final snackbar = SnackBar(
                              //     content:
                              //         Text("Datos introducidos incorrectos."),
                              //     action: SnackBarAction(
                              //         label: "Cerrar",
                              //         onPressed: () {
                              //           Get.back();
                              //         }),
                              //   );
                              //   FocusScope.of(context).unfocus();
                              //   ScaffoldMessenger.of(context)
                              //       .showSnackBar(snackbar);
                              // }
                              // if ((valorEmail == null || valorEmail!.isEmpty) ||
                              //     (valorPhone == null || valorPhone!.isEmpty)) {

                              // }

                              // else {
                              // Get.snackbar("Atención!!!",
                              //     "Los datos registrados no son correctos, por favor verifiquélos",
                              //     backgroundColor: Colors.red.withOpacity(0.4),
                              //     icon: Icon(Icons.warning_sharp));
                              // SnackBar(
                              //     content: Text(
                              //         "Los datos registrados no son correctos, por favor verifiquélos"));
                              // Get.back();
                              // }

                              //   }
                              // });
                              // controller.updateDatosPerfil();
                              // // controller.generarCodigoVerifPhone();
                              // controladorC.clear();
                            })),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  updateDatosPerfil(Map<String, dynamic> params) async {
    AccountController accountController = controller;

    log("ESTE ES PARAMS EN EDIT PROFILE VIEW>>>>>>>>>>>>>>>>>>>>>>>>$params");
    // log("ESTE ES ACOOUNTMODEL DE LA VISTAAAAAAAAAAAAAAA${accountModel.toJson()}");
    // accountController.updateAccount.setParamsFromMap(accountModel.toJson());
    accountController.updateAccount.setParamsFromMap(params);
    await accountController.getFutureByUseCase(accountController.updateAccount);

    // valor_c = controladorC.text;
    // accountModel.email = valor_c;
    // valor_p = controladorT.text;

    // if (valorEmail == null) {
    //   SnackBar(content: Text("El correo no puede ser vacío"));
    //   Get.back();
    //   // valorEmail = accountModel.email;
    //   // accountModel.email = valorEmail;
    // } else {
    //   var correo = accountModel.email;
    //   // accountModel.email = valorEmail;

    //   auxEmail = {"email": "$valorEmail"};
    //   log("ESTE ES CORREO DE LA VISTAAAAAAAAAA>>>>>>>>>$valorEmail");
    //   // log("ESTE ES CORREO DE LA VISTAAAAAAAAAA>>>>>>>>>${accountModel.email}");
    // }

    // if (valorPhone == null) {
    //   SnackBar(content: Text("El teléfono no puede ser vacío"));
    //   Get.back();
    //   // valorPhone = accountModel.phone;
    //   // accountModel.phone = valorPhone;
    // } else {
    //   //  valor_p = controladorT.text;
    //   var phone = accountModel.phone;
    //   // var verfPhone = accountModel.verifiedPhone;
    //   // accountModel.phone = valorPhone;
    //   auxPhone = {"phone": "$valorPhone"};

    // if (ctl.account.verifiedPhone == "0") {
    //   var cdd = await controller.enviarCodigoVerifPhone(ctl.account.phone);
    //   // cd = cdd;
    //   Get.to(VerificarPhone(account: ctl.account));
    //   // var c = Map.from(cdd);
    //   // ctl.account.code = c["code"];
    //   // ctl.account.verifiedPhone = "0";
    //   // if (ctl.account.code == "") {
    //   //   ctl.account.code = "true";
    //   // await controller.verificarCodigoVerifPhone(cdd);
    //   //   // await controller.editAccount(ctl.account);
    //   // }

    //   // var a = await controller.enviarCodigoVerifPhone(ctl.account.phone);
    //   // await controller.verificarCodigoVerifPhone(cd);
    //   // ctl.account.code = cd;
    //   // ctl.account.code = await generarCodigoVerifPhone();
    // }

    // ctl.account.code = cd;
    // ctl.account.verifiedPhone = "1";
    // log("ESTE ES PHONE DE LA VISTAAAAAAAAAA>>>>>>>>>${ctl.account.phone}");
    //  accountMo = accountModel;
    // var cd = "false";
    // ctl.account.code = cd;
    // }
    // params.addAll(auxEmail);
    // params.addAll(auxPhone);

    // Get.back();

    // Get.offNamed('/security/ezprofileview/ezprofileinfo');

    // controller.update();

    // rebuild(context);

    // await verificarCodigoVerifPhone();
    // // cd = await controller.generarCodigoVerifPhone();
    // await controller.enviarCodigoVerifPhone(ctl.account.phone);
    //  Get.to(DatosPerfilView());
  }

  // String? _validateOptional(String? value) {
  //   if ((value != null && value.isNotEmpty) && !_myValidator(value)!) {
  //     switch (value) {
  //       case  accountModel.email.toString() == value.toString():
  //         "Su nuevo correo no puede ser igual al actual";

  //         break;
  //         case GetUtils.isEmail(value!):
  //       default:
  //     }
  //     return 'Error con el número';
  //   } else {
  //     return null;
  //   }
  // }

  // bool? _myValidator(String? value) {
  //   return false;
  // }

  validatePhone(String? value) {
    if (value == accountModel.phone) {
      return "El nuevo número de teléfono no puede ser igual al actual";
    }
    if (GetUtils.isNumericOnly(value!)) {
      return "El nuevo número de teléfono debe contener solamente números";
    }
    if (value.length > 8) {
      return "Número de teléfono demasiado corto";
    }
  }
}
