import 'package:flutter/material.dart';

class FondoAzul extends StatelessWidget {
  const FondoAzul({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.lightBlueAccent, Colors.white70],
          begin: AlignmentDirectional.topCenter,
          end: AlignmentDirectional.bottomCenter,
        ),
      ),
      height: MediaQuery.sizeOf(context).height,
      width: double.infinity,
    );
  }
}