import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/size_constraints.dart';

// ignore: must_be_immutable
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
    SizeConstraints size = SizeConstraints(context: context);
    return Container(
        child: Column(
      children: [
        ListTile(
            onTap: () async {
              await onPressed();
            },
            title: Text(
              texto!,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: size.getWidthByPercent(5),
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
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
