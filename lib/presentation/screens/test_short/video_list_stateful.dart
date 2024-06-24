import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'cache_video_service.dart';

class VideoPageView extends StatefulWidget {
  @override
  _VideoPageViewState createState() => _VideoPageViewState();
}

class _VideoPageViewState extends State<VideoPageView> {
  late PageController _pageController;
  late final List<String> videos = [
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
  final LoadVideoService _videoService = LoadVideoService();
  bool isPlaying = false;
  int _currentIndex = 0;
  VideoPlayerController? _currentController;

  @override
  void initState() {
    super.initState();
    for (final item in videos.take(3)) {
      _videoService.addVideo(item);
    }
    _pageController = PageController();
    _loadCurrentVideo();
  }

  void videoListener() {
    print(
        'truong isPlaying $isPlaying ${_currentController!.value.isInitialized}');
    if (_currentController!.value.isInitialized && !isPlaying) {
      isPlaying = true;
      setState(() {});
      print('truong 1 ${_currentController!.value.duration}');
    }
  }

  Future<void> _loadCurrentVideo() async {
    _currentController = _videoService.getVideo(videos[_currentIndex]);
    _videoService.getStream(videos[_currentIndex]).listen((i) {
      print('truong event $i');
      videoListener();
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      _videoService.nextTo(videos[index]);
      _currentController = _videoService.getVideo(videos[_currentIndex]);
      _videoService.getStream(videos[_currentIndex]).listen((i) {
        print('truong event 2 $i');
        videoListener();
      });
      setState(() {});
      print('truong 2 ${_currentController!.value.duration}');
    });
  }

  @override
  void dispose() {
    print('truong dispose');
    _videoService.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: _onPageChanged,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          if (index == _currentIndex) {
            return _currentController != null && isPlaying
                ? VideoPlayerWidget(controller: _currentController!)
                : Center(child: CircularProgressIndicator());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController controller;

  const VideoPlayerWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.controller.value.isInitialized
        ? VideoPlayer(widget.controller)
        : Center(child: CircularProgressIndicator());
  }
}
