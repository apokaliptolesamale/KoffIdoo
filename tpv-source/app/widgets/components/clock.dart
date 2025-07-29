// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  final double? width;
  final double? height;
  Clock({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockPainter extends CustomPainter {
  final double centerX;
  final double centerY;
  final double radius;
  final double strokeWidth;
  final double secondHandLength;
  final double minuteHandLength;
  final double hourHandLength;
  final double secondRadians;
  final double minuteRadians;
  final double hourRadians;

  _ClockPainter({
    required this.centerX,
    required this.centerY,
    required this.radius,
    required this.strokeWidth,
    required this.secondHandLength,
    required this.minuteHandLength,
    required this.hourHandLength,
    required this.secondRadians,
    required this.minuteRadians,
    required this.hourRadians,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      Offset(centerX, centerY),
      radius,
      paint,
    );

    final double secondHandX =
        centerX + secondHandLength * math.sin(secondRadians);
    final double secondHandY =
        centerY - secondHandLength * math.cos(secondRadians);
    final double minuteHandX =
        centerX + minuteHandLength * math.sin(minuteRadians);
    final double minuteHandY =
        centerY - minuteHandLength * math.cos(minuteRadians);
    final double hourHandX = centerX + hourHandLength * math.sin(hourRadians);
    final double hourHandY = centerY - hourHandLength * math.cos(hourRadians);

    final secondHandPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = strokeWidth / 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(centerX, centerY),
      Offset(secondHandX, secondHandY),
      secondHandPaint,
    );

    final minuteHandPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(centerX, centerY),
      Offset(minuteHandX, minuteHandY),
      minuteHandPaint,
    );

    final hourHandPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = strokeWidth * 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(centerX, centerY),
      Offset(hourHandX, hourHandY),
      hourHandPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _ClockState extends State<Clock> {
  late Timer _timer;
  double? _width;
  double? _height;

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.now();
    final double width = _width ?? MediaQuery.of(context).size.width;
    final double height = _height ?? MediaQuery.of(context).size.height;
    final double size = math.min(width, height) * 0.8;
    final double centerX = width / 2;
    final double centerY = height / 2;
    final double radius = size / 2;
    final double strokeWidth = size / 20;
    final double secondHandLength = radius * 0.9;
    final double minuteHandLength = radius * 0.8;
    final double hourHandLength = radius * 0.6;
    final double secondRadians = dateTime.second * math.pi / 30;
    final double minuteRadians =
        (dateTime.minute * 60 + dateTime.second) * math.pi / 360;
    final double hourRadians =
        (dateTime.hour * 3600 + dateTime.minute * 60 + dateTime.second) *
            math.pi /
            21600;

    return Container(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _ClockPainter(
          centerX: centerX,
          centerY: centerY,
          radius: radius,
          strokeWidth: strokeWidth,
          secondHandLength: secondHandLength,
          minuteHandLength: minuteHandLength,
          hourHandLength: hourHandLength,
          secondRadians: secondRadians,
          minuteRadians: minuteRadians,
          hourRadians: hourRadians,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _width = widget.width;
    _height = widget.height;
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
    });
  }
}
