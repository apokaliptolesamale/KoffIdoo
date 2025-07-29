import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/config/errors/errors.dart';
import '../domain/models/card_model.dart';
import '/app/widgets/utils/loading.dart';
import '../controllers/card_controller.dart';
// ignore: library_prefixes
import '../domain/models/balance_model.dart';

class ConsultarSaldo extends StatelessWidget {
  final CardModel card;
  const ConsultarSaldo({
    Key? key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    CardController controller = Get.find();

    Size size = MediaQuery.of(context).size;
    TextStyle style = TextStyle(fontSize: size.height * 0.026);
    return FutureBuilder(
        future: controller.getBalance(card.fundingSourceUuid),
        builder:
            (context, AsyncSnapshot<Either<Failure, BalanceModel>> snapshot) {
          if (!snapshot.hasData) {
            return Loading(
              text: "Consultando saldo...",
              backgroundColor: Colors.lightBlue.shade700,
              animationColor: AlwaysStoppedAnimation<Color>(
                  Colors.lightBlue.withOpacity(0.8)),
              containerColor: Colors.lightBlueAccent.withOpacity(0.2),
            );
          } else {
            //Either<Failure, BalanceModel>? balance = snapshot.data;
            if (snapshot.data!.isRight()) {
              return snapshot.data!.fold((l) {
                l.toString();
                return AlertDialog(
                  title: Text(l.toString()),
                ); /* showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text(l.toString()),
                      );
                    }); */
                //return Container();
              }, (r) {
                return AlertDialog(
                  title: Container(
                      child: Row(
                    children: [
                      Text('Consultar saldo'),
                      Expanded(child: Container()),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close)),
                    ],
                  )),
                  content: Container(
                    height: size.height / 2,
                    width: size.width / 2,
                    child: Column(
                      children: [
                        Text(
                          'Saldo disponible',
                          style: TextStyle(fontSize: size.height * 0.03),
                        ),
                        Text('${r.balanceAvailable}${' '}${r.currency}',
                            style: TextStyle(
                                fontSize: size.height * 0.03,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        ListTile(
                          title: Text('Saldo contable', style: style),
                          subtitle: Text(
                            '${r.balance}${' '}${card.currency}',
                            style: style,
                          ),
                        ),
                        ListTile(
                          title: Text('Tarjetas Consultada', style: style),
                          subtitle: Text('**** **** **** ${card.last4}',
                              style: style),
                        ),
                        ListTile(
                          title: Text('Cuenta', style: style),
                          subtitle: Text(
                            r.bankAccount,
                            style: style,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                //return Container();
              });
            } else {
              return AlertDialog();
            }
          }
        });
  }
}
