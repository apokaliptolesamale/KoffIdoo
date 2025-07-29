import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/card_controller.dart';
// ignore: library_prefixes
import '../domain/entities/card.dart' as cardEntity;

class DetailsCard extends StatelessWidget {
  final cardEntity.Card card;
  const DetailsCard({
    Key? key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle style = TextStyle(fontSize: size.height * 0.025);
    return GetBuilder<CardController>(
      builder: (controller) => AlertDialog(
        title: Container(
            child: Row(
          children: [
            Text('Detalles'),
            Expanded(child: Container()),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close)),
          ],
        )),
        content: Container(
            height: size.height * 0.50,
            child: ListView(
              children: [
                ListTile(
                  title: Text('Nombre', style: style),
                  subtitle: Text(
                    card.cardholder,
                    style: style,
                  ),
                ),
                ListTile(
                  title: Text('No.Tarjeta', style: style),
                  subtitle: Text('**** **** **** ${card.last4}', style: style),
                ),
                ListTile(
                  title: Text('Fecha de expiracion', style: style),
                  subtitle: Text(
                    changeFormatExpdate(),
                    style: style,
                  ),
                ),
                ListTile(
                  title: Text('Moneda', style: style),
                  subtitle: Text(
                    card.currency.toUpperCase(),
                    style: style,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cerrar'))
              ],
            )),
      ),
    );
  }

  changeFormatExpdate() {
    String expdate = card.expdate.toString();
    var deleteEnd = expdate.replaceRange(2, null, '');
    var deleteBegin = expdate.replaceRange(0, 2, '');
    var changedFormatExpdate = '$deleteBegin/$deleteEnd';
    return changedFormatExpdate;
  }
}
