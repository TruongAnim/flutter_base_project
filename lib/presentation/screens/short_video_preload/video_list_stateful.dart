import 'package:flutter/material.dart';
import 'short_video_preload_controller.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPageView extends StatefulWidget {
  @override
  _VideoPageViewState createState() => _VideoPageViewState();
}

class _VideoPageViewState extends State<VideoPageView> {
  ShortVideoPreloadController shortController =
      Get.find<ShortVideoPreloadController>();

  late PageController _pageController;
  int _currentIndex = 0;

  VideoPlayerController? _currentController;
  VideoPlayerController? _nextController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadController(_currentIndex).then((controller) {
      setState(() {
        _currentController = controller;
      });
    });
    _preloadNextVideo();
  }

  Future<VideoPlayerController> _loadController(int index) async {
    VideoPlayerController controller = VideoPlayerController.networkUrl(
        Uri.parse(shortController.listFilm[index].episode?.link ?? ''));
    await controller.initialize();
    return controller;
  }

  void _preloadNextVideo() {
    if (_currentIndex + 1 < shortController.listFilm.length) {
      _loadController(_currentIndex + 1).then((controller) {
        _nextController?.dispose();
        _nextController = controller;
      });
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      _currentController?.dispose();
      _currentController = _nextController;
      _nextController = null;
    });
    _preloadNextVideo();
  }

  @override
  void dispose() {
    _currentController?.dispose();
    _nextController?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: _onPageChanged,
      itemCount: shortController.listFilm.length,
      itemBuilder: (context, index) {
        if (index == _currentIndex) {
          return _currentController != null
              ? VideoPlayerWidget(controller: _currentController!)
              : Center(child: CircularProgressIndicator());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
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
    widget.controller.play();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.controller.value.isInitialized
        ? VideoPlayer(widget.controller)
        : Center(child: CircularProgressIndicator());
  }
}
