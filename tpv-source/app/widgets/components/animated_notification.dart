// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomAnimatedNotification extends StatefulWidget {
  final String message;
  final double offsetX;
  final double offsetY;
  final Alignment alignment;
  final Duration duration;
  final Widget? icon;
  final bool autoRemove;
  CustomAnimatedNotification({
    Key? key,
    required this.message,
    this.icon,
    this.autoRemove = true,
    this.offsetX = 0,
    this.offsetY = 0,
    this.alignment = Alignment.center,
    this.duration = const Duration(seconds: 2),
  }) : super(key: key);

  @override
  _CustomAnimatedNotificationState createState() =>
      _CustomAnimatedNotificationState();
}

class CustomAnimatedNotificationSingleton {
  static final CustomAnimatedNotificationSingleton _singleton =
      CustomAnimatedNotificationSingleton._internal();

  factory CustomAnimatedNotificationSingleton() {
    return _singleton;
  }

  CustomAnimatedNotificationSingleton._internal();

  CustomAnimatedNotification create({
    required String message,
    Widget? icon,
    double offsetX = 0,
    double offsetY = 0,
    Alignment alignment = Alignment.center,
    Duration duration = const Duration(seconds: 2),
    bool autoRemove = true,
  }) {
    return CustomAnimatedNotification(
      message: message,
      icon: icon,
      offsetX: offsetX,
      offsetY: offsetY,
      alignment: alignment,
      duration: duration,
      autoRemove: autoRemove,
      key: UniqueKey(),
    );
  }
}

class _CustomAnimatedNotificationState extends State<CustomAnimatedNotification>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  bool _showNotification = false;
  bool _wasCalled = false;
  bool _hideIcon = false;
  String _notificationText = '';
  Timer? _notificationTimer;
  late Animation<double> _animation;
  late AnimationStatus status;
  late FrameCallback _callback;
  //
  void afterBuild(BuildContext context, String msg) {
    _notificationText = msg;
    if (!_wasCalled) {
      _wasCalled = true;
      show(
        context,
        _notificationText,
        widget.duration,
        () {
          setState(() {
            _showNotification = false;
            _wasCalled = true;
            _hideIcon = true;
          });
        },
      );
      WidgetsBinding.instance.scheduleForcedFrame();
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    _callback = (_) {
      afterBuild(context, widget.message);
    };
    WidgetsBinding.instance.addPostFrameCallback(_callback);
    return Positioned(
      top: widget.alignment == Alignment.topCenter ||
              widget.alignment == Alignment.topLeft ||
              widget.alignment == Alignment.topRight
          ? 0 + widget.offsetY
          : null,
      bottom: widget.alignment == Alignment.bottomCenter ||
              widget.alignment == Alignment.bottomLeft ||
              widget.alignment == Alignment.bottomRight
          ? 0 + widget.offsetY
          : null,
      left: widget.alignment == Alignment.topLeft ||
              widget.alignment == Alignment.centerLeft ||
              widget.alignment == Alignment.bottomLeft
          ? 0 + widget.offsetX
          : null,
      right: widget.alignment == Alignment.topRight ||
              widget.alignment == Alignment.centerRight ||
              widget.alignment == Alignment.bottomRight
          ? 0 + widget.offsetX
          : null,
      child: FadeTransition(
        opacity: _animation,
        child: AnimatedContainer(
          duration: widget.duration,
          width: MediaQuery.of(context).size.width,
          height: _showNotification ? kToolbarHeight : 0,
          alignment: widget.alignment,
          color: Colors.blue,
          child: Material(
            elevation: 4,
            textStyle: theme.textTheme.bodyMedium,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(children: [
                  if (!_hideIcon)
                    Container(
                      margin: EdgeInsets.all(5),
                      child: widget.icon ??
                          Icon(
                            Icons.check,
                          ),
                    ),
                  Text(
                    widget.message,
                    style: theme.textTheme.bodySmall,
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.removeListener(_onAnimationEnd);
      _controller!.dispose();
      _controller = null;
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _hideIcon = false;
    _notificationText = widget.message;
    _callback = (_) {
      afterBuild(context, widget.message);
    };
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    ));

    // Iniciar la animación al momento de crear el widget
    status = AnimationStatus.reverse;
    _controller!.forward();

    // Detener la animación y liberar recursos cuando se destruye el widget
    _controller!.addStatusListener((_) {
      _onAnimationEnd();
    });
  }

  void show(BuildContext context, String notificationText, Duration duration,
      VoidCallback onDismissed) {
    setState(() {
      _showNotification = true;
      _notificationText = notificationText;
      _hideIcon = false;
    });

    _notificationTimer = Timer(duration, () {
      setState(() {
        _showNotification = false;
        _hideIcon = true;
      });
      onDismissed();
    });
  }

  void _onAnimationEnd() {
    if (status == AnimationStatus.completed) {
      if (widget.autoRemove) {
        setState(() {
          Navigator.of(context).pop();
        });
        _controller!.dispose();
      } else {
        _controller!.reverse();
      }
    } else if (status == AnimationStatus.dismissed) {
      _controller!.dispose();
    }
  }
}
