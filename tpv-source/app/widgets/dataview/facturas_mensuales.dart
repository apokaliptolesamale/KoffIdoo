import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../botton/rounded_button.dart';
import '../utils/size_constraints.dart';

class FacturasMensuales extends StatelessWidget {
  final String backgroundImage;
  final String backgroundImagePagado;
  final String title;
  final String subtitle;
  final String buttonText;
  final String serviceType;

  final String realImport;
  final VoidCallback onPressed;

  FacturasMensuales(
      {required this.backgroundImage,
      required this.backgroundImagePagado,
      required this.title,
      required this.subtitle,
      required this.buttonText,
      required this.onPressed,
      required this.realImport,
      required this.serviceType});

  @override
  Widget build(BuildContext context) {
    SizeConstraints sizeConstraints = SizeConstraints(context: context);
    return Stack(
      fit: StackFit.loose,
      children: [
        Container(
          height: sizeConstraints.getHeightByPercent(8),
          width: sizeConstraints.getWidthByPercent(110),
          decoration: BoxDecoration(
            // color: Colors.amber,
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: serviceType == "tb"
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(title,
                    style: GoogleFonts.roboto(
                      fontSize: sizeConstraints.getWidthByPercent(5),
                      fontWeight: FontWeight.w400,
                    )
                    // TextStyle(
                    //   fontSize: sizeConstraints.getWidthByPercent(110),
                    //   fontWeight: FontWeight.bold,
                    //   color: Colors.black,
                    // ),
                    ),
                SizedBox(height: 10),
                Text(subtitle,
                    style: GoogleFonts.roboto(
                      fontSize: sizeConstraints.getWidthByPercent(4),
                      // fontWeight:  FontWeight.w00,
                    )
                    // TextStyle(
                    //   fontSize: 18,
                    //   color: Colors.black,
                    // ),
                    ),
                SizedBox(height: 7),
              ],
            ),
            SizedBox(width: 10),
            realImport == "0.0" && serviceType == "tb"
                ?
                // Image.asset(backgroundImagePagado)
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: sizeConstraints.getHeightByPercent(5),
                      width: sizeConstraints.getWidthByPercent(20),
                      decoration: BoxDecoration(
                        // color: Colors.amber,
                        image: DecorationImage(
                          image: AssetImage(backgroundImagePagado),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    // RoundedButton(
                    //   press: onPressed,
                    //   text: buttonText,
                    // ),
                  )
                : serviceType != "tb" && realImport == "0.0"
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: sizeConstraints.getWidthByPercent(25),
                          height: sizeConstraints.getHeightByPercent(5),
                          child: RoundedButton(
                            press: onPressed,
                            text: "Recargar",
                            textHeight: 3.5,
                          ),
                        ),
                      )
                    : Align(
                        alignment: Alignment.centerRight,
                        child: RoundedButton(
                          press: onPressed,
                          text: buttonText,
                        ),
                      ),
          ],
        ),
      ],
    );
  }
}
