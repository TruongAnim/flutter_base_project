import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'log_util.dart';

enum VideoEvent { play, pause, resume }

class LoadVideoService extends ChangeNotifier {
  List<String> videos = [
    'https://gcdn.dramashort.tv/videos/2ca569e35cc18ed5362b4d707f33d516/index.m3u8',
    'https://gcdn.dramashort.tv/videos/8f39f07c03b65461a5dfed9867c3165a/index.m3u8',
    'https://gcdn.dramashort.tv/videos/08bb4dab98c7657354c651fe487e2283/index.m3u8',
    'https://gcdn.dramashort.tv/videos/96f922da8695ae7e5291cd898c788431/index.m3u8',
    'https://gcdn.dramashort.tv/videos/ba58e64f12fcfabdfd28545d874733cb/index.m3u8',
    'https://gcdn.dramashort.tv/videos/7f8101c695afc499dd41f12a2bfce817/index.m3u8',
    'https://gcdn.dramashort.tv/videos/bbf56198d8bff70387591117ef4a69fe/index.m3u8',
    'https://gcdn.dramashort.tv/videos/ac0bf00a1c36943d843f3b28d072fd28/index.m3u8',
    'https://assets.mixkit.co/videos/preview/mixkit-different-types-of-fresh-fruit-in-presentation-video-42941-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-stunning-sunset-seen-from-the-sea-4119-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-meadow-surrounded-by-trees-on-a-sunny-afternoon-40647-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-fruit-texture-in-a-humid-environment-42958-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-close-up-shot-of-a-turntable-playing-a-record-42920-large.mp4',
  ];
  static const String tag = 'ShortVideoService';
  static const int maxCacheSize = 4;
  static const int initCacheSize = 2;
  static const int scrollDownPreloadSize = 2;
  static const int scrollUpPreloadSize = 1;
  final Map<int, VideoPlayerController> _cache = {};
  late StreamController<VideoPlayerValue> _playerValueStream;
  late StreamController<VideoEvent> _videoEventStream;
  int currentIndex = 0;
  bool previousPlaying = true;
  bool isHidden = false;
  bool isLoading = true;
  bool isPlaying = false;

  LoadVideoService() {
    for (final item in videos.take(3)) {
      loadVideo(videos.indexOf(item));
    }
    _playerValueStream = StreamController.broadcast();
    _videoEventStream = StreamController.broadcast();
  }

  void updateVideoSource(List<String> source) {
    videos = source;
    loadVideo(currentIndex + 1);
    loadVideo(currentIndex + 2);
  }

  void videoListener() {
    final value = getVideo().value;
    _playerValueStream.sink.add(value);
    if (isLoading && value.isInitialized) {
      isLoading = false;
      Future.delayed(Duration.zero, () {
        notifyListeners();
      });
    }
    if (!isPlaying && value.isPlaying) {
      isPlaying = true;
      Future.delayed(Duration.zero, () {
        notifyListeners();
      });
    }
  }

  int get currentCacheSize => _cache.length;

  Stream<VideoPlayerValue> get playerValueStream => _playerValueStream.stream;

  VideoPlayerController getVideo() {
    return _cache[currentIndex]!;
  }

  VideoPlayerController loadAndGet(int index) {
    if (!_cache.containsKey(index)) {
      loadVideo(index);
    }

    LogUtil.v('Get video $index', tag: tag);
    return _cache[index]!;
  }

  void loadVideo(int index) {
    if (_cache.containsKey(index)) {
      return;
    }
    LogUtil.v('Add video $index', tag: tag);
    VideoPlayerController controller = VideoPlayerController.networkUrl(
        Uri.parse(videos[index]),
        videoPlayerOptions: VideoPlayerOptions(
            allowBackgroundPlayback: false, mixWithOthers: false));
    controller.initialize();
    controller.setLooping(true);
    _cache[index] = controller;
  }

  void nextTo(int index) {
    LogUtil.v('NextTo video $index video size: ${videos.length}', tag: tag);
    preloadIncommingVideo(index);
    pauseAll();
    currentIndex = index;
    LogUtil.v('NextTo video $index video size: ${videos.length}', tag: tag);
    _cache[index]!.addListener(videoListener);
    _cache[index]!.play();
    isPlaying = true;
    _videoEventStream.sink.add(VideoEvent.play);
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

  void pauseAll() {
    LogUtil.v('PauseAll video', tag: tag);
    for (final controller in _cache.entries) {
      controller.value.pause();
      controller.value.removeListener(videoListener);
    }
  }

  void pause() {
    _cache[currentIndex]?.pause();
    isPlaying = false;
    _videoEventStream.sink.add(VideoEvent.pause);
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

  void resume() {
    _cache[currentIndex]?.play();
    isPlaying = true;
    notifyListeners();
  }

  void hidden() {
    isHidden = true;
  }

  void pauseByAppState() {
    // App mở từ background (hidden) thì đã pause rồi.
    // Pause lần nữa gây lỗi cho previousPlaying
    if (!isHidden) {
      previousPlaying = isPlaying;
      pause();
    }
  }

  void resumeByAppState() {
    if (previousPlaying) {
      resume();
    }
    isHidden = false;
  }

  void remove(int index) {
    if (_cache.containsKey(index)) {
      LogUtil.v('Remove video ${index}', tag: tag);
      _cache[index]?.dispose();
      _cache.remove(index);
    }
  }

  preloadIncommingVideo(int index) {
    for (final item in _cache.keys.toList()) {
      if (item < index - scrollUpPreloadSize ||
          item > index + scrollDownPreloadSize) {
        remove(item);
      }
    }
    for (int i = index - scrollUpPreloadSize;
        i <= index + scrollDownPreloadSize;
        i++) {
      if (i >= 0 && i < videos.length && i != index) {
        // Add time gap giữa mỗi lần load video
        // await Future.delayed(const Duration(milliseconds: 200));
        loadVideo(i);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    LogUtil.v('Dispose all', tag: tag);
    for (var controller in _cache.values) {
      controller.dispose();
    }
    _cache.clear();
    _playerValueStream.close();
    _videoEventStream.close();
  }
}
