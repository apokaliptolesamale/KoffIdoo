// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '/app/widgets/botton/rounded_button.dart';
import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/services/logger_service.dart';
import '../controllers/account_controller.dart';
import '../domain/models/destinatario_model.dart';
import '../widgets/add_destinatarios_button.dart';

class DestinatarioCard extends StatelessWidget {
  final DestinatarioModel destinatario;

  DestinatarioCard({
    Key? key,
    required this.destinatario,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String image = "";
    log(destinatario.bankCode);
    switch (destinatario.bankCode) {
      case "Banco Popular de Ahorro (BPA)":
        image = "assets/images/backgrounds/enzona/bpa.png";
        break;
      case "Banco Metropolitano S.A":
        image = "assets/images/backgrounds/enzona/banmet.png";
        break;
      case "Banco Internacional de Comercio S.A.(BICSA)":
        image = "assets/images/backgrounds/enzona/bicsa.png";
        break;
      case "Banco de Crédito y Comercio (BANDEC)":
        image = "assets/images/backgrounds/enzona/bandec.png";
        break;
      default:
    }
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 4,
      decoration:
          BoxDecoration(image: DecorationImage(image: AssetImage(image))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: size.width / 6,
              top: size.height / 10,
              child: Text(
                "**** **** **** ${destinatario.last4}",
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
            ),
            // Positioned(
            //   bottom: size.height / 30,
            //   left: size.width / 18,
            //   child: Text(
            //     destinatario.currency.toUpperCase(),
            //     textAlign: TextAlign.start,
            //     style: TextStyle(
            //         fontSize: size.height * 0.02, fontWeight: FontWeight.bold),
            //   ),
            // ),
            Positioned(
              bottom: size.height / 30,
              left: size.width / 5.5,
              child: Text(
                destinatario.name.toUpperCase(),
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: size.height * 0.02),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EzProfileDestinatarioView extends GetView<AccountController> {
  List<DestinatarioModel> list = [];
  String? uuid;
  EzProfileDestinatarioView({Key? key, this.uuid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SizeConstraints size = SizeConstraints(context: context);
    // EzHomeController ezHomeController = Get.find<EzHomeController>();
    // AccountController accountController = controller;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Destinatarios"),
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
      body: Column(children: [
        AddDestinatarioButton(press: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return FormToAddDestinatario();
                /*  return FutureBuilder(
                    future: controller.getCordenate(),
                    builder: ((context,
                        AsyncSnapshot<Either<Failure, CordenateModel>>
                            snapshot) {
                      if (!snapshot.hasData) {
                        return Loading(
                          text: "Cargando...",
                          backgroundColor: Colors.lightBlue.shade700,
                          animationColor: AlwaysStoppedAnimation<Color>(
                              Colors.lightBlue.withOpacity(0.8)),
                          containerColor:
                              Colors.lightBlueAccent.withOpacity(0.2),
                        );
                        // Loading(
                        //   text: "Cargando...",
                        // );
                      } else {
                        if (snapshot.data!.isRight()) {
                          return snapshot.data!.fold(
                            (l) {
                              return AlertDialog(
                                content: Text(l.toString()),
                              );
                            },
                            (cordenateModel) {
                              return AddCardWindow(cordenate: cordenateModel);
                            },
                          );
                        }
                      }
                      return Container();
                    }));
              */
              });
        }),
        SizedBox(
          height: 12,
        ),
        Flexible(
            child: Container(
                child: FutureBuilder(
          future: getDestinatarios(),
          builder: (context,
              AsyncSnapshot<
                      dartz.Either<Failure, EntityModelList<DestinatarioModel>>>
                  snapshot) {
            if (!snapshot.hasData) {
              return Container();
              // return Center(
              //   child: CircularProgressIndicator(),
              // );
              // return Center(child: BouncingLoadingWidget());
            } else {
              snapshot.data!.fold((l) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Error!!!"),
                        content: Text(l.toString()),
                      );
                    });
              }, (r) {
                list = r.getList();
              });

              return ListView.builder(
                itemCount: list.length,
                padding: const EdgeInsets.all(5.0),
                itemBuilder: (context, index) {
                  return DestinatarioCard(destinatario: list[index]);
                  // return BankCard(card: list[index]);
                },
              );
            }
          },
        )))
      ]),
    );
  }

  getDestinatarios() {
    // var account = Get.find<AccountModel>();
    Map<String, dynamic> params = {
      "account_uuid": "fba8dc9897b04a269ebc8e0529ad2f5c"
    };
    controller.getDestinatariosUseCase.setParamsFromMap(params);
    controller.getDestinatariosUseCase.call(null);
  }
}

class FormToAddDestinatario extends StatelessWidget {
  TextEditingController controladorNombreDest = TextEditingController();
  TextEditingController controladorPan = TextEditingController();
  TextEditingController controladorPhone = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String nombreDest = "";
  String phone = "";
  String pan = "";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Añadir destinatario"),
      content: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(250),
                  ],
                  autofocus: true,
                  // obscureText: true,
                  keyboardType: TextInputType.text,
                  controller: controladorNombreDest,
                  onChanged: (texto) {
                    nombreDest = texto;
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Campo requerido";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            controladorNombreDest.clear();
                          },
                          child: Icon(Icons.close)),
                      prefixIcon: Icon(Icons.email),
                      label: Text("Nombre"),
                      border: OutlineInputBorder())),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(8),
                  ],
                  autofocus: true,
                  // obscureText: true,
                  keyboardType: TextInputType.number,
                  controller: controladorPhone,
                  onChanged: (texto) {
                    phone = texto;
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Campo requerido";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            controladorPhone.clear();
                          },
                          child: Icon(Icons.close)),
                      prefixIcon: Icon(Icons.email),
                      label: Text("Telefono"),
                      border: OutlineInputBorder())),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(16),
                  ],
                  autofocus: true,
                  // obscureText: true,
                  keyboardType: TextInputType.number,
                  controller: controladorPan,
                  onChanged: (texto) {
                    pan = texto;
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Campo requerido";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            controladorNombreDest.clear();
                          },
                          child: Icon(Icons.close)),
                      prefixIcon: Icon(Icons.email),
                      label: Text("Numero de la tarjeta"),
                      border: OutlineInputBorder())),
              SizedBox(
                height: 12,
              ),
            ],
          )),
      actions: [
        RoundedButton(
            text: "Aceptar",
            press: () {
              if (formKey.currentState!.validate()) {}
            })
      ],
    );
  }
}
