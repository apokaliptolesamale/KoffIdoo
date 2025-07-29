// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class EmptyDataSearcherResult extends StatelessWidget {
  Widget? child;
  TextStyle? style;
  EdgeInsetsGeometry? margin;
  BoxDecoration? decoration;

  EmptyDataSearcherResult({
    Key? key,
    this.child,
    this.style,
    this.margin,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final constraint = SizeConstraints(context: context);
    return Container(
      alignment: Alignment.center,
      decoration:
          decoration /*??
          BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            color: Color.fromARGB(255, 231, 233, 245),
            border: Border.all(
              color: Colors.indigo.withOpacity(0.4),
            ),
          )*/
      ,
      child: child ??
          Text("Iniciando...", style: style ?? TextStyle(fontSize: 20)),
    );
  }
}
