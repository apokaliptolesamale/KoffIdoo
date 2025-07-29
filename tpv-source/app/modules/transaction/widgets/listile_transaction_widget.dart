import 'dart:io';

import 'package:flutter_svg/svg.dart';

import '/app/core/constants/IDPConstantes.dart';
import '/app/core/services/logger_service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/app/modules/transaction/domain/entities/transaction.dart';
import 'transaction_detail.dart';
import '/app/modules/transaction/widgets/image_avatar_widget.dart';
//import 'package:intl/intl.dart';

class ListTileTransaction extends StatelessWidget {
  BuildContext context;
  Transaction transaction;
  ListTileTransaction({
    Key? key,
    required this.transaction,
    required this.context,
  });

  var imagen = false;

  String getImageByBank(Transaction transaction) {
    String image = "";
    if (transaction.recipient!.fundingRecipientBank != null) {
      switch (transaction.recipient!.fundingRecipientBank.toString()) {
        case "95":
          image = "assets/images/icons/app/enzona/banmet_logo.svg";
          break;
        case "06":
          image = "assets/images/icons/app/enzona/bandec_logo.svg";
          break;
        case "12":
          image = "assets/images/icons/app/enzona/bpa_logo.svg";
          break;
        case "04":
          image = "assets/images/icons/app/enzona/bicsa_logo.svg";
          break;
        default:
      }
    }
    return image;
  }

  String getBank(Transaction transaction) {
    String bank;
    if (transaction.recipient!.fundingRecipientBank != null) {
      switch (transaction.recipient!.fundingRecipientBank.toString()) {
        case "95":
          bank = "BANMET";
          break;
        case "06":
          bank = "BANDEC";
          break;
        case "12":
          bank = "BPA";
          break;
        case "04":
          bank = "BICSA";
          break;
        default:
          bank = "";
      }
      return bank;
    } else {
      return bank = "";
    }
  }

  bool isVerified(Transaction transaction) {
    int? sourceVerified = transaction.source!.fundingSourceVerified;
    int? recipientVerified = transaction.source!.fundingSourceVerified;
    if (transaction.transactionCode == 1000) {
      if (sourceVerified == 1 && sourceVerified != null) {
        return true;
      } else if (recipientVerified == 1 && recipientVerified != null) {
        return true;
      } else if (recipientVerified == 1 &&
          recipientVerified != null &&
          sourceVerified == 1 &&
          sourceVerified != null) {
        return true;
      }
    } else if (transaction.transactionCode != 1000) {
      return false;
    }
    return false;
  }

