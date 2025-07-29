// ignore_for_file: must_be_immutable, unused_field

import 'package:flutter/material.dart';

class ShortCut extends StatefulWidget {
  late String _text;
  void Function()? _onPressed;
  late Widget _icon;
  EdgeInsets? _margin;
  double? _width, _height;
  Color? _color;

  ShortCut({
    required String text,
    required Widget icon,
    double? width,
    double? height,
    Color? color,
    EdgeInsets? margin,
    void Function()? onPressed,
    Key? key,
  }) : super(key: key) {
    _text = text;
    _icon = icon;
    _width = width;
    _height = height;
    _color = color;
    _onPressed = onPressed;
    _margin = margin;
  }

  @override
  State<ShortCut> createState() => _ShortCutState();
}

class _ShortCutState extends State<ShortCut> {
  late String _text;
  void Function()? _onPressed;
  late Widget _icon;
  EdgeInsets? _margin;
  double? _width, _height;
  Color? _color;

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      height: _height,
      width: _width,
      child: Container(
        height: _height,
        width: _width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: _onPressed,
          child: Container(
            child: _icon,
          ),
        ),
      ) /*Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: size.height,
            width: size.width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: onPressed,
              child: Container(
                child: icon,
              ),
            ),
          ),
          Text(
            text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      )*/
      ,
    );
  }

  @override
  void initState() {
    _text = widget._text;
    _onPressed = widget._onPressed;
    _icon = widget._icon;
    _color = widget._color;
    _height = widget._height;
    _margin = widget._margin;
    _width = widget._width;
    super.initState();
  }
}
