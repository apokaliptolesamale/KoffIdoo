// ignore_for_file: unnecessary_null_comparison, prefer_conditional_assignment, unused_field

import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

import '../../core/services/file_loader_service.dart';

class RingtonePlayer {
  static final MethodChannel _channel =
      MethodChannel('xyz.luan/audioplayers_ringtone');

  Future<void> playRingtone({RingtoneType type = RingtoneType.ringtone}) async {
    if (Platform.isAndroid) {
      await _channel.invokeMethod("play", {"type": _getTypeAsString(type)});
    } else {
      throw Exception("RingtonePlayer is only supported on Android");
    }
  }

  String _getTypeAsString(RingtoneType type) {
    switch (type) {
      case RingtoneType.ringtone:
        return "ringtone";
      case RingtoneType.notification:
        return "notification";
      case RingtoneType.alarm:
        return "alarm";
      default:
        return "ringtone";
    }
  }
}

class RingTonePlayerService {
  static final RingTonePlayerService _instance = RingTonePlayerService._();
  final AudioPlayer _player = AudioPlayer();
  final ringtone = RingtonePlayer();
  final AudioCache _cache = AudioCache();
  RingTonePlayerService._();

  playSound(String fileName) {
    //ringtone.playRingtone(type: RingtoneType.notification);
    final service = FileLoaderService.getInstance;
    service.loadFromAsset(fileName).then((value) {
      _player.play(BytesSource(service.toUint8List(value)));
    });

    // await _cache.play('sound.mp3');
  }

  static RingTonePlayerService getInstance() => _instance;
}

//

enum RingtoneType {
  ringtone,
  notification,
  alarm,
}
