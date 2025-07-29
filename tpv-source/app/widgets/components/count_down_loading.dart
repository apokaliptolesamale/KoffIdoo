// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';

class CountdownLoading extends StatefulWidget {
  final int? durationSeconds;
  final VoidCallback? onComplete;
  final Widget? child;
  const CountdownLoading({
    Key? key,
    this.durationSeconds,
    this.child,
    this.onComplete,
  }) : super(key: key);

  @override
  _CountdownLoadingState createState() => _CountdownLoadingState();
}

class _CountdownLoadingState extends State<CountdownLoading> {
  Timer? _timer;
  int _countdownSeconds = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (widget.child == null) ...[
          CircularProgressIndicator(),
          Text(
            '$_countdownSeconds',
            style: const TextStyle(fontSize: 32.0),
          ),
        ] else
          widget.child!
      ],
    );
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    if (widget.durationSeconds != null) {
      _countdownSeconds = widget.durationSeconds!;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _countdownSeconds--;
        });
        if (_countdownSeconds == 0) {
          widget.onComplete?.call();
          _timer!.cancel();
        }
      });
    }
  }
}
