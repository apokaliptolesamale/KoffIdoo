// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '/app/widgets/utils/loading.dart';
import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/services/logger_service.dart';
import '../../../core/services/paths_service.dart';
import '../../../core/services/store_service.dart';
import '../../../widgets/botton/rounded_button.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../../card/controllers/card_controller.dart';
import '../../card/domain/models/card_model.dart';
import '../../security/domain/entities/account.dart';
import '../../security/domain/models/account_model.dart';
import '../controllers/transfer_controller.dart';
import '../widgets/drop_down_button.dart';
import 'transfer_alert.dart';

class TransferAccountView extends GetView<TransferController> {
  var sysStore = StoreService().getStore("system");
  BuildContext? contexto;
  String? param;
  TextEditingController importe = TextEditingController();
  TextEditingController description = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Account? account;
  String? mensaje = "";
  String? mensajeCard = "";
  String amount = "";

  String descripText = "";

  String fundingCardUUID = "";

  String currency = "";
  List<CardModel> list = [];
  Either<Failure, AccountModel>? tmp;
  TransferAccountView({Key? key, this.param, this.contexto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CardController cardController = Get.find<CardController>();
    SizeConstraints sizeConstraints = SizeConstraints(context: context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          titleSpacing: sizeConstraints.getHeightByPercent(-2),
          title: Text(
            "Transferir a una cuenta",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: sizeConstraints.getWidthByPercent(5.5),
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
        body: Container(
            color: Colors.transparent,
            width: double.infinity,
            child: FutureBuilder(
                future: findAccountForTransfer(),
                builder: (context,
                    AsyncSnapshot<Either<Failure, AccountModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Loading(
                      text: "Procesando...",
                      backgroundColor: Colors.lightBlue.shade700,
                      animationColor: AlwaysStoppedAnimation<Color>(
                          Colors.lightBlue.withOpacity(0.8)),
                      containerColor: Colors.lightBlueAccent.withOpacity(0.2),
                    );
                    // Center(child: WaitingWidget());
                    // // AlertDialog(
                    // //   contentPadding:
                    // //       EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    // //   content: WaitingWidget(),
                    // // );
                    // //WaitingWidget();
                  } else if (!snapshot.hasData) {
                    return
                        // Center(child: WaitingWidget());
                        // AlertDialog(
                        //   contentPadding:
                        //       EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        //   content: WaitingWidget(),
                        // );
                        Loading(
                      text: "Buscando...",
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
                      account = r;
                    });
                    return mensaje == ""
                        ? SingleChildScrollView(
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: size.height / 18,
                                  ),
                                  CircleAvatar(
                                    radius:
                                        sizeConstraints.getWidthByPercent(15),
                                    backgroundColor: Colors.lightBlue[300],
                                    // foregroundColor: Colors.amber,
                                    child: account!.avatar != "" ||
                                            account!.avatar != null
                                        ? CircleAvatar(
                                            radius: sizeConstraints
                                                .getWidthByPercent(14),
                                            backgroundImage: NetworkImage(
                                                "${PathsService.mediaHost}"
                                                "${account!.avatar}"),
                                            onBackgroundImageError:
                                                (exception, stackTrace) {
                                              // setState(() {
                                              //   errorOcurred = !errorOcurred;
                                              // });
                                            },
                                          )
                                        : CircleAvatar(
                                            radius: sizeConstraints
                                                .getWidthByPercent(14),
                                            backgroundColor:
                                                Colors.lightBlue[300],
                                            child: Image.asset(
                                              'assets/images/backgrounds/enzona/im_foto_usuario.png',
                                              width: sizeConstraints
                                                  .getWidthByPercent(45),
                                            ),
                                          ),
                                  ),
                                  // CircleAvatar(
                                  //     backgroundColor: Colors.blue[700],
                                  //     radius: 50,
                                  //     child: account!.avatar != ""
                                  //         ? CircleAvatar(
                                  //             onBackgroundImageError:
                                  //                 (exception, stackTrace) {
                                  //               Icon(Icons.person_rounded);
                                  //             },
                                  //             backgroundColor: Colors.blue,
                                  //             radius: sizeConstraints
                                  //                 .getHeightByPercent(200),
                                  //             backgroundImage: NetworkImage(
                                  //                 "${PathsService.mediaHost}"
                                  //                 "${account!.avatar}"),
                                  //           )
                                  //         : CircleAvatar(
                                  //             backgroundColor: Colors.blue,
                                  //             radius: sizeConstraints
                                  //                 .getHeightByPercent(6),
                                  //             child: Image.asset(
                                  //                 "assets/images/backgrounds/enzona/im_foto_usuario.png")
                                  //             // Icon(
                                  //             //   Icons.person_rounded,
                                  //             //   size: 80.0,
                                  //             // ),
                                  //             )),
                                  SizedBox(
                                    height: size.height / 30,
                                  ),
                                  Container(
                                    child: Text(
                                      "${account!.name}"
                                      " "
                                      "${account!.lastname}",
                                      style: GoogleFonts.roboto(
                                        fontSize: sizeConstraints
                                            .getWidthByPercent(5),
                                        // color: Colors.white.withOpacity(0.8),
                                      ),
                                      //  TextStyle(fontSize: size.getHeightByPercent(2.5)),
                                      textAlign: TextAlign.start,
                                      //TextStyle(fontSize: 22),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height / 20,
                                  ),
                                  Container(
                                    width:
                                        sizeConstraints.getWidthByPercent(90),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        onChanged: (texto) {
                                          amount = texto;
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Campo requerido";
                                          }
                                          if (value.trim().contains(" ")) {
                                            return "El monto no puede contener espacios en blanco";
                                          }
                                          if (!GetUtils.isNum(value)) {
                                            return "El monto debe contener solamente números";
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        // inputFormatters: [
                                        //   FilteringTextInputFormatter
                                        //       .singleLineFormatter,
                                        // ],
                                        controller: importe,
                                        decoration: InputDecoration(
                                            labelText: "Importe",
                                            labelStyle: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w400,
                                              fontSize: sizeConstraints
                                                  .getWidthByPercent(4.5),
                                              color: Colors.black,
                                            ),
                                            // isCollapsed: true,
                                            // prefix: Text(
                                            //   "Importe:",
                                            //   style: GoogleFonts.roboto(
                                            //     fontWeight: FontWeight.w400,
                                            //     fontSize: sizeConstraints
                                            //         .getWidthByPercent(4.5),
                                            //     color: Colors.amber,
                                            //   ),
                                            // ),
                                            // prefixStyle: GoogleFonts.roboto(
                                            //   fontWeight: FontWeight.w400,
                                            //   fontSize: sizeConstraints
                                            //       .getWidthByPercent(4.5),
                                            //   color: Colors.black,
                                            // ),

                                            // prefixText: "Importe:",
                                            // prefixStyle: GoogleFonts.roboto(
                                            //   fontWeight: FontWeight.w400,
                                            //   fontSize: sizeConstraints
                                            //       .getWidthByPercent(4.5),
                                            //   color: Colors.black,
                                            // ),
                                            hintText: "\$0.00",
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                  ),

                                  // Container(
                                  //   height: size.height / 18,
                                  //   color: Colors.transparent,
                                  //   width: double.infinity,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceEvenly,
                                  //         children: [
                                  //           // Expanded(
                                  //           //   child: Container(
                                  //           //       color: Colors.transparent,
                                  //           //       child: Text(
                                  //           //         "Importe",
                                  //           //         style: GoogleFonts.roboto(
                                  //           //           fontWeight:
                                  //           //               FontWeight.w400,
                                  //           //           fontSize: sizeConstraints
                                  //           //               .getWidthByPercent(
                                  //           //                   4.5),
                                  //           //           color: Colors.black,
                                  //           //         ),
                                  //           //         textAlign: TextAlign.start,
                                  //           //         // TextStyle(fontSize: 15),
                                  //           //       )),
                                  //           // ),
                                  //           Expanded(
                                  //             child: Padding(
                                  //               padding:
                                  //                   const EdgeInsets.all(8.0),
                                  //               child: Container(
                                  //                 color: Colors.transparent,
                                  //                 child: TextFormField(
                                  //                   onChanged: (texto) {
                                  //                     amount = texto;
                                  //                     print(amount);
                                  //                   },
                                  //                   validator: (value) {
                                  //                     if (value == null ||
                                  //                         value.isEmpty) {
                                  //                       return "Campo requerido";
                                  //                     }
                                  //                     if (value
                                  //                         .trim()
                                  //                         .contains(" ")) {
                                  //                       return "El monto no puede contener espacios en blanco";
                                  //                     }
                                  //                     if (!GetUtils.isNum(
                                  //                         value)) {
                                  //                       return "El monto debe contener solamente números";
                                  //                     }
                                  //                   },
                                  //                   keyboardType:
                                  //                       TextInputType.number,
                                  //                   // inputFormatters: [
                                  //                   //   FilteringTextInputFormatter
                                  //                   //       .singleLineFormatter,
                                  //                   // ],
                                  //                   controller: importe,
                                  //                   decoration: InputDecoration(
                                  //                       suffixText: "Importe",
                                  //                       hintText: "\$0.00",
                                  //                       border:
                                  //                           InputBorder.none),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ]),
                                  //   ),
                                  // ),
                                  Divider(
                                    height: 15,
                                  ),
                                  Container(
                                    width:
                                        sizeConstraints.getWidthByPercent(90),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        onChanged: (texto) {
                                          descripText = texto;
                                        },
                                        controller: description,
                                        decoration: InputDecoration(
                                            labelText: "Descripción(Opcional)",
                                            labelStyle: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w400,
                                              fontSize: sizeConstraints
                                                  .getWidthByPercent(4.5),
                                              color: Colors.black,
                                            ),
                                            // hintText: "Descripción",
                                            border: OutlineInputBorder()),
                                      ),
                                      // Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.spaceEvenly,
                                      //     children: [
                                      //       Container(
                                      //           color: Colors.amber,
                                      //           child: Text(
                                      //             "Descripción(Opcional)",
                                      //             style: GoogleFonts.roboto(
                                      //               fontWeight: FontWeight.w400,
                                      //               fontSize: sizeConstraints
                                      //                   .getWidthByPercent(4.5),
                                      //               color: Colors.black,
                                      //             ),
                                      //             textAlign: TextAlign.start,
                                      //             // TextStyle(fontSize: 15),
                                      //           )),
                                      //       Expanded(
                                      //         child: Container(
                                      //           color: Colors.transparent,
                                      //           child: TextFormField(
                                      //             onChanged: (texto) {
                                      //               descripText = texto;
                                      //               print(descripText);
                                      //             },
                                      //             controller: description,
                                      //             decoration: InputDecoration(
                                      //                 // hintText:
                                      //                 //     "Breve Descripción",
                                      //                 border: InputBorder.none),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ]),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        color: Colors.transparent,
                                        height: size.height / 15,
                                        width: double.infinity,
                                        child: FutureBuilder(
                                            future: cardController.getCards(),
                                            //AsyncSnapshot<Either<Failure, EntityModelList<CardModel>>
                                            builder: (context,
                                                AsyncSnapshot<
                                                        Either<
                                                            Failure,
                                                            EntityModelList<
                                                                CardModel>>>
                                                    snapshot) {
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else if (snapshot
                                                      .connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else {
                                                snapshot.data!.fold((l) {
                                                  mensajeCard = l.message;
                                                  // return AlertDialog();
                                                }, (r) {
                                                  list = r.getList();
                                                });
                                              }
                                              return mensajeCard == ""
                                                  ? DropDownButton(
                                                      listCard: list,
                                                    )
                                                  : Text(
                                                      mensajeCard!,
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    );
                                            }),
                                      )),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      RoundedButton(
                                          press: () {
                                            Get.back();
                                            // Get.toNamed("/home");

                                            importe.clear();
                                            description.clear();
                                          },
                                          text: "Cancelar"),
                                      RoundedButton(
                                        text: "Aceptar",
                                        press: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            // var test = numberFormat(amount);
                                            var aux2 = double.parse(amount);
                                            log("ESTE ES AUX2>>>>>>>>>>>>>$aux2");
                                            var aux =
                                                NumberFormat.simpleCurrency()
                                                    .format(aux2);

                                            fundingCardUUID = sysStore.get(
                                                "fundingCardUuidToTransfer",
                                                null);
                                            currency = sysStore.get(
                                                "currencyToTransfer", null);
                                            log("ESTE ES FUNDING EN TRANSFER ACCOUNT VIEW DESPUES DE TOCAR ACEPTAR>>>>>>>>>$fundingCardUUID");
                                            log("ESTE ES CURRENCY EN TRANSFER ACCOUNT VIEW DESPUES DE TOCAR ACEPTAR>>>>>>>>>$currency");
                                            Map<String, dynamic> params = {
                                              "amount": aux,
                                              "funding_recipient_username":
                                                  account!.username,
                                              "funding_source_uuid":
                                                  fundingCardUUID,
                                              "description": descripText,
                                              "currency": currency,
                                              // "payment_password": "$paymentPassword",
                                              "funding_recipient_uuid":
                                                  account!.uuid,
                                              "fingerprint": "",
                                              "type_transfer": ""
                                            };
                                            log("ESTE ES PARAMS DESPUES DE TOCAR BOTON ACEPTAR>>>>>>$params");
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  // controller.noTarjeta.clear();
                                                  // controller.importe.clear();
                                                  // controller.confirmCel.clear();
                                                  // controller.description.clear();
                                                  // controller.transferPass.clear();

                                                  return TransferAlertView(
                                                    contexto: contexto!,
                                                    params: params,
                                                    parsedAmount: aux,
                                                    nombre:
                                                        "${account!.name} ${account!.lastname}",
                                                  );
                                                  /*TransferToAccountPassView(
                                                      params: params,
                                                      contexto: context,
                                                      // function: transferController
                                                      //     .transferToAccount(account),
                                                    ); */
                                                });
                                            // transferController.findAccountText.clear();
                                            importe.clear();
                                            description.clear();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : AlertDialog(
                            title: Text("Error!!!"),
                            content: Text(mensaje!),
                          );

                    // if (snapshot.data!.isRight()) {
                    //   return snapshot.data!.fold((l) {
                    //     l.toString();
                    //     return AlertDialog();
                    //   }, (r) {
                    //     account = r as Account;

                    //   });
                    // } else {
                    //   return AlertDialog();
                    // }
                  }
                })));
  }

  Future<Either<Failure, AccountModel>> findAccountForTransfer() async {
    controller.getAccount.setParamsFromMap({"username": param});
    return controller.getFutureByUseCase(controller.getAccount);
    // var account = await controller.findAccount();
  }

  // _updateMyFunding(String text) {
  //   setState(() {
  //     myTitle = text;
  //   });
  // }
  String numberFormat(String x) {
    List<String> parts = x.toString().split(',');
    RegExp re = RegExp(r'\B(?=(\d{3})+(?!\d))');

    parts[0] = parts[0].replaceAll(re, ',');
    log("ESTE ES PARTS>>>$parts");
    log("ESTE ES PARTS>LENGTH>>>${parts.length}");
    log("ESTE ES PARTS[0]>>>${parts[0]}");
    log("ESTE ES PARTS[0].length>>>${parts[0].length}");

    if (parts.length == 1 && parts[0].contains(".")) {
      return parts[0];
    } else if (parts.length == 1) {
      parts.add('00');
    } else {
      parts[1] = parts[1].padRight(2, '0').substring(0, 2);
    }

    // if (parts[0].length == 1) {
    //   // parts.add('00');
    //   log("ESTE ES PARTS DESPUES DEL IF part[0].length>>>>>$parts");
    //   return parts.join('.00');
    // } else {
    //   parts[0] = parts[0].padRight(2, "0");
    //   log("ESTE ES PARTS[0] en el else part[0].length>>>>>${parts[0]}");
    //   return parts[0];
    // }

    // log("ESTE ES PARTS[0]v2>>>${parts[0]}");

    return parts.join('.');
  }

  // Future<Either<Failure, AccountModel>> findAccountForTransfer() async {
  //   controller.getAccount.setParamsFromMap({"username": param});
  //   return controller.getFutureByUseCase(controller.getAccount);
  //   // var account = await controller.findAccount();
  // }

  // _updateMyFunding(String text) {
  //   setState(() {
  //     myTitle = text;
  //   });
  // }
  // String numberFormat(String x) {
  //   List<String> parts = x.toString().split(',');
  //   RegExp re = RegExp(r'\B(?=(\d{3})+(?!\d))');

  //   parts[0] = parts[0].replaceAll(re, ',');
  //   if (parts.length == 1) {
  //     parts.add('00');
  //   } else {
  //     parts[1] = parts[1].padRight(2, '0').substring(0, 2);
  //   }
  //   return parts.join('.');
  // }
}
