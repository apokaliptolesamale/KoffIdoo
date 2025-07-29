import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomScrollableWidget extends StatelessWidget {
  Widget child;
  CustomScrollableWidget({
    Key? key,
    required this.child,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: child,
        ),
      );
}
