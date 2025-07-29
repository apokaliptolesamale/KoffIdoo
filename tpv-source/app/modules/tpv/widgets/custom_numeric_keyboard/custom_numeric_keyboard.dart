// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../minimalist_decoration_widget/minimalist_decoration_widget.dart';

typedef KeyboardTapCallback = void Function(String text);

class CustomNumericKeyboard extends StatefulWidget {
  /// Color of the text [default = Colors.black]
  final Color textColor;

  /// Display a custom right icon
  final Container? rightIcon;

  /// Action to trigger when right button is pressed
  final Function()? rightButtonFn;

  /// Display a custom left icon
  final Container? leftIcon;

  final Function()? leftButtonFn;
  double responsiveIConSize;
  double responsiveFSize;
  EdgeInsetsGeometry responsivePadding;

  final MainAxisAlignment mainAxisAlignment;

  CustomNumericKeyboard({
    Key? key,
    this.textColor = Colors.black,
    this.rightButtonFn,
    this.rightIcon,
    this.leftButtonFn,
    this.leftIcon,
    this.responsiveIConSize = 12,
    this.responsiveFSize = 12,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.responsivePadding = const EdgeInsets.all(2),
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomNumericKeyboardState();
  }

  void onKeyboardTap(int value) {
    // PDVLandscapeView.newUnit = PDVLandscapeView.newUnit * 10;
    // PDVLandscapeView.newUnit = value + PDVLandscapeView.newUnit;
  }
}

class _CustomNumericKeyboardState extends State<CustomNumericKeyboard> {
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    onKeyboardTap(int value) {}

    return Container(
      padding: widget.responsivePadding,
      child: Column(
        children: <Widget>[
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton(1),
              _calcButton(2),
              _calcButton(3),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton(4),
              _calcButton(5),
              _calcButton(6),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton(7),
              _calcButton(8),
              _calcButton(9),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              InkWell(
                  borderRadius: BorderRadius.circular(45),
                  onTap: widget.leftButtonFn,
                  child: Container(
                      alignment: Alignment.center,
                      width: widget.responsiveIConSize,
                      height: widget.responsiveIConSize,
                      child: widget.leftIcon)),
              _calcButton(0),
              InkWell(
                  borderRadius: BorderRadius.circular(45),
                  onTap: widget.rightButtonFn,
                  child: Container(
                      alignment: Alignment.center,
                      width: widget.responsiveIConSize,
                      height: widget.responsiveIConSize,
                      child: widget.rightIcon))
            ],
          ),
        ],
      ),
    );
  }

  void updateScreen() {
    setState(() {});
  }

  Widget _calcButton(int value) {
    return InkWell(
        onTap: () {
          widget.onKeyboardTap(value);
        },
        child: Container(
          alignment: Alignment.center,
          width: widget.responsiveIConSize,
          height: widget.responsiveIConSize,
          decoration: minimalistDecoration,
          child: FittedBox(
            child: Text(
              value.toString(),
              style: TextStyle(
                  fontSize: widget.responsiveFSize, color: widget.textColor),
            ),
          ),
        ));
  }
}
