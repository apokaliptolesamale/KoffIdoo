// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '/app/core/services/logger_service.dart';
import '../../../widgets/dataview/option_widget.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../../card/bindings/card_binding.dart';
import '../controllers/account_controller.dart';
import '../domain/models/account_model.dart';
import 'ez_payment_password_view.dart';
import 'ez_profile_reset_payment_password_view.dart';

class EzProfilePaymentConfigView extends GetView<AccountController> {
  var accountModel = Get.find<AccountModel>();
  EzProfilePaymentConfigView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConstraints size = SizeConstraints(context: context);
    // var cuenta = findLocalAccount();
    log("Este es ACCOUNMODEL EN GETX CUANDO ENTRO A CONFIGURACION DE PAGO>>>>>>>>>>>>>>>>>${accountModel.paymentPassword}");
    log("Este es ACCOUNMODEL EN GETX CUANDO ENTRO A CONFIGURACION DE PAGO>>>>>>>>>>>>>>>>>${accountModelToJson(accountModel)}");
    return GetBuilder<AccountController>(
        id: "PaymentConfigView",
        builder: (controller) {
          if (accountModel.paymentPassword == "true") {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                titleSpacing: size.getHeightByPercent(-2),
                title: Text(
                  "Configuración de pago",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: size.getWidthByPercent(5.5),
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
              //backgroundColor: Color.fromARGB(255, 247, 242, 242),
              backgroundColor: Colors.white,
              body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ignore: avoid_unnecessary_containers
                    Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Contraseña de pago",
                          // textAlign: TextAlign.left,
                          // textDirection: TextDirection.ltr,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: size.getWidthByPercent(5),
                              color: Colors.grey),
                          textAlign: TextAlign.start,
                          // TextStyle(
                          //     fontSize: 19,
                          //     fontWeight: FontWeight.w500,
                          //     color: Colors.grey),
                        )),
                    // Container(height: 0.3,color: Colors.grey,),

                    OptionWidget(
                      rutaAsset:
                          "assets/images/backgrounds/enzona/contrasena_de_pago.png",
                      texto: "Cambiar contraseña de pago",
                      icono: IconButton(
                          onPressed: () {
                            Get.to(() => EzPaymentPasswordView());
                            // showDialog(
                            //     barrierDismissible: false,
                            //     // anchorPoint: Offset(double.maxFinite, 0),
                            //     context: context,
                            //     builder: (context) {
                            //       return EzPaymentPasswordView();
                            //     });
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                          )),
                      onPressed: () {
                        Get.to(() => EzPaymentPasswordView());
                        // showDialog(
                        //     barrierDismissible: false,
                        //     context: context,
                        //     builder: (context) {
                        //       return EzPaymentPasswordView();
                        //     });
                      },
                    ),

                    OptionWidget(
                      rutaAsset:
                          "assets/images/backgrounds/enzona/eliminar_contrasenna.png",
                      texto: "Resetear contraseña de pago",
                      icono: IconButton(
                          onPressed: () {
                            CardBinding().dependencies();
                            Get.to(ResetPaymentPasswordView(contexto: context));
                            // showDialog(
                            //     barrierDismissible: false,
                            //     context: context,
                            //     builder: (context) {
                            //       return Scaffold(
                            //         body: FutureBuilder(
                            //             // future: controller.getFirstCard(),
                            //             builder: ((context, snapshot) {
                            //           if (!snapshot.hasData) {
                            //             // return Loading();
                            //             return EzResetPaymentPasswordView(
                            //                 // cardF: cardFrst,
                            //                 );
                            //           } else {
                            //             var cardFrst = snapshot.data as BankCard.Card;
                            //             return EzResetPaymentPasswordView(
                            //               cardF: cardFrst,
                            //             );
                            //           }
                            //         })),
                            //       );
                            //     });
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                          )),
                      onPressed: () {
                        CardBinding().dependencies();
                        Get.to(ResetPaymentPasswordView(contexto: context),
                            binding: CardBinding());
                        // showDialog(
                        //     barrierDismissible: false,
                        //     context: context,
                        //     builder: (context) {
                        //       return Scaffold(
                        //         body: FutureBuilder(
                        //             // future: controller.getFirstCard(),
                        //             builder: ((context, snapshot) {
                        //           if (!snapshot.hasData) {
                        //             // return Loading();
                        //             return EzResetPaymentPasswordView(
                        //                 // cardF: cardFrst,
                        //                 );
                        //           } else {
                        //             var cardFrst = snapshot.data as BankCard.Card;
                        //             return EzResetPaymentPasswordView(
                        //               cardF: cardFrst,
                        //             );
                        //           }
                        //         })),
                        //       );
                        //     });
                      },
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: const Text(
                        "Huella dactilar",
                        textAlign: TextAlign.left,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                    ),

                    OptionWidget(
                        rutaAsset:
                            "assets/images/backgrounds/enzona/huella.png",
                        texto: "Pago con huella dactilar",
                        icono: Switch(
                          value: false,
                          onChanged: null,
                        ),
                        onPressed: () {})
                  ]),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Configuración de pago"),
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
              //backgroundColor: Color.fromARGB(255, 247, 242, 242),
              backgroundColor: Colors.white,
              body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ignore: avoid_unnecessary_containers
                    Container(
                        padding: EdgeInsets.all(15),
                        child: const Text(
                          "Contraseña de pago",
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        )),
                    // Container(height: 0.3,color: Colors.grey,),

                    OptionWidget(
                      rutaAsset:
                          "assets/images/backgrounds/enzona/contrasena_de_pago.png",
                      texto: "Crear Contraseña de pago",
                      icono: IconButton(
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return EzPaymentPasswordView();
                                });
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                          )),
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return EzPaymentPasswordView();
                            });
                      },
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: const Text(
                        "Huella dactilar",
                        textAlign: TextAlign.left,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                    ),

                    OptionWidget(
                        rutaAsset:
                            "assets/images/backgrounds/enzona/huella.png",
                        texto: "Pago con huella dactilar",
                        icono: Switch(
                          value: false,
                          onChanged: null,
                        ),
                        onPressed: () {})
                  ]),
            );
          }
        });
  }
}
  // Future<AccountModel> findLocalAccount() async {
  //   var readed = await LocalSecureStorage.storage.read("account");
  //   var accountModel = accountModelFromJson(readed!);
  //   return accountModel;
  // }
//}
