import 'package:flutter/material.dart';

class ButtonFromLeftDownRight extends StatelessWidget {
  final text;
  const ButtonFromLeftDownRight({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
