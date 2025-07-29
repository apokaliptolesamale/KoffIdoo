// ignore_for_file: prefer_final_fields, must_be_immutable, library_private_types_in_public_api, argument_type_not_assignable_to_error_handler, unused_field

//import 'package:audioplayers/src/audio_cache.dart';
import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '/app/core/config/assets.dart';
import '../../core/services/ring_tone_player_service.dart';
import '../event/event_notification.dart';

class BellWidget extends StatefulWidget {
  bool autoRing = false;
  bool autoRemove = false;
  Duration? duration;
  _BellWidgetState? _state;
  BellWidget({
    this.autoRing = false,
    this.autoRemove = false,
    this.duration,
  });
  _BellWidgetState get getState => _state ?? createState();
  @override
  _BellWidgetState createState() => _state = _BellWidgetState();

  ringRing() {
    if (getState.mounted) {
      getState.ringRing();
    }
  }
}

//

class _BellWidgetState extends State<BellWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorTween;
  late Animation<Offset> _positionTween;
  late EventStatus eventStatus;
  bool _showNotification = false;

  final AudioPlayer _player = AudioPlayer();
  final ringtone = RingtonePlayer();
  final AudioCache _cache = AudioCache();
  late StreamSubscription<dynamic> subscription;
  Color bellColor = Colors.white;

  afterBuild() {
    callback(_) {
      if (widget.autoRing) {
        ringRing();
      }
    }

    WidgetsBinding.instance.addPostFrameCallback(callback);
  }

  @override
  Widget build(BuildContext context) {
    eventStatus = EventStatus.of(context);

    if (!eventStatus.hasKey(widget.runtimeType)) {
      subscription = eventStatus.addScription(
        widget.runtimeType,
        (event) {
          onStatusChange((p0) {
            //  eventStatus.stopScription(widget.runtimeType);
            // eventStatus.close();
          }, event);
        },
      );
    }

    return GestureDetector(
      onTap: ringRing,
      child: SlideTransition(
        position: _positionTween,
        child: Icon(
          Icons.notifications,
          color: bellColor,
        ),
      ),
    );
  }

  @override
  void dispose() {
    //_controller.removeStatusListener((status) {});
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    afterBuild();
    _controller = AnimationController(
        vsync: this,
        duration: widget.duration ??
            const Duration(
              seconds: 3,
            ));
    _colorTween = ColorTween(
      begin: Colors.grey[200],
      end: Colors.red,
    ).animate(_controller);
    _positionTween =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.2, 0))
            .animate(
                CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
        setState(() {
          bellColor = Colors.white;
        });
        if (widget.autoRemove) {
          setState(() {
            Navigator.of(context).pop();
          });
          _controller.dispose();
        }
      }
      if (status == AnimationStatus.forward) {
        playSound();
        setState(() {
          bellColor = Colors.red;
        });
      }
    });
  }

  onStatusChange(
    void Function(dynamic) onData,
    dynamic data, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    ringRing();
    onData(data);
  }

  void playSound() async {
    RingTonePlayerService.getInstance().playSound(ASSETS_SOUNDS_PRISTINE_MP3);
  }

  ringRing() {
    setState(() {
      _showNotification = !_showNotification;
    });
    if (_showNotification) {
      showNotification();
      _controller.forward(); // Activa la animación de cambio de color
    }
  }

  void showNotification() {
    _controller.forward();
  }
}
