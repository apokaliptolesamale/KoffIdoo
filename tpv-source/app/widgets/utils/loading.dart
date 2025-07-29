// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '/app/widgets/components/clock.dart';

class Loading extends StatelessWidget {
  Widget? textIndicator;
  String? text;
  Widget? container;
  Widget? indicator;
  Color? backgroundColor;
  AlwaysStoppedAnimation<Color>? animationColor;
  Color? containerColor;
  final TextStyle? style;
  Loading({
    Key? key,
    this.text,
    this.textIndicator,
    this.backgroundColor,
    this.animationColor,
    this.indicator,
    this.containerColor,
    this.style = const TextStyle(color: Colors.white),
    this.container,
  }) : super(key: key) {
    text = text ?? "Cargando...";
    textIndicator = textIndicator ??
        Text(
          text!,
          style: style ??
              TextStyle(
                fontSize: 20,
                color: Colors.teal,
              ),
        );
    container = container ??
        Center(
          child: Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // BouncingLoadingWidget(),
                indicator ??
                    CircularProgressIndicator(
                      backgroundColor:
                          backgroundColor ?? Colors.tealAccent.shade700,
                      valueColor: animationColor ??
                          AlwaysStoppedAnimation<Color>(
                              Colors.tealAccent.withOpacity(0.8)),
                    ),
                SizedBox(height: 30),
                textIndicator!,
              ],
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      scrollable: true,
      backgroundColor: containerColor ?? Colors.white,
      content: container,
    );
  }

  static Widget fromText({
    Key? key,
    String text = "Cargando...",
    Widget? indicator,
    TextStyle? style,
  }) {
    return Loading(
      key: key,
      text: text,
      indicator: indicator ??
          Clock(
            height: 50,
            width: 50,
          ),
      style: style,
    );
  }
}
