import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/constants.dart';
import '../../../../widgets/images/network_image_ssl.dart';
import '../../controllers/gift_controller.dart';
import '../../domain/entities/gift.dart';
import '../../widgets/gift_widgets/tarjeta_widget.dart';

class DetailGiftView extends GetView<GiftController> {
  DetailGiftView({
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Gift;
    String recipientName;
    String amount = "";
    String description = "";
    String currency = "";
    Size size = MediaQuery.of(context).size;
    assert(amount == "" && description == "" && currency == "");
    return GetBuilder<GiftController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actions: [
                            Center(
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'ACEPTAR',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                            )
                          ],
                          title: Text('Reclamar'),
                          content: TextFormField(
                            decoration: InputDecoration(label: Text('Mensaje')),
                          ),
                        );
                      });
                },
                child: Text(
                  'Reclamar',
                  style: TextStyle(color: Colors.black45),
                ))
          ],
          leadingWidth: size.width / 20,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.close,
                color: Colors.black,
                size: size.height / 40,
              )),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Container(
            //color: Colors.red,
            child: Text(
              'Detalles del regalo',
              style: TextStyle(fontSize: size.height / 50, color: Colors.black),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 30),
          child: Center(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: AssetImage(
                            'assets/images/icons/app/enzona/emptyimg.jpeg'),
                        image: NetworkImageSSL(
                            '${Constants.mediaHost}${_.imageByUser}') /* NetworkImage(
                            '${Constants.mediaHost}images/user/avatar/ez_56651781.png') */

                        )),
                SizedBox(
                  height: size.height / 40,
                ),
                Text(
                  arguments.recipient.name.isNotEmpty
                      ? '${arguments.recipient.name} ${arguments.recipient.lastname}'
                      : '${arguments.source.name} ${arguments.source.lastname}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: size.height / 40),
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                Text(
                  arguments.statusDenom == 'Aceptada'
                      ? 'Regalo confirmado'
                      : arguments.statusDenom == 'Rechazada'
                          ? 'Regalo rechazado'
                          : '',
                  style: TextStyle(
                      color: Colors.green, fontSize: size.height / 40),
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      arguments.source.name.isEmpty
                          ? '-${arguments.amount}'
                          : '+${arguments.amount}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.height / 40),
                    ),
                    Text(
                      ' ${arguments.currency.toUpperCase()}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.height / 40),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      createDate(arguments.createdAt),
                      style: TextStyle(
                          color: Colors.grey, fontSize: size.height / 40),
                    ),
                    SizedBox(
                      width: size.width / 40,
                    ),
                    Text('${createTime(arguments.createdAt)}H',
                        style: TextStyle(
                            color: Colors.grey, fontSize: size.height / 40))
                  ],
                ),
                SizedBox(
                  height: size.height / 15,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('No.Operación'),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        arguments.transactionSignature,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                TarjetaWidget(),
                SizedBox(
                  height: size.height / 40,
                ),
                Container(
                  height: size.height / 15,
                  width: size.width / 1.1,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          elevation: 4, backgroundColor: Colors.red),
                      onPressed: () {
                        if (arguments.recipient.name.isNotEmpty) {
                          recipientName =
                              '${arguments.recipient.name} ${arguments.recipient.lastname}';

                          _.update();
                        } else {
                          recipientName =
                              '${arguments.source.name} ${arguments.source.lastname}';

                          _.update();
                        }
                        if (arguments.source.name.isEmpty) {
                          amount = '-${arguments.amount}';
                          _.update();
                        } else {
                          amount = '+${arguments.amount}';

                          _.update();
                        }
                        description = arguments.description;
                        currency = arguments.currency;
                        _.update();
                        /* Get.toNamed(Routes.POSTALVIEW,
                            arguments: _arguments.cardReference); */
                      },
                      child: Text(
                        'Ver Animacion',
                        style: TextStyle(
                            color: Colors.amber, fontSize: size.width / 20),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String createDate(String createAt) {
    var date = createAt.replaceRange(10, null, '').replaceAll('-', '/');
    return date;
  }

  createTime(String createAt) {
    var timeA = createAt.replaceRange(0, 11, '').replaceAll('-', '/');
    var time = timeA.replaceRange(5, null, '');
    return time;
  }
}
