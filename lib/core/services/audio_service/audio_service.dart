import 'dart:async';

import 'package:flutter_base_project/constants/app_audio_source.dart';
import 'package:just_audio/just_audio.dart';

class AudioService {
  final List<String> clickerSounds = [AppAudioSource.clicker_01];
  final player = AudioPlayer();
  StreamController<ProcessingState> processingState =
      StreamController<ProcessingState>.broadcast();
  bool isPlaying = false;

  AudioService() {
    player.playerStateStream.listen((state) {
      processingState.sink.add(state.processingState);
    });
  }

  Future<void> setSource(String source) async {
    isPlaying = false;
    await player.setAsset(source);
  }

  void setLoop(bool loop) {
    player.setLoopMode(loop ? LoopMode.one : LoopMode.off);
  }

  void play() {
    player.play();
  }

  void pause() {
    player.pause();
  }

  void stop() {
    player.stop();
  }
}