  Widget showPicture(Transaction transaction, BuildContext context) {
    if (transaction.transactionCode != 1000 &&
        transaction.transactionCode != 1006 &&
        transaction.transactionDenom != "Pago a Persona") {
      return CircleAvatar(
        radius: 35,
        child: Image.asset(
          getPicureService(context, transaction),
          scale: 0.1,
        ),
      );
    } else if (transaction.transactionCode == 1006 ||
        transaction.transactionCode == 1004) {
      return CircleAvatar(
          radius: 35,
          child: ClipOval(
            child: SvgPicture.asset(
              getImageByBank(transaction),
              semanticsLabel: 'Image SVG',
              fit: BoxFit.cover,
            ),
          ));
    } else if (getPicture(transaction, 35) == null) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        clipBehavior: Clip.antiAlias,
        child: CircleAvatar(
          radius: 35,
          child: Image.asset(
            "assets/images/backgrounds/enzona/im_foto_usuario.png",
            scale: 0.1,
          ),
        ),
      );
    } else if (transaction.transactionDenom == "Pago a Persona") {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        clipBehavior: Clip.antiAlias,
        child: CircleAvatar(
          radius: 35,
          child: Image.asset(
            "assets/images/backgrounds/enzona/im_foto_usuario.png",
            scale: 0.1,
          ),
        ),
      );
    } else if (transaction.recipient!.pan != null ||
        transaction.source!.pan != null) {
      return CircleAvatar(
        radius: 35,
        child:
            Image.asset("assets/images/backgrounds/enzona/im_foto_tarjeta.png"),
      );
    } else {
      return getPicture(transaction, 35)!;
    }
  }

  String getPicureService(BuildContext context, Transaction transaction) {
    String picture;
    switch (transaction.transactionCode) {
      case 1300:
        picture = "assets/images/backgrounds/enzona/im_foto_tarjeta.png";
        break;
      case 1500:
        picture = "assets/images/backgrounds/enzona/ic_pago_comercio.png";
        break;
      case 1700:
        picture = "assets/images/backgrounds/enzona/ic_tranferencia.png";
        break;
      case 1900:
        picture = "assets/images/backgrounds/enzona/electricidad.png";
        break;
      case 1601:
        picture = "assets/images/backgrounds/enzona/im_foto_usuario.png";
        break;
      case 2103:
        picture = "assets/images/backgrounds/enzona/ic_pago_telefono.png";
        break;
      case 2101:
        picture = "assets/images/backgrounds/enzona/ic_pago_telefono.png";
        break;
      case 2400:
        picture = "assets/images/backgrounds/enzona/correos.png";
        break;
      case 2500:
        picture = "assets/images/backgrounds/enzona/ic_pago_gas.png";
        break;
      case 3000:
        picture = "assets/images/backgrounds/enzona/ic_onat.png";
        break;
      case 1100:
        picture = "assets/images/backgrounds/enzona/im_foto_tarjeta.png";
        break;
      default:
        return "";
    }
    imagen = true;
    return picture;
  }

  Widget? getPicture(Transaction transaction, double size) {
    log("imagen de source........${transaction.source!.fundingSourceAvatar.toString()}");
    log("imagen de recipient........${transaction.recipient!.fundingRecipientAvatar.toString()}");
    if (itHaveSourceAvatar(transaction)) {
      log("imagen de source con url ........$URL_MEDIA${transaction.source!.fundingSourceAvatar!}");
      return ImageAvatarWidget(
        imageUrl: "$URL_MEDIA${transaction.source!.fundingSourceAvatar!}",
        radius: size,
      );
    } else if (itHaveRecipientAvatar(transaction)) {
      log("imagen de recipient con url........$URL_MEDIA${transaction.recipient!.fundingRecipientAvatar!}");
      return ImageAvatarWidget(
        imageUrl: "$URL_MEDIA${transaction.recipient!.fundingRecipientAvatar!}",
        radius: size,
        defaultImage: null,
      );
    } else {
      return CircleAvatar(
        radius: size,
        child: Image.asset(
          "assets/images/backgrounds/enzona/im_foto_usuario.png",
          scale: 0.1,
        ),
      );
    }
  }

  void onErrorPicture(String url) {
    Image.network(
      url,
    ).image.resolve(ImageConfiguration()).addListener(
          ImageStreamListener(
            (info, synchronousCall) {
              // La imagen se cargó correctamente
            },
            onError: (exception, stackTrace) {
              // Ocurrió un error durante la carga de la imagen
              if (exception is SocketException) {
                // Error de red, por ejemplo: falta de conexión o tiempo de espera agotado
              } else if (exception is HttpException) {
                // Error HTTP, por ejemplo: imagen no encontrada (error 404)
              } else {
                // Otro tipo de error, por ejemplo: formato de imagen no compatible
              }
            },
          ),
        );
  }

  bool itHaveSourceAvatar(Transaction transaction) {
    if (transaction.source!.fundingSourceAvatar == "null") {
      return false;
    } else if (transaction.source!.fundingSourceAvatar == "false") {
      return false;
    } else if (transaction.source!.fundingSourceAvatar == null) {
      return false;
    } else if (transaction.source!.fundingSourceAvatar == "") {
      return false;
    } else {
      return true;
    }
  }

  bool itHaveRecipientAvatar(Transaction transaction) {
    if (transaction.recipient!.fundingRecipientAvatar == "null") {
      return false;
    } else if (transaction.recipient!.fundingRecipientAvatar == "false") {
      return false;
    } else if (transaction.recipient!.fundingRecipientAvatar == null) {
      return false;
    } else if (transaction.recipient!.fundingRecipientAvatar == "") {
      return false;
    } else {
      return true;
    }
  }

  Widget getColorByTransactionStatus(Transaction transaction) {
    String? status = transaction.transactionStatus!;
    Color color;
    switch (transaction.transactionStatus) {
      case "Aceptada":
        color = Colors.green;
        break;
      case "Fallida":
        color = Colors.red;
        break;
      case "Pendiente":
        color = Colors.orange;
        break;
      default:
        color = Colors.transparent;
    }
    return Container(
      //height: MediaQuery.of(context).size.height/20,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
      child: Text(
        status,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto'),
      ),
    );
  }

  String getNameBySource(Transaction transaction, BuildContext context) {
    String name;
    if (transaction.source!.fundingSourceName != "" &&
        transaction.source!.fundingSourceLastname != "") {
      return name =
          "${transaction.source!.fundingSourceName} ${transaction.source!.fundingSourceLastname}";
    } else if (transaction.recipient!.fundingRecipientName != "" &&
        transaction.recipient!.fundingRecipientLastName != "") {
      return name =
          "${transaction.recipient!.fundingRecipientName} ${transaction.recipient!.fundingRecipientLastName}";
    } else if (transaction.recipient!.pan != null) {
      return name = "${getBank(transaction)} (${transaction.recipient!.pan})";
    } else if (transaction.source!.merchantAlias != null) {
      return transaction.source!.merchantAlias!;
    } else if (transaction.recipient!.merchantAlias != null) {
      return transaction.recipient!.merchantAlias!;
    } else {
      return "";
    }
  }

  Widget getNumberAmountBySource(Transaction transaction) {
    if (transaction.source!.fundingSourceName != "") {
      return Text(
        "+${transaction.amount}",
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.037,
            fontFamily: 'Roboto'),
      );
    } else if (transaction.source!.fundingSourceName == "") {
      return Text(
        "-${transaction.amount}",
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.037,
            fontFamily: 'Roboto'),
      );
    } else {
      return Text(
        "error",
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.037,
        ),
      );
    }
  }

  bool isPictureService() {
    if (transaction.transactionDenom != "Transferencia" &&
        transaction.transactionDenom != "Pago a Persona") {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    //bool imagenn = isPictureService();
    // HomeController controller = Get.find<HomeController>();
    DateFormat formatter = DateFormat().add_jm();
    DateTime transactionDate = transaction.transactionCreatedAt;
    String name = getNameBySource(transaction, context);
    Widget amount = getNumberAmountBySource(transaction);
    bool verified = isVerified(transaction);
    Widget? image = getPicture(transaction, 35);
    String bank = getImageByBank(transaction);
    Widget colorByStatus = getColorByTransactionStatus(transaction);
    Widget numberAmount = getNumberAmountBySource(transaction);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height / 30,
        top: MediaQuery.of(context).size.height / 200,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.12,
        child: ListTile(
          dense: false,
          visualDensity: VisualDensity(vertical: 4),
          onTap: () {
            Get.to(() => TransactionDetail(
                  transaction: transaction,
                  name: name,
                  amount: amount,
                  isVerified: verified,
                  bank: bank,
                  context: context,
                  picture: image!,
                ));
          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 25,
                  child: Text(
                    transaction.transactionDenom!,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontFamily: 'Roboto',
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
              Row(
                children: [
                  numberAmount,
                  Text(
                    transaction.currency!,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.037,
                      color: Colors.grey,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ],
          ),
          leading: Container(
            width: MediaQuery.of(context).size.width / 7,
            height: MediaQuery.of(context).size.height / 5,
            child: Stack(
              children: [
                showPicture(transaction, context),
                verified
                    ? Positioned(
                        right: 3,
                        bottom: 12,
                        height: MediaQuery.of(context).size.height / 50,
                        width: MediaQuery.of(context).size.height / 50,
                        child: Container(
                          child: Image.asset(
                            "assets/images/icons/app/enzona/confir.png",
                            scale: 0.1,
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 35,
                        child: Text(
                          getNameBySource(transaction, context),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.032),
                        ),
                      )),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                  Flexible(
                    flex: 2,
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "${transaction.transactionCreatedAt.day}/${transaction.transactionCreatedAt.month}/${transaction.transactionCreatedAt.year}",
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.032),
                            //overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textScaleFactor: constraints.maxWidth / 10,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  colorByStatus,
                  Expanded(child: Container()),
                  Text(
                    formatter.format(transactionDate).toLowerCase(),
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: MediaQuery.of(context).size.width * 0.032),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Divider(
                height: 2,
                thickness: 1,
                indent: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /* String getBank(Transaction transaction) {
    String bank;
    if (transaction.source!.foundignSourceBank != null) {
      switch (transaction.source!.foundignSourceBank.toString()) {
        case "95":
        case "05":
          bank = "BANMET";
          break;
        case "06":
          bank = "BANDEC";
          break;
        case "12":
          bank = "BPA";
          break;
        case "04":
          bank = "BICSA";
          break;
        default:
          bank = "";
      }
      return bank;
    } else if (transaction.recipient!.fundingRecipientBank != null) {
      switch (transaction.recipient!.fundingRecipientBank.toString()) {
        case "95":
        case "05":
          bank = "BANMET";
          break;
        case "06":
          bank = "BANDEC";
          break;
        case "12":
          bank = "BPA";
          break;
        case "04":
          bank = "BICSA";
          break;
        default:
          bank = "";
      }
      return bank;
    } else {
      return bank = "";
    }
  }*/

  /* Widget getColorByTransactionStatus(Transaction transaction) {
    String? status = transaction.transactionStatus!;
    Color color;
    switch (transaction.transactionStatus) {
      case "Aceptada":
        color = Colors.green;
        break;
      case "Fallida":
        color = Colors.red;
        break;
      case "Pendiente":
        color = Colors.orange;
        break;
      default:
        color = Colors.transparent;
    }
    return Container(
      //height: MediaQuery.of(context).size.height/20,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
      child: Text(
        status,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto'),
      ),
    );
  }*/

  /* String getImageByBank(Transaction transaction) {
    String image;
    if (transaction.source!.foundignSourceBank != null) {
      switch (transaction.source!.foundignSourceBank.toString()) {
        case "95":
        case "05":
          image = "assets/images/backgrounds/enzona/banmet.png";
          break;
        case "06":
          image = "assets/images/backgrounds/enzona/bandec_new.png";
          break;
        case "12":
          image = "assets/images/backgrounds/enzona/bpa_new.png";
          break;
        case "04":
          image = "assets/images/backgrounds/enzona/bicsa_new.png";
          break;
        default:
          image = "";
      }
      return image;
    } else if (transaction.recipient!.fundingRecipientBank != null) {
      switch (transaction.recipient!.fundingRecipientBank.toString()) {
        case "95":
        case "05":
          image = "assets/images/backgrounds/enzona/banmet.png";
          break;
        case "06":
          image = "assets/images/backgrounds/enzona/bandec_new.png";
          break;
        case "12":
          image = "assets/images/backgrounds/enzona/bpa_new.png";
          break;
        case "04":
          image = "assets/images/backgrounds/enzona/bicsa_new.png";
          break;
        default:
      }
    }
    return image = "";
  }*/

  /* String getNameBySource(Transaction transaction, BuildContext context) {
    //String name;
    if (transaction.source!.fundingSourceName != "" &&
        transaction.source!.fundingSourceLastname != "") {
      return "${transaction.source!.fundingSourceName} ${transaction.source!.fundingSourceLastname}";
    } else if (transaction.recipient!.fundingRecipientName != "" &&
        transaction.recipient!.fundingRecipientLastName != "") {
      return "${transaction.recipient!.fundingRecipientName} ${transaction.recipient!.fundingRecipientLastName}";
    } else if (transaction.recipient!.pan != null) {
      return "${getBank(transaction)} (${transaction.recipient!.pan})";
    } else if (transaction.source!.pan != null) {
      return "${getBank(transaction)} (${transaction.source!.pan})";
    } else {
      return "";
    }
  }*/

  /* Widget getNumberAmountBySource(Transaction transaction) {
    if (transaction.source!.fundingSourceName != "") {
      return Text(
        "+${transaction.amount}",
        style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
      );
    } else if (transaction.source!.fundingSourceName == "") {
      return Text(
        "-${transaction.amount}",
        style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
      );
    } else {
      return Text(
        "error",
        style: TextStyle(fontSize: 18),
      );
    }
  }*/

  /* ImageProvider? getPicture(Transaction transaction) {
    log("imagen de source........${transaction.source!.fundingSourceAvatar.toString()}");
    log("imagen de recipient........${transaction.recipient!.fundingRecipientAvatar.toString()}");
    if (itHaveSourceAvatar(transaction)) {
      log("imagen de source con url ........$URL_MEDIA${transaction.source!.fundingSourceAvatar!}");
      return NetworkImage(
          "$URL_MEDIA${transaction.source!.fundingSourceAvatar!}");
    } else if (itHaveRecipientAvatar(transaction)) {
      log("imagen de recipient con url........$URL_MEDIA${transaction.recipient!.fundingRecipientAvatar!}");
      return NetworkImage(
          "$URL_MEDIA${transaction.recipient!.fundingRecipientAvatar!}");
    } else {
      return null;
    }
  }*/

  /* String getPicureService(BuildContext context, Transaction transaction) {
    String picture;
    switch (transaction.transactionDenom) {
      case "Activación de tarjetas":
        picture = "assets/images/backgrounds/enzona/im_foto_tarjeta.png";
        break;
      case "Pagos a Comercios":
        picture = "assets/images/backgrounds/enzona/ic_pago_comercio.png";
        break;
      case "Donaciones":
        picture = "assets/images/backgrounds/enzona/ic_tranferencia.png";
        break;
      case "Electricidad":
        picture = "assets/images/backgrounds/enzona/electricidad.png";
        break;
      case "Pago de factura ETECSA":
        picture = "assets/images/backgrounds/enzona/ic_pago_telefono.png";
        break;
      case "Pago de servicio nauta ETECSA":
        picture = "assets/images/backgrounds/enzona/ic_pago_telefono.png";
        break;
      case "Pago del servicio propia ETECSA":
        picture = "assets/images/backgrounds/enzona/ic_pago_telefono.png";
        break;
      case "Giros de Correos de Cuba":
        picture = "assets/images/backgrounds/enzona/correos.png";
        break;
      case "Pago de Factura del Gas":
        picture = "assets/images/backgrounds/enzona/ic_pago_gas.png";
        break;
      case "Pago de Tributo a la ONAT ":
        picture = "assets/images/backgrounds/enzona/ic_onat.png";
        break;
      case "Regalo":
        picture = "assets/images/backgrounds/enzona/im_foto_tarjeta.png";
        break;
      default:
        return "";
    }
    imagen = true;
    return picture;
  }*/

  /*bool isPictureService() {
    if (transaction.transactionDenom != "Transferencia" &&
        transaction.transactionDenom != "Pago a Persona") {
      return true;
    } else {
      return false;
    }
  }*/

  /*  static CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    String bank = input.substring(4, 6);
    log("Bank $bank");
    switch (bank.toString()) {
      case "95":
      case "05":
        cardType = CardType.METRO;
        break;
      case "06":
        cardType = CardType.BANDEC;
        break;
      case "12":
        cardType = CardType.BPA;
        break;
      case "04":
        cardType = CardType.BICSA;
        break;
      default:
        cardType = CardType.Invalid;
    }

    return cardType;
  }*/

  /* bool isVerified(Transaction transaction) {
    int? sourceVerified = transaction.source!.fundingSourceVerified;
    int? recipientVerified = transaction.source!.fundingSourceVerified;
    if (sourceVerified == 1 && sourceVerified != null) {
      return true;
    } else if (recipientVerified == 1 && recipientVerified != null) {
      return true;
    } else if (recipientVerified == 1 &&
        recipientVerified != null &&
        sourceVerified == 1 &&
        sourceVerified != null) {
      return true;
    } else {
      return false;
    }
  }*/

  /* bool itHaveRecipientAvatar(Transaction transaction) {
    if (transaction.recipient!.fundingRecipientAvatar == "null") {
      return false;
    } else if (transaction.recipient!.fundingRecipientAvatar == "false") {
      return false;
    } else if (transaction.recipient!.fundingRecipientAvatar == null) {
      return false;
    } else if (transaction.recipient!.fundingRecipientAvatar == "") {
      return false;
    } else {
      return true;
    }
  }*/

  /* bool itHaveSourceAvatar(Transaction transaction) {
    if (transaction.source!.fundingSourceAvatar == "null") {
      return false;
    } else if (transaction.source!.fundingSourceAvatar == "false") {
      return false;
    } else if (transaction.source!.fundingSourceAvatar == null) {
      return false;
    } else if (transaction.source!.fundingSourceAvatar == "") {
      return false;
    } else {
      return true;
    }
  }*/

  /* Widget showPicture(Transaction transaction, BuildContext context) {
    if (getPicture(transaction) == null) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        clipBehavior: Clip.antiAlias,
        child: CircleAvatar(
          radius: 35,
          child: Image.asset(
            "assets/images/backgrounds/enzona/im_foto_usuario.png",
            scale: 0.1,
          ),
        ),
      );
    } else if (transaction.transactionDenom != "Transferencia" &&
        transaction.transactionDenom != "Pago a Persona") {
      imagen = true;
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        clipBehavior: Clip.antiAlias,
        child: CircleAvatar(
          radius: 35,
          child: Image.asset(
            getPicureService(context, transaction),
            scale: 0.1,
          ),
        ),
      );
    } else {
      return CircleAvatar(radius: 35, backgroundImage: getPicture(transaction));
    }
  }*/
}
