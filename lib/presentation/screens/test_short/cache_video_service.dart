import 'dart:async';

import 'package:video_player/video_player.dart';

class LoadVideoService {
  static const int maxCacheSize = 5;
  static const int initCacheSize = 3;
  late String currentUrl;
  final Map<String, VideoPlayerController> _cache = {};
  final Map<String, StreamController<String>> _stream = {};

  LoadVideoService();

  int get currentCacheSize => _cache.length;

  Stream<String> getStream(String url) {
    return _stream[url]!.stream;
  }

  VideoPlayerController getCurrent() {
    return _cache[currentUrl]!;
  }

  VideoPlayerController getVideo(String url) {
    currentUrl = url;
    if (!_cache.containsKey(url)) {
      addVideo(url);
    }
    return _cache[url]!;
  }

  void addVideo(String url) {
    if (_cache.containsKey(url)) {
      return;
    }
    print('truong add $url');
    StreamController<String> streamController = StreamController.broadcast();
    VideoPlayerController controller =
        VideoPlayerController.networkUrl(Uri.parse(url));
    controller.initialize();
    controller.setLooping(true);
    controller.addListener(() {
      streamController.sink.add(url);
    });
    _cache[url] = controller;
    _stream[url] = streamController;
  }

  void nextTo(String url) {
    if (!_cache.containsKey(url)) {
      return;
    }
    _cache[currentUrl]!.pause();
    _cache[url]!.play();
  }

  void remove(String url) {
    if (_cache.containsKey(url)) {
      print('truong remove $url');
      _cache[url]?.dispose();
      _cache.remove(url);
      _stream[url]?.close();
      _stream.remove(url);
    }
  }

  void dispose() {
    for (var controller in _cache.values) {
      controller.dispose();
    }
    _cache.clear();
  }
}
