import 'package:flutter/material.dart';
import 'package:flutter_base_project/core/global/di_container.dart';
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

  final LoadVideoService _videoService = appGlobal<LoadVideoService>();
  late PageController _pageController;
  late final List<FilmModel> videos;
  bool isPlaying = false;
  int _currentIndex = 0;
  VideoPlayerController? _currentController;

  @override
  void initState() {
    super.initState();
    videos = shortController.listFilm;
    _pageController = PageController();
    _loadCurrentVideo();
  }

  void videoListener() {
    print(
        'truong isPlaying $isPlaying ${_currentController!.value.isInitialized}');
    if (_currentController!.value.isInitialized && !isPlaying) {
      _currentController!.play();
      isPlaying = true;
      setState(() {});
      print('truong 1 ${_currentController!.value.duration}');
    }
  }

  Future<void> _loadCurrentVideo() async {
    _currentController =
        _videoService.loadVideo(videos[_currentIndex].episode?.link ?? '');
    _currentController!.addListener(videoListener);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      _currentController!.pause();
      isPlaying = false;
      _currentController!.removeListener(videoListener);
      _currentController =
          _videoService.loadVideo(videos[_currentIndex].episode?.link ?? '');
      _currentController!.addListener(videoListener);
      _currentController!.play();
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
