// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/size_constraints.dart';

class EzLogo extends StatelessWidget {
  double height = 35;
  EzLogo({
    Key? key,
    this.height = 35,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final constraint = SizeConstraints(context: context);
    return Container(
      width: double.infinity,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bubble_chart_outlined,
            color: Color(0xff7a6bf5),
            //size: constraint.getWidthByPercent(2),
          ),
          SizedBox(width: constraint.getWidthByPercent(1)),
          FittedBox(
            child: Text(
              'ENZONA',
              overflow: TextOverflow.clip,
              style: GoogleFonts.montserratAlternates(
                //fontSize: constraint.getWidthByPercent(2),
                fontWeight: FontWeight.w200,
                color: Colors.white,
              ),
              //textScaleFactor: 1,
            ),
          )
        ],
      ),
    );
  }
}
