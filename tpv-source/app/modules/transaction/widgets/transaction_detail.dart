import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/app/modules/security/domain/models/account_model.dart';
import '/app/modules/transaction/domain/entities/transaction.dart';
import '/app/modules/transaction/widgets/discount_amount_widget.dart';
import 'custom_detail_list_tile.dart';

class TransactionDetail extends StatelessWidget {
  String name;
  Widget amount;
  Function? avatar;
  Widget picture;
  Transaction transaction;
  bool isVerified;
  String bank;
  BuildContext context;
  TransactionDetail(
      {required this.transaction,
      required this.name,
      required this.amount,
      this.avatar,
      required this.picture,
      required this.isVerified,
      required this.bank,
      required this.context});

  /*Widget getPictureProfile(Transaction transaction, BuildContext context) {
    if (transaction == null) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.30,
        height: MediaQuery.of(context).size.width * 0.30,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        //TODO Rolando verifica ésto
        child: Image.network(
          'https://picsum.photos/seed/390/600',
          errorBuilder: ((context, Object exception, stackTrace) {
            return Text("error");
          }),
        ),
      );
    } else if (transaction.transactionDenom != "Transferencia" &&
        transaction.transactionDenom != "Pago a Persona") {
      return CircleAvatar(
        child: Image.asset(getPicureService(context, transaction)),
        radius: MediaQuery.of(context).size.height * 0.05,
      );
    } else {
      return CircleAvatar(
        backgroundImage: picture,
        radius: MediaQuery.of(context).size.height * 0.05,
      );
    }
  }*/

  String getPicureService(
    BuildContext context,
    Transaction transaction,
  ) {
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
    return picture;
  }

