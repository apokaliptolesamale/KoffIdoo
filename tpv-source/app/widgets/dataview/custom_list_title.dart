import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomListTitleWidget extends StatelessWidget {
  // Widget icono;
  String? texto;
  String? rutaAsset;
  String? rutaAssetTrailing;
  Widget? subtexto;
  CustomListTitleWidget(
      {Key? key,
      required this.rutaAsset,
      required this.texto,
      this.rutaAssetTrailing,
      //required this.icono,
      required this.subtexto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return rutaAssetTrailing == null
        ? ListTile(
            onTap: null,
            title: Text(
              texto!,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  decorationStyle: TextDecorationStyle.solid,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: subtexto,
            leading: Image.asset(
              rutaAsset!,
              scale: 2.6,
            ),
          )
        : ListTile(
            onTap: null,
            title: Text(
              texto!,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  decorationStyle: TextDecorationStyle.solid,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: subtexto,
            leading: Image.asset(
              rutaAsset!,
              scale: 2.6,
            ),
            trailing: Image.asset(
              rutaAssetTrailing!,
              height: 30,
              width: 25,
            ),
          );
  }
}
