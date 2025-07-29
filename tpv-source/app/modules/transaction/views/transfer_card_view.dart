// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/app/modules/security/account_exporting.dart';
import '../../../core/config/errors/errors.dart';
import '../../../core/interfaces/entity_model.dart';
import '../../../core/services/logger_service.dart';
import '../../../core/services/store_service.dart';
import '../../../widgets/botton/rounded_button.dart';
import '../../../widgets/field/input_formater.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../../card/controllers/card_controller.dart';
import '../../card/domain/models/card_model.dart';
import '../controllers/transfer_controller.dart';
import '../widgets/drop_down_button.dart';
import 'transfer_alert.dart';

class ContactsList extends StatefulWidget {
  TransferController controller;
  ContactsList({Key? key, required this.controller}) : super(key: key);
  @override
  State<ContactsList> createState() => _ContactsListState();
}

class TransferCardView extends GetView<TransferController> {
  var sysStore = StoreService().getStore("system");

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  BuildContext? contexto;
  TextEditingController noTarjeta = TextEditingController();

  TextEditingController importe = TextEditingController();
  TextEditingController confirmCel = TextEditingController();
  TextEditingController description = TextEditingController();
  String cardNumber = "";

  String amount = "";
  String phone = "";
  String descripText = "";
  String fundingCardUUID = "";

  String currency = "";
  late String? contactNumber;

  List<CardModel> list = [];

