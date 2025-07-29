// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/widgets/utils/loading.dart';
import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/services/logger_service.dart';
import '../../../core/services/paths_service.dart';
import '../../../core/services/store_service.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../../card/controllers/card_controller.dart';
import '../../card/domain/models/card_model.dart';
import '../../qrcode/domain/models/qrcode_model.dart';
import '../../security/domain/entities/account.dart';
import '../../security/domain/models/account_model.dart';
import '../../transaction/controllers/transfer_controller.dart';
import '../widgets/drop_down_button.dart';
import 'transfer_to_account_pass_view.dart';

class EzQrScannedView extends GetView<TransferController> {
  EzQrScannedView({Key? key, required this.code}) : super(key: key);
  var sysStore = StoreService().getStore("system");
  final String code;
  TextEditingController importe = TextEditingController();
  TextEditingController description = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Account? account;
  String? mensaje = "";

  String amount = "";

  String descripText = "";
  String fundingCardUUID = "";
  String currency = "";
  List<CardModel> list = [];
  Either<Failure, AccountModel>? tmp;

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

  Future<Either<Failure, QrCodeModel>> getVendorIdCode() async {
    Map<String, dynamic> params = {"code": code};
    controller.getVendorIdCodeUseCase.setParamsFromMap(params);
    return await controller
        .getFutureByUseCase(controller.getVendorIdCodeUseCase);
  }

  Future<Either<Failure, AccountModel>> findAccountForTransfer() async {
    var aux = await getVendorIdCode();
    String tmp = "";
    aux.fold((l) {
      mensaje = l.message;
    }, (r) {
      tmp = r.userName!;
    });
    controller.getAccount.setParamsFromMap({"username": tmp});
    return await controller.getFutureByUseCase(controller.getAccount);
    // var account = await controller.findAccount();
  }

  @override
  Widget build(BuildContext context) {
    CardController cardController = Get.find<CardController>();
    SizeConstraints sizeConstraints = SizeConstraints(context: context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Transferir a una cuenta"),
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
                  if (!snapshot.hasData) {
                    return Loading(
                      text: "Buscando...",
                      backgroundColor: Colors.lightBlue.shade700,
                      animationColor: AlwaysStoppedAnimation<Color>(
                          Colors.lightBlue.withOpacity(0.8)),
                      containerColor: Colors.lightBlueAccent.withOpacity(0.2),
                    );
                  } else {
                    snapshot.data!.fold((l) {
                      // Get.back();
                      // Get.defaultDialog(middleText: l.message);
                      mensaje = l.message;
                      // showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return AlertDialog(
                      //         title: Text("Error!!!"),
                      //         content: Text(l.message),
                      //       );
                      //     });
                    }, (r) {
                      account = r;
                    });
                    return mensaje == ""
                        ? Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: size.height / 18,
                                ),
                                CircleAvatar(
                                    backgroundColor: Colors.blue[700],
                                    radius: 50,
                                    child: account!.avatar != ""
                                        ? CircleAvatar(
                                            onBackgroundImageError:
                                                (exception, stackTrace) {
                                              Icon(Icons.person_rounded);
                                            },
                                            backgroundColor: Colors.blue,
                                            radius: sizeConstraints
                                                .getHeightByPercent(200),
                                            backgroundImage: NetworkImage(
                                                "${PathsService.mediaHost}"
                                                "${account!.avatar}"),
                                          )
                                        : CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            radius: sizeConstraints
                                                .getHeightByPercent(6),
                                            child: Image.asset(
                                                "assets/images/backgrounds/enzona/im_foto_usuario.png")
                                            // Icon(
                                            //   Icons.person_rounded,
                                            //   size: 80.0,
                                            // ),
                                            )),
                                SizedBox(
                                  height: size.height / 30,
                                ),
                                Container(
                                  child: Text(
                                    "${account!.name}"
                                    " "
                                    "${account!.lastname}",
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height / 20,
                                ),
                                Container(
                                  height: size.height / 18,
                                  color: Colors.transparent,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Container(
                                                color: Colors.transparent,
                                                child: Text(
                                                  "Importe",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                )),
                                          ),
                                          Expanded(
                                            child: Container(
                                              color: Colors.transparent,
                                              child: TextFormField(
                                                onChanged: (texto) {
                                                  amount = texto;
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Campo requerido";
                                                  }
                                                  if (value.contains(" ")) {
                                                    return "El monto no puede contener espacios en blanco";
                                                  }
                                                  if (!GetUtils.isNum(value)) {
                                                    return "El monto debe contener solamente números";
                                                  }
                                                  return null;
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                // inputFormatters: [
                                                //   FilteringTextInputFormatter
                                                //       .singleLineFormatter,
                                                // ],
                                                controller: importe,
                                                decoration: InputDecoration(
                                                    hintText: "\$0.00",
                                                    border: InputBorder.none),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                                Divider(
                                  height: 15,
                                ),
                                Container(
                                  height: size.height / 18,
                                  color: Colors.transparent,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Container(
                                                color: Colors.transparent,
                                                child: Text(
                                                  "Descripción(Opcional)",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                )),
                                          ),
                                          Expanded(
                                            child: Container(
                                              color: Colors.transparent,
                                              child: TextFormField(
                                                onChanged: (texto) {
                                                  descripText = texto;
                                                },
                                                controller: description,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Breve Descripción",
                                                    border: InputBorder.none),
                                              ),
                                            ),
                                          ),
                                        ]),
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
                                            } else {
                                              if (snapshot.data!.isRight()) {
                                                return snapshot.data!.fold((l) {
                                                  l.message;
                                                  return AlertDialog();
                                                }, (r) {
                                                  list = r.getList();
                                                  return DropDownButton(
                                                    listCard: list,
                                                  );
                                                });
                                              } else {
                                                return AlertDialog();
                                              }
                                            }
                                          }),
                                    )),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                          // Get.toNamed("/home");

                                          importe.clear();
                                          description.clear();
                                        },
                                        child: Text("Cancelar")),
                                    ElevatedButton(
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            var test = numberFormat(amount);

                                            fundingCardUUID = sysStore.get(
                                                "fundingCardUuidToTransfer",
                                                null);
                                            currency = sysStore.get(
                                                "currencyToTransfer", null);
                                            log("ESTE ES FUNDING EN TRANSFER ACCOUNT VIEW DESPUES DE TOCAR ACEPTAR>>>>>>>>>$fundingCardUUID");
                                            log("ESTE ES CURRENCY EN TRANSFER ACCOUNT VIEW DESPUES DE TOCAR ACEPTAR>>>>>>>>>$currency");
                                            Map<String, dynamic> params = {
                                              "amount": test,
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
                                                  return TransferToAccountPassView(
                                                    params: params,
                                                    contexto: context,
                                                    // function: transferController
                                                    //     .transferToAccount(account),
                                                  );
                                                });
                                            // transferController.findAccountText.clear();
                                            importe.clear();
                                            description.clear();
                                          }
                                        },
                                        child: Text("Aceptar")),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : AlertDialog(
                            title: Text("Error!!!"),
                            content: Text(mensaje!),
                          );

                    // if (snapshot.data!.isRight()) {
                    //   return snapshot.data!.fold((l) {
                    //     l.message;
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

