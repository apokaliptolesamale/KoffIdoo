import 'package:flutter/material.dart';

class WaterRipple extends StatefulWidget {
  @override
  _WaterRippleState createState() => _WaterRippleState();
}

class _WaterRipplePainter extends CustomPainter {
  final double waveRadius;

  _WaterRipplePainter({
    this.waveRadius = 1,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, waveRadius, paint);
    canvas.drawCircle(center, waveRadius - 10, paint);
    canvas.drawCircle(center, waveRadius - 20, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _WaterRippleState extends State<WaterRipple>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _waveRadius = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      child: CustomPaint(
        painter: _WaterRipplePainter(
          waveRadius: _waveRadius,
        ),
        child: Container(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          _waveRadius = 100 * _animation.value;
        });
      });
  }

  void _onTapDown(TapDownDetails details) {
    _waveRadius = 0;
    _controller.stop();
    _controller.reset();
    _controller.forward();
  }
}
