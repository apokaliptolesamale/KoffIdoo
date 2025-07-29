// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/utils/loading.dart';
import '../controllers/account_controller.dart';

class EzAccountChangePasswordView extends GetView<AccountController> {
  EzAccountChangePasswordView({Key? key}) : super(key: key);
  GlobalKey<FormState> passKey = GlobalKey<FormState>();
  String confirmPass = "";
  String passActual = "";
  String newPass = "";
  TextEditingController controladorPassActual = TextEditingController();
  TextEditingController controladorConfirmPass = TextEditingController();
  TextEditingController controladorNewPass = TextEditingController();

  updateAccountPassword(String passActual, String confirmPass) async {
    var newPassword = await controller.cifrar(confirmPass);
    var oldPassword = await controller.cifrar(passActual);
    // await controller.editAccountPassword(new_password, old_password);
    Map<String, dynamic> test = {
      "new_password": newPassword,
      "old_password": oldPassword
    };

    controller.changeAccountPassword.setParamsFromMap(test);
    await controller.getFutureByUseCase(controller.changeAccountPassword);
    // await controller.changeAccountPassword.call(null);
    // update();
  }

  // updateNewPassword() async {
  //   String confirmNewP = "";
  //   if (newPass == confirmPass) {
  //     confirmNewP = confirmPass;
  //   } else {
  //     throw Exception("Verifique que las contraseñas sean iguales.");
  //   }

  //   var passNew = await controller.cifrar(confirmNewP);

  //   return passNew;
  // }

  // updateOldPassword() async {
  //   String passAct = passActual;
  //   var oldPass = await controller.cifrar(passAct);
  //   return oldPass;
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 15,
      backgroundColor: Colors.white,
      scrollable: true,
      title: Center(
        child: Text(
          "Cambiar contraseña de la cuenta.",
          textAlign: TextAlign.center,
        ),
      ),
      content: Form(
        key: passKey,
        child: Column(
          children: [
            TextFormField(
                autofocus: true,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: controladorPassActual,
                onChanged: (texto) {
                  passActual = texto;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo requerido";
                  }
                  if (value.length < 8) {
                    return "Mínimo 8 caracteres";
                  }
                  if (value.contains(" ")) {
                    return "No puede contener espacios en blanco";
                  }
                  if (!value.contains(RegExp(r'[A-Z]'))) {
                    return "Debe añadir al menos 1 mayúscula";
                  }
                  return null;
                  // if (!value.contains(RegExp(r'[0-9]'))) {
                  //   return "La contraseña debe tener al menos 1 número";
                  // }
                },
                decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          controladorPassActual.clear();
                        },
                        child: Icon(Icons.close)),
                    prefixIcon: Icon(Icons.password),
                    label: Text("Contraseña actual"),
                    border: OutlineInputBorder())),
            Divider(
              height: 10.0,
            ),
            TextFormField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                onChanged: (texto) {
                  newPass = texto;
                },
                controller: controladorNewPass,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo requerido";
                  }
                  if (value.length < 8) {
                    return "Mínimo 8 caracteres";
                  }
                  if (value.contains(" ")) {
                    return "No puede contener espacios en blanco";
                  }
                  if (!value.contains(RegExp(r'[A-Z]'))) {
                    return "Debe añadir al menos 1 mayúscula";
                  }
                  return null;
                  // if (!value.contains(RegExp(r'[0-9]'))) {
                  //   return "La contraseña debe tener al menos 1 número";
                  // }
                },
                decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          controladorNewPass.clear();
                        },
                        child: Icon(Icons.close)),
                    prefixIcon: Icon(Icons.password),
                    label: Text("Nueva contraseña"),
                    border: OutlineInputBorder())),
            Divider(
              height: 10.0,
            ),
            TextFormField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                onChanged: (texto) {
                  confirmPass = texto;
                },
                controller: controladorConfirmPass,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo requerido";
                  }
                  if (value.length < 8) {
                    return "Mínimo 8 caracteres";
                  }
                  if (value.contains(" ")) {
                    return "No puede contener espacios en blanco";
                  }
                  if (!value.contains(RegExp(r'[A-Z]'))) {
                    return "Al menos 1 mayúscula";
                  }
                  if (newPass != value) {
                    return "No coincide con la anterior";
                  }
                  return null;
                  // if (!value.contains(RegExp(r'[0-9]'))) {
                  //   return "La contraseña debe tener al menos 1 número";
                  // }
                },
                decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          controladorConfirmPass.clear();
                        },
                        child: Icon(Icons.close)),
                    prefixIcon: Icon(Icons.password),
                    label: Text("Confirmar nueva contraseña"),
                    border: OutlineInputBorder())),
            Divider(
              height: 10.0,
              color: Colors.transparent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                      FocusScope.of(context).unfocus();
                    },
                    child: Text("Cancelar")),
                ElevatedButton(
                    child: Text("Aceptar", style: TextStyle(fontSize: 18)),
                    // splashColor: Colors.indigo,
                    // color: Colors.blueAccent,
                    onPressed: (() async {
                      FocusScope.of(context).unfocus();
                      if (passKey.currentState!.validate()) {
                        Navigator.pop(context);
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return Loading(
                                text: "Actualizando...",
                                backgroundColor: Colors.lightBlue.shade700,
                                animationColor: AlwaysStoppedAnimation<Color>(
                                    Colors.lightBlue.withOpacity(0.8)),
                                containerColor:
                                    Colors.lightBlueAccent.withOpacity(0.2),
                              );
                            });

                        await updateAccountPassword(passActual, confirmPass);
                        controladorNewPass.clear();
                        controladorConfirmPass.clear();
                        controladorPassActual.clear();
                        Get.back();
                        controller.update(["EzSecurityProfileView"]);
                      }
                    })),
              ],
            )
          ],
        ),
      ),
    );
  }

  /*Scaffold(
      appBar: AppBar(
         title: const Text("Configuración"),
        leading: IconButton(
          iconSize: 25,
          splashRadius: 25,
          onPressed: (() => Get.back()),
          icon: const Icon(Icons.arrow_back_ios)),
          flexibleSpace: Container(
                decoration: const BoxDecoration(
                image: DecorationImage(
                image: AssetImage(
                  "assets/images/fondo_inicio_2.png"),
                  fit: BoxFit.fill)),
              ),
      ),
     //backgroundColor: const Color.fromARGB(255, 236, 230, 230),
     backgroundColor:  Colors.white,
      // body : Padding( padding: const EdgeInsets.all(10), child: UpdatePasswordW(controller: controller,), )
    );*/
}


// import '/app/modules/profile/controllers/profile_controller.dart';
// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// class PasswordView extends GetView<ProfileController> {
//   const PasswordView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('HomeView'),
//           centerTitle: true,
//         ),
//         body: GetBuilder<ProfileController>(builder: (controller) {
//           return Padding(
//             padding: const EdgeInsets.all(28.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 10),
//                 Text("Texto plano: ${controller.texto}"),
//                 const SizedBox(height: 10),
//                 Text("Texto cifrado: ${controller.textoCifrado}"),
//                 const SizedBox(height: 30),
//                 ElevatedButton(
//                     onPressed: () {
//                       controller.cifrar(controller.texto);
//                     },
//                     child: Text('cifrar'))
//               ],
//             ),
//           );
//         }));
//   }
// }
