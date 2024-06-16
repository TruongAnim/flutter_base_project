import 'dart:async';

import 'package:just_audio/just_audio.dart';

class AudioService {
  late final AudioPlayer _player;

  AudioService() {
    _player = AudioPlayer();
  }

  AudioPlayer get player => _player;

  Future<void> setSource(String source) async {
    await _player.setAsset(source);
  }

  void setLoop(bool loop) {
    _player.setLoopMode(loop ? LoopMode.one : LoopMode.off);
  }

  void play() {
    _player.play();
  }

  void pause() {
    _player.pause();
  }

  void stop() {
    _player.stop();
  }
}
