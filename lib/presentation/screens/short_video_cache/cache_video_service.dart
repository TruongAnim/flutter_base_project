import 'package:video_player/video_player.dart';

class LoadVideoService {
  final int maxCacheSize;
  final Map<String, VideoPlayerController> _cache = {};

  LoadVideoService({this.maxCacheSize = 5});

  VideoPlayerController loadVideo(String url) {
    print('truong load ${url}');
    print('truong check 1 ${_cache.containsKey(url)}');
    if (_cache.containsKey(url)) {
      return _cache[url]!;
    }

    VideoPlayerController controller =
        VideoPlayerController.networkUrl(Uri.parse(url));
    print('truong inti ${url}');
    controller.initialize();
    _cache[url] = controller;
    print('truong check 2 ${_cache.containsKey(url)}');
    return controller;
  }

  void dispose() {
    print('truong dispose');
    for (var controller in _cache.values) {
      controller.dispose();
    }
    _cache.clear();
  }
}
