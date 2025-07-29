import 'package:flutter/material.dart';

import 'clock.dart';
import 'count_down_loading.dart';

class ClockLoading extends StatelessWidget {
  final int? durationSeconds;
  final VoidCallback? onComplete;

  final double? width;
  final double? height;
  final Widget? textLoading;
  ClockLoading({
    Key? key,
    this.durationSeconds,
    this.textLoading,
    this.onComplete,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CountdownLoading(
      durationSeconds: durationSeconds,
      onComplete: onComplete,
      child: Column(
        children: [
          Clock(
            width: width ?? 50,
            height: height ?? 50,
          ),
          if (textLoading != null) textLoading!,
        ],
      ),
    );
  }
}
