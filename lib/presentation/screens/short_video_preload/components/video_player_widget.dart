import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String url;

  const VideoPlayerWidget({Key? key, required this.url}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    print('truong start');
    DateTime start = DateTime.now();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        DateTime end = DateTime.now();
        print(
            'truong init done ${(end.millisecondsSinceEpoch - start.millisecondsSinceEpoch)}');
        _controller.play();
        setState(() {});
      });

    // _chewieController = ChewieController(
    //   videoPlayerController: _controller,
    //   aspectRatio: _controller.value.aspectRatio,
    //   autoPlay: true,
    //   looping: true,
    // );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? VideoPlayer(_controller)
        : Center(child: CircularProgressIndicator());
  }
}
