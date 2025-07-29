// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  Widget? icono;
  String? texto;
  String? rutaAsset;
  Function onPressed;
  OptionWidget(
      {Key? key,
      required this.rutaAsset,
      required this.texto,
      this.icono,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        ListTile(
            onTap: () async {
              await onPressed();
            },
            title: Text(texto!, style: const TextStyle(fontSize: 19)),
            leading: Image.asset(
              rutaAsset!,
              scale: 2.6,
            ),
            trailing: icono),
        Divider(
          height: 2,
        )
      ],
    ));
  }
}
