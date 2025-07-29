// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '/app/modules/security/account_exporting.dart';
import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/services/logger_service.dart';
import '../../../core/services/store_service.dart';
import '../../../widgets/botton/rounded_button.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../../card/controllers/card_controller.dart';
import '../../card/domain/models/card_model.dart';
import '../controllers/transfer_controller.dart';
import '../widgets/drop_down_button.dart';

class TransferMyCardView extends GetView<TransferController> {
  var sysStore = StoreService().getStore("system");

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController noTarjeta = TextEditingController();

  TextEditingController importe = TextEditingController();
  TextEditingController confirmCel = TextEditingController();
  TextEditingController description = TextEditingController();
  String cardNumber = "";

  String amount = "";
  String phone = "";
  String descripText = "";
  // late lc.Card card;
  String fundingCardUUID = "";
  String cardDestinoUUID = "";
  String currency = "";
  List<CardModel> list = [];

  TransferMyCardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CardController cardController = Get.find<CardController>();
    AccountController accountController = Get.find<AccountController>();
    SizeConstraints sizeConstraints = SizeConstraints(context: context);
    Size size = MediaQuery.of(context).size;
    TransferController transferController = controller;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Transferir a una de mis tarjeta"),
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
            child: Form(
          key: formKey,
          child: Column(
            children: [
              Divider(
                height: 10,
                color: Colors.transparent,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.transparent,
                      height: 50,
                      width: double.infinity,
                      child: FutureBuilder(
                          future: cardController.getCards(),
                          //AsyncSnapshot<Either<Failure, EntityModelList<CardModel>>
                          builder: (context,
                              AsyncSnapshot<
                                      Either<Failure,
                                          EntityModelList<CardModel>>>
                                  snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return snapshot.data!.fold((l) {
                                l.message;
                                return AlertDialog();
                              }, (r) {
                                list = r.getList();
                                // for (var i = 0;
                                //     i < list.length;
                                //     // DropDownButton(listCard: list)
                                //     //     .listCard
                                //     //     .length;
                                //     i++) {
                                //   var auxCard = DropDownButton(
                                //     listCard: list,
                                //   ).listCard.map((e) => null);

                                //   print(auxCard);
                                // }

                                return DropDownButton(
                                  listCard: list,
                                );
                              });
                            }
                          }),
                    )),
              ),
              Divider(
                height: 10,
                color: Colors.transparent,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  // inputFormatters: [
                  //   // FilteringTextInputFormatter.digitsOnly,
                  //   // LengthLimitingTextInputFormatter(2),
                  // ],
                  controller: importe,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.attach_money_outlined),
                    label: Text("Importe"),
                    border: OutlineInputBorder(),
                    hintText: "\$0.00",
                  ),
                  onChanged: (texto) {
                    amount = texto;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
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
                ),
              ),
              Divider(
                height: 10,
                color: Colors.transparent,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    // LengthLimitingTextInputFormatter(1),
                  ],
                  controller: confirmCel,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.phone_android),
                    label: Text("Móvil a Confirmar"),
                    border: OutlineInputBorder(),
                    hintText: "+53 **** ** **",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo requerido";
                    }
                    if (!GetUtils.isNum(value)) {
                      return "El número de teléfono debe contener solamente números";
                    }
                    if (value.length != 8) {
                      return "El número de teléfono es demasiado corto";
                    }
                    if (value[0] != "5") {
                      return "Número de teléfono no válido";
                    }
                    if (value.contains(" ")) {
                      return "El número de teléfono no puede contener espacios en blanco";
                    }
                    return null;
                  },
                  onChanged: (texto) {
                    phone = texto;
                  },
                ),
              ),
              Divider(
                height: 10,
                color: Colors.transparent,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.,
                  //   // LengthLimitingTextInputFormatter(1),
                  // ],
                  controller: description,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.description),
                    label: Text("Descripción(Opcional)"),
                    border: OutlineInputBorder(),
                    hintText: "Breve Descripción",
                  ),
                  onChanged: (texto) {
                    descripText = texto;
                  },
                ),
              ),
              Divider(
                height: 10,
                color: Colors.transparent,
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.transparent,
                    height: 50,
                    width: double.infinity,
                    child: FutureBuilder(
                        future: cardController.getCards(),
                        //AsyncSnapshot<Either<Failure, EntityModelList<CardModel>>
                        builder: (context,
                            AsyncSnapshot<
                                    Either<Failure, EntityModelList<CardModel>>>
                                snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return snapshot.data!.fold((l) {
                              l.toString();
                              return AlertDialog();
                            }, (r) {
                              list = r.getList();
                              return DropDownButton(
                                listCard: list,
                              );
                            });
                          }
                        }),
                  )),
              Divider(
                height: 15,
                color: Colors.transparent,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedButton(
                    press: () {
                      Get.back();
                      noTarjeta.clear();
                      importe.clear();
                      confirmCel.clear();
                      description.clear();
                      // transferPass.clear();
                    },
                    text: "Cancelar",
                  ),
                  RoundedButton(
                    press: () async {
                      if (formKey.currentState!.validate()) {
                        var test = numberFormat(amount);
                        var pan = cardNumber.replaceAll(" ", "");

                        // cardDestinoUUID = card.last4;

                        // sysStore.get(
                        //     "fundingCardUuidDestinoToTransferMyCards", null);

                        log("ESTE ES CARD DESTINO UUDI>>>>>>>>>>>>>>>>>$cardDestinoUUID");
                        fundingCardUUID =
                            sysStore.get("fundingCardUuidToTransfer", null);
                        currency = sysStore.get("currencyToTransfer", null);
                        if (cardDestinoUUID == fundingCardUUID) {
                          Get.defaultDialog(
                              title: "Alerta!!!",
                              middleText:
                                  "La tarjeta destino y la tarjeta fuente coinciden");
                        } else {
                          Map<String, dynamic> params = {
                            "amount": test,
                            "funding_recipient_uuid": cardDestinoUUID,
                            "funding_source_uuid": fundingCardUUID,
                            "description": descripText,
                            "currency": currency,
                            // "payment_password": "$paymentPassword",
                            "fingerprint": "",
                            "phone": phone
                          };
                          log("ESTE ES PARAMS EN TRANSFER TO CARD VIEW>>>>>>>$params");
                          log("ESTE ES FUNDING EN TRANSFER ACCOUNT VIEW DESPUES DE TOCAR ACEPTAR>>>>>>>>>$fundingCardUUID");
                          log("ESTE ES CARD DESTINO UUID EN TRANSFER MY CARDS VIEW DESPUES DE TOCAR ACEPTAR>>>>>>>>>$cardDestinoUUID");
                          log("ESTE ES CURRENCY EN TRANSFER ACCOUNT VIEW DESPUES DE TOCAR ACEPTAR>>>>>>>>>$currency");
                          // showDialog(
                          //     barrierDismissible: false,
                          //     context: context,
                          //     builder: (context) {
                          //       // transferPass.clear();
                          //       return TransferToCardPassView(
                          //         contexto: context,
                          //         params: params,
                          //         movilToConfirm: phone,
                          //         pan: cardNumber,
                          //         // function: transferController.transferCard(),
                          //       );
                          //     });
                          // noTarjeta.clear();
                          // importe.clear();
                          // confirmCel.clear();
                          // description.clear();
                        }
                      }
                    },
                    text: "Aceptar",
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }

  // Either<Failure, AccountModel>? tmp;

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
}
