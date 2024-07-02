import 'package:flutter/material.dart';
import 'package:flutter_base_project/presentation/screens/test_short/custom_video_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'cache_video_service.dart';

class TestShortScreen extends StatelessWidget {
  const TestShortScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('ShortVideoService hello');
    return ChangeNotifierProvider(
      create: (_) => LoadVideoService(),
      builder: (context, child) {
        return VideoPageView();
      },
    );
  }
}

class VideoPageView extends StatefulWidget {
  const VideoPageView({super.key});

  @override
  _VideoPageViewState createState() => _VideoPageViewState();
}

class _VideoPageViewState extends State<VideoPageView>
    with WidgetsBindingObserver {
  late PageController _pageController;
  late LoadVideoService _videoService;

  @override
  void initState() {
    super.initState();
    _videoService = context.read<LoadVideoService>();
    _pageController = PageController();
    _videoService.nextTo(0);
    WidgetsBinding.instance.addObserver(this);
    _videoService.playerValueStream.listen((VideoPlayerValue v) {
      print(('truong ', v.isPlaying));
    });
  }

  void _onPageChanged(int index) {
    _videoService.nextTo(index);
  }

  @override
  void dispose() {
    print('truong dispose');
    _videoService.dispose();
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('AppLifecycleState: $state');
    // Handle app lifecycle changes here
    switch (state) {
      case AppLifecycleState.inactive:
        _videoService.pauseByAppState();
        print('App is inactive');
        break;
      case AppLifecycleState.paused:
        print('App is paused');
        break;
      case AppLifecycleState.resumed:
        _videoService.resumeByAppState();
        print('App is resumed');
        break;
      case AppLifecycleState.detached:
        print('App is detached');
        break;
      case AppLifecycleState.hidden:
        print('App is hidden');
        _videoService.hidden();
      // TODO: Handle this case.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoadVideoService>(
        builder: (context, service, _) => PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          onPageChanged: _onPageChanged,
          itemCount: service.videos.length,
          itemBuilder: (context, index) {
            return VideoPlayerWidget(index: index);
          },
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final int index;

  const VideoPlayerWidget({super.key, required this.index});

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
    return Consumer<LoadVideoService>(builder: (context, service, _) {
      if (service.currentIndex != widget.index) {
        return Center(child: CircularProgressIndicator());
      }
      if (service.isLoading) {
        return const Center(
          child: Text('Loading video'),
        );
      }
      print('truong rebuild');
      return Stack(
        children: [
          VideoPlayer(service.getVideo()),
          Positioned.fill(
            child: Center(
              child: GestureDetector(
                  onTap: () {
                    if (service.isPlaying) {
                      service.pause();
                    } else {
                      service.resume();
                    }
                  },
                  child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.white.withOpacity(0.2),
                      child: Icon(
                          service.isPlaying ? Icons.pause : Icons.play_arrow))),
            ),
          ),
          Positioned(
            bottom: 30,
            child: Container(
                width: 360,
                height: 20,
                child: CustomVideoProgressIndicator(service.getVideo())),
          ),
        ],
      );
    });
  }
}
