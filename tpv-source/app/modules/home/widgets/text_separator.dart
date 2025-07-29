// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/widgets/utils/size_constraints.dart';

class TextSeparator extends StatelessWidget {
  final String text;
  TextSeparator({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final constraint = SizeConstraints(context: context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: constraint.getWidthByPercent(1)),
      margin: EdgeInsets.only(bottom: 1),
      child: Text(
        text,
        overflow: TextOverflow.fade,
        style: GoogleFonts.roboto(
          color: Colors.white.withOpacity(0.3),
          fontSize: constraint.getWidthByPercent(1.5),
        ),
        textScaleFactor: 1,
      ),
    );
  }
}