// import 'dart:convert';

// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// import '../../../core/services/logger_service.dart';

// import '../../../widgets/utils/size_constraints.dart';
// import '../../security/widgets/main_app_bar.dart';

// class EzQrScannedView extends StatefulWidget {
//   final Barcode barcode;
//   // final BarcodeFormat formatCode;
//   // final dynamic rawBytes;
//   const EzQrScannedView({
//     Key? key,
//     required this.barcode,
//     // required this.formatCode,
//     // required this.rawBytes
//   }) : super(key: key);

//   @override
//   State<EzQrScannedView> createState() => _EzQrScannedViewState();
// }

// class _EzQrScannedViewState extends State<EzQrScannedView> {
//   String code = "";
//   late Barcode? barcode;
//   dynamic rawBytes;

//   dynamic parseCoded;

//   @override
//   void initState() {
//     parseCode();
//     super.initState();
//   }

//   parseCode() {
//     barcode = widget.barcode;
//     var aux = barcode!.format;
//     var tmp = barcode!.code;
//     var aux2 = barcode!.rawBytes;
//     var aux3 = base64Encode(aux2!);
//     code = aux3;
//     var aux4 = base64Decode(code);
//     rawBytes = String.fromCharCodes(aux4);
//     // formatCode = widget.formatCode;
//     // rawBytes = widget.rawBytes;
//     log("ESTE ES BARCODE>>>>>>>>>>>>>>>>>$barcode");
//     log("ESTE ES AUX>>>>>>>>>>>>>>>>>$aux");
//     log("ESTE ES TMP>>>>>>>>>>>>>>>>>$tmp");
//     // var aux2 = base64Decode(tmp!);

//     // log("ESTE ES AUX2>>>>>>>>>>>>>>>>>$aux2");
//     // log("ESTE ES AUX CON BASE64DECODE>>>>>>>$aux");

//     // var tmp = String.fromCharCodes(aux);

//     // log("ESTE ES TMP CON STRINGFROMCHARCODES>>>>>>>$tmp");

//     // parseCoded = tmp;
//   }

//   @override
//   Widget build(BuildContext context) {
//     SizeConstraints size = SizeConstraints(context: context);
//     return Container(
//       color: Colors.white,
//       height: size.getHeight,
//       child: Column(
//         children: [
//           MainAppBar(
//             size: size,
//             widgets: [
//               LogoEZ(size: size),
//             ],
//           ),
//           Expanded(
//             flex: 5,
//             child: Container(
//               child: Center(
//                 child: Column(
//                   children: [
//                     /*0546d50280d5b14d5dabf7946d234eef3c codigo cuando es poniendo dinero */
//                     /*02ed16e39c9a1342f389d80235e2044ffb codigo cuando es sin definir monto */
//                     Text(barcode!.code.toString()),
//                     Text(code),
//                     Text(rawBytes),
//                     // Text(code),
//                     // Text(formatCode.toString()),
//                     // Text(rawBytes),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