  TransferCardView({Key? key, this.contexto}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CardController cardController = Get.find<CardController>();
    AccountController accountController = Get.find<AccountController>();
    SizeConstraints sizeConstraints = SizeConstraints(context: context);
    Size size = MediaQuery.of(context).size;
    TransferController transferController = controller;
    contactNumber = sysStore.get("contactNumber", null);
    contexto = context;

    // if (contactNumber == null || contactNumber == "") {
    // } else {
    //   confirmCel.text = contactNumber!;
    // }

    return GetBuilder<TransferController>(
        id: "TransferCardView",
        builder: (builder) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text("Transferir a una tarjeta"),
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
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                          CardNumberInputFormatter(),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Campo requerido";
                          }
                          if (value.length < 16) {
                            return "Introduzca un número de tarjeta válido";
                          }
                          if (!value.trim().contains(" ") &&
                              !GetUtils.isNum(value)) {
                            return "El número de tarjeta debe contener solamente números";
                          }
                          return null;
                        },
                        controller: noTarjeta,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.numbers),
                          label: Text("No. Tarjeta"),
                          border: OutlineInputBorder(),
                          hintText: "**** **** **** ****",
                        ),
                        onChanged: (texto) {
                          cardNumber = texto;
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
                          if (value.trim().contains(" ")) {
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
                          if (value.trim().contains(" ")) {
                            return "El número de teléfono no puede contener espacios en blanco";
                          }
                          return null;
                        },
                        onChanged: (texto) {
                          phone = texto;
                        },
                      ),

                      /*Row(
                        children: [
                          // Flexible(
                          //   child: TextFormField(
                          //     keyboardType: TextInputType.number,
                          //     inputFormatters: [
                          //       FilteringTextInputFormatter.digitsOnly,
                          //       // LengthLimitingTextInputFormatter(1),
                          //     ],
                          //     controller: confirmCel,
                          //     decoration: InputDecoration(
                          //       suffixIcon: Icon(Icons.phone_android),
                          //       label: Text("Móvil a Confirmar"),
                          //       border: OutlineInputBorder(),
                          //       hintText: "+53 **** ** **",
                          //     ),
                          //     validator: (value) {
                          //       if (value == null || value.isEmpty) {
                          //         return "Campo requerido";
                          //       }
                          //       if (!GetUtils.isNum(value)) {
                          //         return "El número de teléfono debe contener solamente números";
                          //       }
                          //       if (value.length != 8) {
                          //         return "El número de teléfono es demasiado corto";
                          //       }
                          //       if (value[0] != "5") {
                          //         print(value[0]);
                          //         return "Número de teléfono no válido";
                          //       }
                          //       if (value.contains(" ")) {
                          //         return "El número de teléfono no puede contener espacios en blanco";
                          //       }
                          //     },
                          //     onChanged: (texto) {
                          //       phone = texto;
            
                          //       print(phone);
                          //     },
                          //   ),
                          // ),
                          // Flexible(
                          //   child: IconButton(
                          //       onPressed: () {
                          //         showDialog(
                          //             barrierDismissible: true,
                          //             context: context,
                          //             builder: (context) {
                          //               // transferPass.clear();
                          //               return ContactsList(controller: controller
                          //                   // function: transferController.transferCard(),
                          //                   );
                          //             });
                          //       },
                          //       icon: Icon(Icons.quick_contacts_dialer_rounded)),
                          // )
                        ],
                      ),*/
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
                                          dartz.Either<Failure,
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
                              var aux2 = double.parse(amount);
                              log("ESTE ES AUX2>>>>>>>>>>>>>$aux2");
                              var aux =
                                  NumberFormat.simpleCurrency().format(aux2);
                              log("ESTE ES AUX>>>>>>>>>>>>>>>$aux");
                              var test = aux.replaceAll("\$", "");
                              log("ESTE ES TEST>>>>>>>>>>>>>>>$test");
                              var pan = cardNumber.replaceAll(" ", "");

                              var numeroCard =
                                  await accountController.cifrar(pan);
                              fundingCardUUID = sysStore.get(
                                  "fundingCardUuidToTransfer", null);
                              currency =
                                  sysStore.get("currencyToTransfer", null);
                              Map<String, dynamic> params = {
                                "amount": test,
                                "pan": numeroCard,
                                "funding_source_uuid": fundingCardUUID,
                                "description": descripText,
                                "currency": currency,
                                // "payment_password": "$paymentPassword",
                                "fingerprint": "",
                                "phone": phone
                              };
                              log("ESTE ES PARAMS EN TRANSFER TO CARD VIEW>>>>>>>$params");
                              log("ESTE ES FUNDING EN TRANSFER ACCOUNT VIEW DESPUES DE TOCAR ACEPTAR>>>>>>>>>$fundingCardUUID");
                              log("ESTE ES CURRENCY EN TRANSFER ACCOUNT VIEW DESPUES DE TOCAR ACEPTAR>>>>>>>>>$currency");
                              // var aux = numberFormat(amount);
                              // log("ESTE ES AUX>>>>>>>>>>>>$aux");
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    // transferPass.clear();
                                    return TransferAlertView(
                                      contexto: contexto!,
                                      params: params,
                                      movilToConfirm: phone,
                                      pan: cardNumber,
                                      parsedAmount: aux,
                                      // function: transferController.transferCard(),
                                    );
                                  });
                              noTarjeta.clear();
                              importe.clear();
                              confirmCel.clear();
                              description.clear();
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
        });
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

class _ContactsListState extends State<ContactsList> {
  List? contacts;
  late Store<dynamic, dynamic> sysStore;
  TransferController? transferController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Lista de contactos"),
        content: (contacts == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: 300,
                width: 250,
                // color: Colors.amber,
                child: ListView.builder(
                    itemCount: contacts!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Uint8List? image = contacts![index].photo;
                      String number = (contacts![index].phones.isNotEmpty)
                          ? contacts![index].phones.first.number
                          : "---";
                      return ListTile(
                        title: Text(contacts![index].displayName),
                        leading: (image == null)
                            ? CircleAvatar(
                                child: Icon(Icons.person),
                              )
                            : CircleAvatar(
                                backgroundImage: MemoryImage(image),
                              ),
                        subtitle: Text(number),
                        onTap: () {
                          sysStore.set("contactNumber", number);
                          Get.back();
                          transferController!.update(["TransferCardView"]);
                        },
                      );
                    }),
              ));
  }

  void getPhoneData() async {
    /*if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);

      setState(() {});
    }*/
    // else {
    //   Get.snackbar("Atencion!!!",
    //       "Necesita otorgar permisos para acceder a los contactos");
    // }
  }

  @override
  void initState() {
    getPhoneData();
    sysStore = StoreService().getStore("system");
    transferController = widget.controller;
    super.initState();
  }
}
