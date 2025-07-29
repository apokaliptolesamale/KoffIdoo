// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:encrypt/encrypt.dart' as en;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../../../widgets/botton/rounded_button.dart';
import '../../../widgets/utils/loading.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../../card/controllers/card_controller.dart';
import '../../card/domain/entities/card.dart' as lc;
import '../../card/domain/models/card_model.dart';
import '../../card/domain/models/cordenate_model.dart';
import '../../card/widgets/encrypt/encryptFromCrt.dart';
import '../controllers/account_controller.dart';
import '../domain/models/account_model.dart';

class ResetPaymentPasswordView extends GetView<AccountController> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late BuildContext? contexto;
  TextEditingController carneM = TextEditingController();
  TextEditingController coord1 = TextEditingController();
  TextEditingController coord2 = TextEditingController();
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();

  String? carnetMilitar = "";
  String cord1 = "";
  String cord2 = "";
  String posPin1 = "";
  String posPin2 = "";

  String vC1 = "";
  // String tC1;
  String vC2 = "";
  // String tC2;
  String vP1 = "";
  // String tP1;
  String vP2 = "";
  // String tP2;

  String mensaje = "";
  String mensaje2 = "";

  late lc.Card? cardF;
  late CordenateModel? cordenate;
  ResetPaymentPasswordView(
      {Key? key, this.cardF, this.cordenate, this.contexto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AccountController accountController = controller;
    // Get.lazyPut<CardController>(() => CardController());
    CardController cardController = Get.find();
    SizeConstraints size = SizeConstraints(context: context);

    // log(cardF!.bankName);

    return Scaffold(
        resizeToAvoidBottomInset: false,

        // scrollable: true,
        appBar: AppBar(
          titleSpacing: size.getHeightByPercent(-2),
          title: Text(
            "Resetear Contraseña de Pago",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: size.getWidthByPercent(5),
              color: Colors.white,
            ),
            textAlign: TextAlign.start,
          ),
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
            future: cardController.getFirstCard(),
            builder:
                ((context, AsyncSnapshot<Either<Failure, CardModel>> snapshot) {
              if (!snapshot.hasData) {
                // showDialog(
                //     barrierDismissible: false,
                //     context: context,
                //     builder: (context) {
                //       return Loading(
                //         text: "Procesando...",
                //         backgroundColor: Colors.lightBlue.shade700,
                //         animationColor: AlwaysStoppedAnimation<Color>(
                //             Colors.lightBlue.withOpacity(0.8)),
                //         containerColor: Colors.lightBlueAccent.withOpacity(0.2),
                //       );
                //     });
                return Loading(
                  text: "Procesando...",
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
                  //         content: Text(mensaje),
                  //       );
                  //     });
                }, (r) {
                  cardF = r;
                });
                return mensaje == ""
                    ? SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(children: [
                            // Image.asset("$image"),
                            // BankCard(card: card),
                            Stack(
                              children: <Widget>[
                                Image.asset(loadImage(cardF!.bankName)),
                                Positioned(
                                  left: size.getWidthByPercent(12.5),
                                  top: size.getHeightByPercent(7),
                                  child: Text(
                                    "**** **** **** ${cardF!.last4}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                ),
                                Positioned(
                                  bottom: size.getHeightByPercent(2),
                                  left: size.getWidthByPercent(85),
                                  child: Text(
                                    cardF!.currency.toUpperCase(),
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ),
                                Positioned(
                                  bottom: size.getHeightByPercent(2),
                                  left: size.getWidthByPercent(4.5),
                                  child: Text(
                                    cardF!.cardholder,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(11),
                              ],
                              controller: carneM,
                              decoration: InputDecoration(
                                  hintText:
                                      "Carnet Militar o Pasaporte(Opcional)",
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Icon(Icons.badge),
                                  )),
                              onChanged: (texto) {
                                carnetMilitar = texto;
                              },
                            ),
                            Divider(
                              height: 12,
                            ),

                            // telebancaAsociada(),
                            FutureBuilder(
                                // initialData: null,
                                future: cardController.getCordenate(),
                                builder: ((context,
                                    AsyncSnapshot<
                                            Either<Failure, CordenateModel>>
                                        snapshot) {
                                  if (!snapshot.hasData) {
                                    return LinearProgressIndicator();
                                    // return Loading(
                                    //   text: "Cargando",
                                    // );
                                  } else {
                                    snapshot.data!.fold((l) {
                                      mensaje2 = l.toString();
                                    }, (r) {
                                      cordenate = r;
                                    });
                                    // cordenate = snapshot.data as Cordenate;
                                    return mensaje2 == ""
                                        ? telebancaAsociada(context)
                                        : AlertDialog(
                                            title: Text("Error!!!"),
                                            content: Text(mensaje2),
                                          );
                                  }
                                })),
                            Container(
                              // color: Colors.red,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  RoundedButton(
                                    text: "Cancelar",
                                    press: () {
                                      Get.back();
                                      carneM.clear();
                                      coord1.clear();
                                      coord2.clear();
                                      pin1.clear();
                                      pin2.clear();
                                    },
                                  ),
                                  RoundedButton(
                                    text: "Aceptar",
                                    press: () async {
                                      // await controller.resetPayPass();
                                      // Navigator.pop(context);
                                      showDialog(
                                          barrierDismissible: true,
                                          context: context,
                                          builder: (context) {
                                            return Loading(
                                              text:
                                                  "Reseteando contraseña de pago...",
                                              backgroundColor:
                                                  Colors.lightBlue.shade700,
                                              animationColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.lightBlue
                                                          .withOpacity(0.8)),
                                              containerColor: Colors
                                                  .lightBlueAccent
                                                  .withOpacity(0.2),
                                            );
                                          });
                                      await prepareResetPaymentPassword(
                                          cordenate!, contexto!);
                                      carneM.clear();
                                      coord1.clear();
                                      coord2.clear();
                                      pin1.clear();
                                      pin2.clear();
                                    },
                                  ),
                                ],
                              ),
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

  loadImage(String bankName) {
    String image = "";
    switch (bankName) {
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
    // switch (bankName) {
    //   case "Banco Popular de Ahorro (BPA)":
    //     image = "assets/cards/bpa.png";
    //     break;
    //   case "Banco Metropolitano S.A":
    //     image = "assets/cards/banmet.png";
    //     break;
    //   case "Banco Internacional de Comercio S.A.(BICSA)":
    //     image = "assets/cards/bicsa.png";
    //     break;
    //   case "Banco de Crédito y Comercio (BANDEC)":
    //     image = "assets/cards/bandec.png";
    //     break;
    //   default:
    // }

    return image;
  }

  prepareResetPaymentPassword(
      CordenateModel cordenate, BuildContext? context) async {
    AccountController accountController = controller;
    //CardController cardController = Get.find<CardController>();

    var vC1 = cordenate.c1;
    var tC1 = coord1.text;
    var vC2 = cordenate.c2;
    var tC2 = coord2.text;
    var vP1 = cordenate.p1;
    var tP1 = pin1.text;
    var vP2 = cordenate.p2;
    var tP2 = pin2.text;
    var cadenaEncript = vC1 + tC1 + vC2 + tC2 + vP1 + tP1 + vP2 + tP2;

    log("ESTE ES CADENAENCRIPT ANTES DE SER CIFRADA>>>>>>>>>>>>$cadenaEncript");
    var fSUuid = cardF!.fundingSourceUuid;
    // await getFundingSourceUuidFirstCard();
    var cadena = await RSAEncrypt().getEncryptCertBank(
        en.RSAEncoding.OAEP, cardF!.bankCertificate, cadenaEncript);

    var cm = carnetMilitar;
    log("FUNDINGGGGGGGGGGGGGGGGGGGGGGGGG>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$fSUuid");
    log("CADENA ENCRIPTADA>>>>>>>>>>>>>>>>$cadena");
    log("CM>>>>>>>>>>>>>>>>>$cm");

    Map<String, dynamic> params = {
      "funding_source_uuid": fSUuid,
      "cadenaEncript": cadena,
      "CM": cm
    };

    accountController.resetPaymentPasswordPasswordUseCase
        .setParamsFromMap(params);
    Either<Failure, AccountModel> resp =
        await accountController.resetPaymentPassword();
    resp.fold((l) {
      Get.back();
      Get.back();
      Get.snackbar("Atencion!!!", l.toString(), duration: Duration(seconds: 5));
      // final snackBar = SnackBar(content: Text(l.toString()));
      // Scaffold.of(context!);
    }, (r) {
      Get.back();
      Get.back();
      Get.snackbar("Atencion!!!", "Contraseña de pago reseteada correctamente",
          duration: Duration(seconds: 5));
    });
    accountController.update(["PaymentConfigView"]);
  }

  telebancaAsociada(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      // color: Colors.amber,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(
          "Telebanca asociada",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          textAlign: TextAlign.left,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
          controller: coord1,
          decoration: InputDecoration(
              hintText: "Coordenada ${cordenate!.c1}",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Icon(Icons.crop),
              )),
          onChanged: (texto) {
            cord1 = texto;
            vC1 = cordenate!.c1;
          },
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
          controller: coord2,
          decoration: InputDecoration(
              hintText: "Coordenada ${cordenate!.c2}",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Icon(Icons.crop),
              )),
          onChanged: (texto) {
            cord2 = texto;
            vC2 = cordenate!.c2;
          },
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          controller: pin1,
          decoration: InputDecoration(
              hintText: "Posición ${cordenate!.p1} del pin",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Icon(Icons.pin),
              )),
          onChanged: (texto) {
            posPin1 = texto;
            vP1 = cordenate!.p1;
          },
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          controller: pin2,
          decoration: InputDecoration(
              hintText: "Posición ${cordenate!.p2} del pin",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Icon(Icons.pin),
              )),
          onChanged: (texto) {
            posPin2 = texto;
            vP2 = cordenate!.p2;
          },
        )
      ]),
    );
  }
}
