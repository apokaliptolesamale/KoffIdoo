// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../app/widgets/menu/side_menu.dart';

class LargeScreen extends StatelessWidget {
  final Widget child;
  LargeScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: EnZonaSideMenu()),
        Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              // child: localNavigator(),
              child: child,
            )),
      ],
    );
  }
}
