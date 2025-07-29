// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';

class CustomItemCounter extends StatefulWidget {
  Widget icon;
  String value;
  TextStyle textStyle;
  EdgeInsets padding;
  EdgeInsets margin;
  Color bgColor;
  Duration duration;
  double beginFontSize;
  double endFontSize;

  _CustomItemCounterState? _state;
  CustomItemCounter({
    Key? key,
    this.value = "",
    this.icon = const Icon(
      Icons.shopping_bag,
      color: Color(0xFF00b1a4),
    ),
    this.textStyle = const TextStyle(color: Colors.white),
    this.padding = const EdgeInsets.all(1),
    this.margin = const EdgeInsets.all(1),
    this.bgColor = Colors.transparent,
    this.duration = const Duration(milliseconds: 800),
    this.beginFontSize = 12,
    this.endFontSize = 24,
  }) : super(key: key) {
    _state = _CustomItemCounterState();
  }

  _CustomItemCounterState get getState => createState();

  @override
  _CustomItemCounterState createState() => _state ?? _CustomItemCounterState();

  setValue(String newValue) {
    value = newValue;
  }

  start() {
    if (getState.mounted) getState.increaseFontSize();
  }
}

class _CustomItemCounterState extends State<CustomItemCounter>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  double fontSize = 12;
  FontWeight fontWeight = FontWeight.normal;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          widget.icon,
          Container(
            padding: widget.padding,
            child: Text(
              widget.value,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.white,
                fontWeight: fontWeight,
              ),
            ),
          )
        ],
      ),
      color: widget.bgColor,
      margin: widget.margin,
    );
  }

  void descreaseFontSize() {
    controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void increaseFontSize() {
    controller.forward();
  }

  @override
  void initState() {
    super.initState();
    fontSize = widget.beginFontSize;
    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    animation =
        Tween<double>(begin: widget.beginFontSize, end: widget.endFontSize)
            .animate(controller)
          ..addListener(onAnimated);
  }

  onAnimated() {
    if (animation.value == widget.endFontSize) {
      descreaseFontSize();
    }
    setState(() {
      fontSize = animation.value;
      updateFont();
    });
  }

  updateFont() {
    if (fontSize < (widget.endFontSize - widget.beginFontSize) / 2) {
      fontWeight = FontWeight.bold;
    } else {
      fontWeight = FontWeight.normal;
    }
  }
}
