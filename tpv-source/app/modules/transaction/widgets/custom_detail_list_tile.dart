import 'package:flutter/material.dart';

class CustomDetailListTile extends StatelessWidget {
  String? titulo;
  String? value;
  bool? fontWeight;
  BuildContext context;
  CustomDetailListTile(
      {required this.titulo,
      required this.value,
      required this.fontWeight,
      required this.context,
      Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /*Container(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width / 30),
          child: Divider(
            height: 1,
            indent: 1,
          ),
        ),*/
        Divider(
          height: 1,
          indent: 1,
        ),
        ListTile(
          leading: Text(
            titulo!,
            style: TextStyle(
                fontFamily: "Roboto",
                fontSize: MediaQuery.of(context).size.width / 30),
          ),
          trailing: Text(
            value!,
            style: TextStyle(
                fontWeight: fontWeight! ? FontWeight.bold : FontWeight.normal),
          ),
          style: ListTileStyle.list,
          minVerticalPadding: 1,
          contentPadding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width / 10000,
              horizontal: MediaQuery.of(context).size.width / 30),
          dense: true,
        ),
      ],
    );
  }
}
