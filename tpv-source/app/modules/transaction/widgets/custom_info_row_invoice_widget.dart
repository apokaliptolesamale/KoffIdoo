// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomInfoRowInvoiceWidget extends StatelessWidget {
  String title;
  String value;
  CustomInfoRowInvoiceWidget({
    Key? key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ListTile(
          leading: Text(
            title,
            style: TextStyle(
                fontFamily: "Roboto",
                fontSize: MediaQuery.of(context).size.width / 25),
          ),
          trailing: FittedBox(
            child: Text(
              //"Rolando Oro",
              value,
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: MediaQuery.of(context).size.width / 25),
            ),
          ),
        ),
        Container(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width / 30),
          child: Divider(
            height: 1,
            indent: 1,
          ),
        ),
      ],
    );
  }
}
