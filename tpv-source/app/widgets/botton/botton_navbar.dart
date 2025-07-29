// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ButtonNavBar extends StatefulWidget {
  BoxDecoration? decoration;
  Icon icon;
  GestureTapCallback onTap;
  final String id;

  late State<ButtonNavBar> _state;

  ButtonNavBar({
    Key? key,
    required this.id,
    required this.icon,
    required this.onTap,
    this.decoration,
  }) : super(key: key);

  State<ButtonNavBar> get getState => _state;

  @override
  State<ButtonNavBar> createState() => _state = _ButtonNavBarState();
}

class _ButtonNavBarState extends State<ButtonNavBar> {
  bool isOver = false;

  Color _colorContainer = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildContainerDecoration(),
      child: Stack(
        children: [
          InkWell(
            onTap: widget.onTap,
            onHover: onHover,
            child: widget.icon,
          ),
          Positioned(
            left: 2,
            child: Container(
              width: 5,
              height: 5,
              decoration: widget.decoration ?? _buildBoxDecoration(),
            ),
          )
        ],
      ),
    );
  }

  onHover(value) {
    isOver = value;
    setState(() => _colorContainer =
        !isOver ? Colors.transparent : widget.icon.color!.withOpacity(0.1));
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8),
        ],
      );

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: _colorContainer,
      borderRadius: BorderRadius.circular(100),
      /*boxShadow: [
        BoxShadow(color: Colors.transparent, blurRadius: 5),
      ],*/
    );
  }
}