  Widget getLast4BySource(Transaction transaction, BuildContext context) {
    if (transaction.source!.foundingSourceLast4 != null &&
        transaction.recipient!.fundingRecipientLast4 == null) {
      return Text(
        "(${transaction.source!.foundingSourceLast4})",
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 30,
            fontFamily: 'Roboto'),
      );
    } else {
      return Text(
        "(${transaction.recipient!.fundingRecipientLast4})",
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 30,
            fontFamily: 'Roboto'),
      );
    }
  }

  Widget getStatus(Transaction transaction, BuildContext context) {
    String? texto;
    Color color = Colors.black;
    switch (transaction.transactionStatus) {
      case "Aceptada":
        color = Colors.green;
        texto = "Confirmada";
        break;
      case "Fallida":
        color = Colors.red;
        texto = "Fallida";
        break;
      case "Pendiente":
        color = Colors.orange;
        texto = "Pendiente";
        break;
      default:
    }
    return Text(
      '${transaction.transactionDenom} $texto',
      style: TextStyle(
          fontWeight: FontWeight.w200,
          fontFamily: "Roboto",
          fontSize: MediaQuery.of(context).size.width * 0.04,
          color: color),
    );
  }

  Widget getNumberAmountBySource(
      Transaction transaction, BuildContext context) {
    if (transaction.bankDebtitDetail != null) {
      return Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 10,
          child: DiscountAmountWidget(
            transaction: transaction,
            plusBonus: plusBonus(transaction),
            context: context,
          ));
    } else if (transaction.source!.fundingSourceName != "") {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "+${transaction.amount}",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontFamily: "Roboto"),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${transaction.currency}",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontFamily: "Roboto"),
              ),
            ],
          ),
        ],
      );
    } else if (transaction.source!.fundingSourceName == "") {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "-${transaction.amount}",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontFamily: "Roboto"),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${transaction.currency}",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontFamily: "Roboto"),
              ),
            ],
          ),
        ],
      );
    } else {
      return Text(
        "error",
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 18,
            fontFamily: "Roboto"),
      );
    }
  }

  int plusBonus(Transaction transaction) {
    var bonus = transaction.bankDebtitDetail!.discount;
    var redsa = transaction.bankDebtitDetail!.redsa;
    int bonu = int.parse(bonus!);
    int reds = int.parse(redsa!);
    return bonu + reds;
  }

  List<Widget> buildWidgetsFromModel(Transaction model) {
    List<Widget> widgets = [];
    if (model.transactionDescription != "") {
      widgets.add(
        CustomDetailListTile(
          titulo: "Descripcion",
          value: transaction.transactionDescription,
          fontWeight: false,
          context: context,
        ),
      );
    }
    if (model.transactionSignature != "") {
      widgets.add(
        CustomDetailListTile(
            titulo: "No. Operacion",
            value: transaction.transactionSignature,
            fontWeight: false,
            context: context),
      );
    }
    if (model.clientId != null) {
      widgets.add(
        CustomDetailListTile(
            titulo: "Id. Cliente",
            value: transaction.clientId.toString(),
            fontWeight: false,
            context: context),
      );
    }
    if (model.owner != "") {
      widgets.add(
        CustomDetailListTile(
            titulo: "Titular",
            value: transaction.owner,
            fontWeight: false,
            context: context),
      );
    }
    if (model.period != null) {
      widgets.add(
        CustomDetailListTile(
            titulo: "Fecha",
            value: "${transaction.period!.month}/${transaction.period!.year}",
            fontWeight: false,
            context: context),
      );
    }
    if (model.invoice != "") {
      widgets.add(
        CustomDetailListTile(
            titulo: "No. Factura",
            value: transaction.invoice,
            fontWeight: false,
            context: context),
      );
    }
    if (model.bankDebtitDetail != null) {
      if (model.bankDebtitDetail!.discount != "") {
        widgets.add(
          CustomDetailListTile(
              titulo: "Bonficacion",
              value: transaction.bankDebtitDetail!.discount,
              fontWeight: false,
              context: context),
        );
      }
      if (model.bankDebtitDetail!.redsa != "") {
        widgets.add(
          CustomDetailListTile(
              titulo: "Bonificacion REDSA",
              value: transaction.bankDebtitDetail!.redsa,
              fontWeight: false,
              context: context),
        );
      }
    }
    return widgets;
  }

  Widget buildInfoCard(BuildContext context) {
    AccountModel account = Get.find<AccountModel>();
    return Card(
      //margin: EdgeInsets.all(10),
      elevation: 2,
      child: Container(
        height: MediaQuery.of(context).size.height / 14,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 23,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.2,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Image.asset(bank),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width / 15,
            ),
            Container(
                width: MediaQuery.of(context).size.width / 2.7,
                child: Text(
                  "${account.name.toUpperCase()}"
                  " "
                  "${account.lastname.toUpperCase()}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 23),
                )),
            SizedBox(width: MediaQuery.of(context).size.width / 15),
            FittedBox(
                fit: BoxFit.fill,
                child: getLast4BySource(transaction, context)),
            Text(
              transaction.currency!.toUpperCase(),
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width / 23),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat("d/M/y");
    DateFormat timeformat = DateFormat().add_jm();
    DateTime date = transaction.transactionCreatedAt.toLocal();
    Widget status = getStatus(transaction, context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        surfaceTintColor: Colors.red,
        title: Text("Detalles"),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("Reclamar", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Primer Column
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(children: [
                        picture,
                        isVerified
                            ? Positioned(
                                right: 3,
                                bottom: 4,
                                height: MediaQuery.of(context).size.height / 30,
                                width: MediaQuery.of(context).size.height / 30,
                                child: Container(
                                  child: Image.asset(
                                    "assets/images/icons/app/enzona/confir.png",
                                    scale: 1,
                                  ),
                                ))
                            : Container()
                      ]),

                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                            fontSize: MediaQuery.of(context).size.width * 0.04),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      status,
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),

                      getNumberAmountBySource(transaction, context),
                      // SizedBox(height: MediaQuery.of(context).size.height/50,),
                      // SizedBox(height: 0,)
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                formatter.format(date),
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontFamily: 'Roboto',
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              Text(
                                timeformat.format(date),
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontFamily: 'Roboto',
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 40,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Segundo Column
                Card(
                  elevation: 1,
                  child: IntrinsicHeight(
                    // height: MediaQuery.of(context).size.height*0.4,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: buildWidgetsFromModel(transaction)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                buildInfoCard(context),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
