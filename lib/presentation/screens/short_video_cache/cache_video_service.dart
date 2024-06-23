import 'package:video_player/video_player.dart';

class LoadVideoService {
  final int maxCacheSize;
  final Map<String, VideoPlayerController> _cache = {};
  final List<String> _cacheOrder = [];

  LoadVideoService({this.maxCacheSize = 3});

  Future<VideoPlayerController> loadVideo(String url) async {
    if (_cache.containsKey(url)) {
      _cacheOrder.remove(url);
      _cacheOrder.add(url);
      return _cache[url]!;
    }

    if (_cache.length >= maxCacheSize) {
      String oldestUrl = _cacheOrder.removeAt(0);
      _cache[oldestUrl]!.dispose();
      _cache.remove(oldestUrl);
    }

    VideoPlayerController controller =
        VideoPlayerController.networkUrl(Uri.parse(url));
    await controller.initialize();
    _cache[url] = controller;
    _cacheOrder.add(url);

    return controller;
  }

  void dispose() {
    for (var controller in _cache.values) {
      controller.dispose();
    }
    _cache.clear();
    _cacheOrder.clear();
  }
}
