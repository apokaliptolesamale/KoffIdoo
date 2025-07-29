import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/modules/home/controllers/home_controller.dart';
import '../../../core/services/paths_service.dart';
import '../../../widgets/utils/size_constraints.dart';
import '../../security/domain/models/account_model.dart';
import '../controllers/transfer_controller.dart';
import '../domain/entities/transfer.dart';
import 'find_account_view.dart';

class TransferAccountDetailsView extends StatelessWidget {
  Transfer? transfer;
  String image = "";
  String isVerified;
  BuildContext? contexto;
  var account = Get.find<AccountModel>();
  TransferAccountDetailsView(
      {required this.transfer, required this.isVerified, this.contexto});

  getPictureCard(Transfer transfer, BuildContext context) {
    SizeConstraints sizeConstraints = SizeConstraints(context: context);
    String image = "";

    switch (transfer.source.bank.toString()) {
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
        child: transfer.recipient.avatar != ""
            ? Image.asset(
                image,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset("assets/images/im_foto_tarjeta.png");
                },
                // backgroundColor: Colors.blue,
                // radius: sizeConstraints.getHeightByPercent(6),
                // backgroundImage: AssetImage(image),
              )
            : Image.asset(
                image,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset("assets/images/im_foto_tarjeta.png");
                },
                // backgroundColor: Colors.blue,
                // radius: sizeConstraints.getHeightByPercent(6),
                // backgroundImage: AssetImage(image),
              ));
  }

  getPictureProfile(Transfer transfer, BuildContext context) {
    SizeConstraints sizeConstraints = SizeConstraints(context: context);
    // switch (transfer.recipient.bank.toString()) {
    //   case "95":
    //     image = "assets/cards/banmet.png";
    //     break;
    //   case "12":
    //     image = "assets/cards/bpa.png";
    //     break;
    //   case "06":
    //     image = "assets/cards/bandec.png";
    //     break;
    //   case "04":
    //     image = "assets/cards/bicsa.png";
    //     break;
    //   default:
    //     image = "assets/images/im_foto_tarjeta.png";
    // }
    return CircleAvatar(
      backgroundColor: Colors.blue[700],
      radius: 50,
      child: transfer.recipient.avatar != ""
          ? CircleAvatar(
              onBackgroundImageError: (exception, stackTrace) {
                Image.asset(
                    "assets/images/backgrounds/enzona/im_foto_usuario.png");
              },
              backgroundColor: Colors.blue,
              radius: sizeConstraints.getHeightByPercent(6),
              backgroundImage: NetworkImage("${PathsService.mediaHost}"
                  "${transfer.recipient.avatar}"),
            )
          : CircleAvatar(
              onBackgroundImageError: (exception, stackTrace) {
                Image.asset(
                    "assets/images/backgrounds/enzona/im_foto_usuario.png");
              },
              backgroundColor: Colors.blue,
              radius: sizeConstraints.getHeightByPercent(6),
              backgroundImage: AssetImage(
                  "assets/images/backgrounds/enzona/im_foto_usuario.png")),
    );
    // if (transfer.recipient.avatar != "") {
    //   return CircleAvatar(
    //     onBackgroundImageError: (exception, stackTrace) {
    //       AssetImage("assets/images/backgrounds/enzona/im_foto_usuario.png");
    //     },
    //     backgroundColor: Colors.blue,
    //     radius: sizeConstraints.getHeightByPercent(30),
    //     backgroundImage: NetworkImage(
    //         "${PathsService.mediaHost}"
    //         "${transfer.recipient.avatar}",
    //         scale: 2.0),
    //   );
    // } else {
    //   return Container(
    //       width: MediaQuery.of(context).size.width * 0.30,
    //       height: MediaQuery.of(context).size.width * 0.30,
    //       clipBehavior: Clip.antiAlias,
    //       decoration: BoxDecoration(
    //         shape: BoxShape.circle,
    //       ),
    //       child: CircleAvatar(
    //         onBackgroundImageError: (exception, stackTrace) {
    //           AssetImage(
    //               "assets/images/backgrounds/enzona/im_foto_usuario.png");
    //         },
    //         backgroundColor: Colors.blue,
    //         radius: sizeConstraints.getHeightByPercent(6),
    //         backgroundImage: AssetImage(
    //             "assets/images/backgrounds/enzona/im_foto_usuario.png"),
    //       ));
    // }
  }

  Widget getNameBySourceDetail(Transfer transfer, BuildContext context) {
    if (transfer.recipient.name.toString() != "null" &&
        transfer.recipient.lastName.toString() != "null") {
      return Text(
        "${transfer.recipient.name} ${transfer.recipient.lastName}",
        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 15),
        overflow: TextOverflow.ellipsis,
      );
    } else {
      return Text(
        "${transfer.recipient.userName}",
        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 15),
        overflow: TextOverflow.ellipsis,
      );
    }
  }

  Widget getStatus(Transfer transfer, BuildContext context) {
    String? status;
    Widget? text;
    Color color = Colors.black;

    switch (transfer.statusDenom) {
      case "Aceptada":
        color = Colors.green;
        status = "confirmada";
        break;
      case "Fallida":
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

  Widget getNumberAmountBySource(Transfer transfer, BuildContext context) {
    if (transfer.source.name.toString() != "null") {
      return Text(
        "-${transfer.amount.toString()}",
        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 15),
      );
    } else if (transfer.source.name.toString() == "null") {
      return Text(
        "-${transfer.amount.toString()}",
        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 15),
      );
    } else {
      return Text(
        "error",
        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 15),
      );
    }
  }

  Widget getDescription(Transfer transfer, BuildContext context) {
    if (transfer.description.toString() != "null") {
      return Flexible(
        child: Text(transfer.description!,
            overflow: TextOverflow.fade,
            maxLines: 10,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width / 24)),
      );
    } else {
      return Text("");
    }
  }

  String parseDateTime(Transfer transfer, BuildContext context) {
    String toReturn = "";
    if (transfer == null) {
      var aux = DateTime.now().toString();
      toReturn = aux.substring(0, 19);
    } else {
      var aux = transfer.createAt.toString();
      toReturn = aux.substring(0, 19);
    }
    return toReturn;
  }

  Widget getLast4BySource(Transfer transfer, BuildContext context) {
    SizeConstraints sizeConstraints = SizeConstraints(context: context);
    if (transfer.source.last4.toString() != "null" &&
        transfer.recipient.last4.toString() == "null") {
      return Text(
        "(${transfer.source.last4.toString()})",
        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 23),
      );
    } else {
      return FittedBox(
        child: Text(
          "(${transfer.recipient.last4.toString()})",
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
                contexto!,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => FindAccountView(),
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
                            child: Stack(children: [
                              getPictureProfile(transfer!, context),
                              isVerified == "1"
                                  ? Positioned(
                                      right: 8,
                                      bottom: 1,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              25,
                                      width:
                                          MediaQuery.of(context).size.height /
                                              25,
                                      child: Container(
                                        // color: Colors.amber,
                                        child: Image.asset(
                                          "assets/images/icons/app/enzona/confir.png",
                                          // scale: 1,
                                        ),
                                      ))
                                  : Container()
                            ])),
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
                            child: getNameBySourceDetail(transfer!, context)),
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
                          child: getStatus(transfer!, context)),
                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(),
                        alignment: AlignmentDirectional(0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getNumberAmountBySource(transfer!, context),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 100,
                            ),
                            Text(
                              transfer!.currency.toUpperCase(),
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
                              parseDateTime(transfer!, context),
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
                              getDescription(transfer!, context)
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
                                        transfer!.transactionSignature,
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
                          )
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
                            getPictureCard(transfer!, context),

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
                                child: getLast4BySource(transfer!, context)),
                            Divider(
                              indent: 5.0,
                            ),

                            Text(
                              transfer!.currency.toUpperCase(),
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
