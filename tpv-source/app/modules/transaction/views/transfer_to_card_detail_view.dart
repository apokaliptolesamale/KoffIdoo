import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/modules/home/controllers/home_controller.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../../security/domain/models/account_model.dart';
import '../controllers/transfer_controller.dart';
import 'transfer_card_view.dart';

class TransferCardDetailsView extends StatelessWidget {
  String image = "";
  String? recipientBank;
  String? sourceBank;
  String? uncipherPan;
  String? transferStatus;
  String? monto;
  String? currency;
  DateTime? createAt;
  String? description;
  String? operationNumber;
  String? movilToConfirm;
  String? sourceLast4;
  BuildContext contexto;

  var account = Get.find<AccountModel>();
  TransferCardDetailsView(
      {this.recipientBank,
      required this.contexto,
      this.sourceBank,
      required this.uncipherPan,
      this.transferStatus,
      this.monto,
      this.currency,
      this.createAt,
      this.description,
      this.operationNumber,
      this.movilToConfirm,
      this.sourceLast4});

  getPictureCard(String? sourceBank, BuildContext context) {
    SizeConstraints sizeConstraints = SizeConstraints(context: context);
    String image = "";

    switch (recipientBank) {
      case "95":
        image = "assets/images/backgrounds/enzona/banmet.png";

        break;
      case "12":
        image = "assets/images/backgrounds/enzona/bpa.png";

        break;
      case "06":
        image = "assets/images/backgrounds/enzona/bandec.png";

        break;
      case "04":
        image = "assets/images/backgrounds/enzona/bicsa.png";

        break;
      default:
        image = "assets/images/backgrounds/enzona/im_foto_tarjeta.png";
    }
    return CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 35,
        backgroundImage: AssetImage(
          image,
          // errorBuilder: (context, error, stackTrace) {
          //   return Image.asset("assets/images/im_foto_tarjeta.png");
          // },
          // backgroundColor: Colors.blue,
          // radius: sizeConstraints.getHeightByPercent(6),
          // backgroundImage: AssetImage(image),
        ));
  }

  getPictureProfile(String? recipientBank, BuildContext context) {
    SizeConstraints sizeConstraints = SizeConstraints(context: context);
    String image = "";

    switch (recipientBank) {
      case "95":
        image = "assets/images/backgrounds/enzona/banmet.png";

        break;
      case "12":
        image = "assets/images/backgrounds/enzona/bpa.png";

        break;
      case "06":
        image = "assets/images/backgrounds/enzona/bandec.png";

        break;
      case "04":
        image = "assets/images/backgrounds/enzona/bicsa.png";

        break;
      default:
        image = "assets/images/backgrounds/enzona/im_foto_tarjeta.png";
    }
    return CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 35,
        backgroundImage: AssetImage(
          image,
          // errorBuilder: (context, error, stackTrace) {
          //   return Image.asset("assets/images/im_foto_tarjeta.png");
          // },
          // backgroundColor: Colors.blue,
          // radius: sizeConstraints.getHeightByPercent(6),
          // backgroundImage: AssetImage(image),
        ));
  }

  Widget getNameBySourceDetail(String? uncipherPan, BuildContext context) {
    if (uncipherPan != null || uncipherPan != "") {
      return Text(
        uncipherPan!,
        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 15),
        overflow: TextOverflow.ellipsis,
      );
    } else {
      return Text(
        "Tarjeta destino vacia",
        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 15),
        overflow: TextOverflow.ellipsis,
      );
    }
  }

  Widget getStatus(String? transferStatus, BuildContext context) {
    String? status;
    Widget? text;
    Color color = Colors.black;

    switch (transferStatus) {
      case "Aceptada":
        color = Colors.green;
        status = "confirmada";
        break;
      case "Fallida":
        color = Colors.red;
        status = "fallida";
        break;
      case null:
        color = Colors.red;
        status = "fallida";
    }
    text = Text(
      'Transferencia $status',
      textAlign: TextAlign.justify,
      maxLines: 1,
      style: TextStyle(
          color: color, fontSize: MediaQuery.of(context).size.width / 18),
    );

    return text;
  }

  Widget getNumberAmountBySource(String? monto, BuildContext context) {
    if (monto != null) {
      return Text(
        "-$monto",
        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 15),
      );
    } else if (monto == null) {
      return Text(
        "-$monto",
        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 15),
      );
    } else {
      return Text(
        "Error al obtener el monto",
        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 15),
      );
    }
  }

  Widget getDescription(String? description, BuildContext context) {
    if (description != null) {
      return Flexible(
        child: Text(description,
            overflow: TextOverflow.fade,
            maxLines: 10,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width / 24)),
      );
    } else {
      return Text("");
    }
  }

  String parseDateTime(DateTime? createAt, BuildContext context) {
    String toReturn = "";
    if (createAt == null) {
      var aux = DateTime.now().toString();
      toReturn = aux.substring(0, 19);
    } else {
      var aux = createAt.toString();
      toReturn = aux.substring(0, 19);
    }
    return toReturn;
  }

  Widget getLast4BySource(String? sourceLast4, BuildContext context) {
    SizeConstraints sizeConstraints = SizeConstraints(context: context);
    if (sourceLast4 != null) {
      return Text(
        "($sourceLast4)",
        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 23),
      );
    } else {
      return FittedBox(
        child: Text(
          "(Vacio last4)",
          style: TextStyle(fontSize: MediaQuery.of(context).size.width / 23),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConstraints sizeConstraints = SizeConstraints(context: context);
    HomeController controller = Get.find<HomeController>();
    TransferController transferController = Get.find<TransferController>();
    // DateFormat formatter = DateFormat("d/M/y");
    // DateFormat timeformat = DateFormat().add_jm();
    // DateTime date = transfer.createAt.toString();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          //foregroundColor: ,
          backgroundColor: Colors.grey,
          surfaceTintColor: Colors.red,
          title: Text("Detalles de la transferencia."),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pushReplacement(
                contexto,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => TransferCardView(),
                ),
              );
              // Get.offAll(EzHomeView());
            },
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text("Reclamar", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
        body: SafeArea(
            child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Align(
                  alignment: AlignmentDirectional(0.15, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, -0.25),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: 80,
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width,
                            ),
                            decoration:
                                BoxDecoration(color: Colors.transparent),
                            alignment:
                                AlignmentDirectional(0, -0.19999999999999996),
                            child: getPictureProfile(recipientBank, context)),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: getNameBySourceDetail(uncipherPan, context)),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(color: Colors.transparent),
                          alignment:
                              AlignmentDirectional(-0.050000000000000044, -0.4),
                          child: getStatus(transferStatus, context)),
                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(),
                        alignment: AlignmentDirectional(0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getNumberAmountBySource(monto, context),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 100,
                            ),
                            Text(
                              currency!.toUpperCase(),
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 15),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              parseDateTime(createAt, context),
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 18),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 15,
                              ),
                              Text(
                                "Descripción:",
                                maxLines: 5,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 20),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 20,
                              ),
                              getDescription(description, context)
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 50,
                          ),
                          Divider(
                            height: 1,
                          ),
                          Card(
                            //margin: EdgeInsets.all(10),
                            elevation: 2,
                            child: Container(
                              height: MediaQuery.of(context).size.height / 15,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          15),
                                  Text(
                                    "No. Operación:",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                23),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          3.2),
                                  FittedBox(
                                    fit: BoxFit.fill,
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      //height: MediaQuery.of(context).size.height/10,
                                      child: Text(
                                        operationNumber!,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                27),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          20)
                                ],
                              ),
                            ),
                          ),
                          movilToConfirm != null
                              ? Card(
                                  //margin: EdgeInsets.all(10),
                                  elevation: 2,
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 15,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                15),
                                        Text(
                                          "Móvil a confirmar:",
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  23),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.2),
                                        Flexible(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            //height: MediaQuery.of(context).size.height/10,
                                            child: Text(
                                              movilToConfirm!,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          27),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                20)
                                      ],
                                    ),
                                  ),
                                )
                              : Container()
                        ]),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 100,
                      ),
                      Card(
                        // color: Colors.pink,
                        //margin: EdgeInsets.all(10),
                        elevation: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 23,
                            ),
                            getPictureCard(sourceBank, context),

                            SizedBox(
                              width: MediaQuery.of(context).size.width / 15,
                            ),

                            // Flexible(
                            //   child: Container(
                            //     width: MediaQuery.of(context).size.width / 2,
                            //     color: Colors.amber,
                            //     child: FittedBox(
                            //       child: Text(
                            //         "${account.name.toUpperCase()}"
                            //         " "
                            //         "${account.lastname.toUpperCase()}",
                            //         maxLines: 1,
                            //         // overflow: TextOverflow.ellipsis,
                            //         style: TextStyle(
                            //             fontSize:
                            //                 sizeConstraints.getWidthByPercent(5)
                            //             // MediaQuery.of(context).size.width / 23
                            //             ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.7,
                              child: Text(
                                "${account.name.toUpperCase()}"
                                " "
                                "${account.lastname.toUpperCase()}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 23),
                              ),
                            ),
                            // FutureBuilder(
                            //     future: controller.getAccount(),
                            //     builder: (context, snapshots) {
                            //       if (!snapshots.hasData) {
                            //         return Center(
                            //           child: CircularProgressIndicator(),
                            //         );
                            //       } else {
                            //         Account account =
                            //             snapshots.data as Account;
                            //         return Container(
                            //           width:
                            //               MediaQuery.of(context).size.width /
                            //                   2.7,
                            //           child: Text(
                            //             "${account.name.toUpperCase()}"
                            //             " "
                            //             "${account.lastname.toUpperCase()}",
                            //             maxLines: 1,
                            //             overflow: TextOverflow.ellipsis,
                            //             style: TextStyle(
                            //                 fontSize: MediaQuery.of(context)
                            //                         .size
                            //                         .width /
                            //                     23),
                            //           ),
                            //         );
                            //       }
                            //     }),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 15),
                            // Divider(
                            //   indent: 5.0,
                            // ),

                            // Flexible(
                            //   child: Container(
                            //     width: MediaQuery.of(context).size.width * 0.25,
                            //     // width: MediaQuery.of(context).size.width / 20,
                            //     // height: MediaQuery.of(context).size.width / 20,
                            //     color: Colors.red,
                            //     child: getLast4BySource(transfer!, context),
                            //   ),
                            // ),
                            FittedBox(
                                fit: BoxFit.fill,
                                child: getLast4BySource(sourceLast4!, context)),
                            Divider(
                              indent: 5.0,
                            ),

                            Text(
                              currency!.toUpperCase(),
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 23),
                            )
                            // Container(
                            //   width: MediaQuery.of(context).size.width / 9,
                            //   // height: MediaQuery.of(context).size.width / 5,
                            //   color: Colors.blue,
                            //   child: FittedBox(
                            //     child: Text(
                            //       transfer!.currency.toUpperCase(),
                            //       style: TextStyle(
                            //           fontSize:
                            //               sizeConstraints.getWidthByPercent(5)
                            //           // MediaQuery.of(context).size.width / 23

                            //           ),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
