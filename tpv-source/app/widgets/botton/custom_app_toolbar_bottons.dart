// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomAppTopBarButtons extends StatelessWidget {
  List<Widget>? buttons;

  CustomAppTopBarButtons({Key? key, this.buttons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: buttons ?? [],
    );
  }
}
