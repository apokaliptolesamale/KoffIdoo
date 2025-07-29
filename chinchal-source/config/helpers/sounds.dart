import 'package:audioplayers/audioplayers.dart';

Future<void> play(AudioPlayer player) async {
  await player.resume();
}

Future<void> pause(AudioPlayer player) async {
  await player.pause();
}

Future<void> stop(AudioPlayer player) async {
  await player.stop();
}
