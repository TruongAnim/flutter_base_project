import 'package:flutter/material.dart';
import 'package:flutter_base_project/data/models/film_model.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'cache_video_service.dart';
import 'short_video_cache_controller.dart';

class VideoPageView extends StatefulWidget {
  @override
  _VideoPageViewState createState() => _VideoPageViewState();
}

class _VideoPageViewState extends State<VideoPageView> {
  ShortVideoCacheController shortController =
      Get.find<ShortVideoCacheController>();

  final LoadVideoService _videoService = LoadVideoService();
  late PageController _pageController;
  late final List<FilmModel> videos;
  int _currentIndex = 0;
  VideoPlayerController? _currentController;
  VideoPlayerController? _nextController;

  @override
  void initState() {
    super.initState();
    videos = shortController.listFilm;
    _pageController = PageController();
    _loadCurrentVideo();
    _preloadNextVideo();
  }

  Future<void> _loadCurrentVideo() async {
    _currentController = await _videoService
        .loadVideo(videos[_currentIndex].episode?.link ?? '');
    setState(() {});
  }

  Future<void> _preloadNextVideo() async {
    if (_currentIndex + 1 < videos.length) {
      _nextController = await _videoService
          .loadVideo(videos[_currentIndex + 1].episode?.link ?? '');
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      _currentController = _nextController;
    });
    _preloadNextVideo();
  }

  @override
  void dispose() {
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
            return _currentController != null
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
