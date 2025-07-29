import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/size_constraints.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  final Color textColor;
  final double textHeight;
  final bool isFill;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.textHeight = 4.5,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.isFill = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConstraints sizeConst = SizeConstraints(context: context);
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: isFill
            ? MaterialStateProperty.all(color)
            : MaterialStateProperty.all(Colors.blue.shade200),
        side: MaterialStateProperty.all(
          BorderSide(color: color),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: textHeight < 4.5 ? 4.0 : 10.0,
          horizontal: textHeight < 4.5 ? 4.0 : 10.0,
        ),
        child: Text(
          text,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            fontSize: sizeConst.getWidthByPercent(textHeight),
            color: textColor,
          ),
          textAlign: TextAlign.center,

          // TextStyle(
          //     color: textColor,
          //     fontWeight: FontWeight.bold,
          //     fontSize: size.height / 40),
        ),
      ),
      onPressed: () => press(),
    );
  }
}
