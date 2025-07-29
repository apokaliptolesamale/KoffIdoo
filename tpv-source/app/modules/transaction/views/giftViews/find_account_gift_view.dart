// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/services/logger_service.dart';
import '../../controllers/gift_controller.dart';
import 'regalar_view.dart';

class FindAccountGiftView extends GetView<GiftController> {
  TextEditingController findAccountText = TextEditingController();

  String textoToFindAccount = "";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FindAccountGiftView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Buscar una cuenta",
            style: TextStyle(fontSize: size.width / 20),
          ),
          leading: IconButton(
              iconSize: size.width / 20,
              splashRadius: 5,
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
        body: Container(
            color: Colors.transparent,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    height: size.height / 8,
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width / 20,
                        ),
                        Text(
                          "Cuenta:",
                          style: TextStyle(fontSize: size.width / 20),
                        ),
                        SizedBox(
                          width: size.width / 20,
                        ),
                        Container(
                          // alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width / 1.8,
                          color: Colors.transparent,
                          child: TextFormField(
                            controller: findAccountText,
                            onChanged: (texto) {
                              textoToFindAccount = texto;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Campo requerido";
                              }
                              if (value.contains(" ")) {
                                return "No puede contener espacios en blanco";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    findAccountText.clear();
                                  },
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: Colors.black,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                    fontSize: size.width / 25,
                                    color: Colors.grey[400]),
                                hintText: "Usuario/Correo/Teléfono"),
                          ),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        log("Me voy a mover");
                        Get.to(() => RegalarView(findAccountText.text));
                      }
                    },
                    child: Text("Aceptar"),
                  )
                ],
              ),
            )));
  }
}
