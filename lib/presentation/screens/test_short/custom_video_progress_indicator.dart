import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoProgressIndicator extends StatefulWidget {
  const CustomVideoProgressIndicator(
    this.controller, {
    super.key,
    this.colors = const VideoProgressColors(),
    this.padding = const EdgeInsets.only(top: 5.0),
  });

  final VideoPlayerController controller;

  final VideoProgressColors colors;

  final EdgeInsets padding;

  @override
  State<CustomVideoProgressIndicator> createState() =>
      _CustomVideoProgressIndicatorState();
}

class _CustomVideoProgressIndicatorState
    extends State<CustomVideoProgressIndicator> {
  _CustomVideoProgressIndicatorState() {
    listener = () {
      Future.delayed(Duration.zero, () {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    };
  }

  late VoidCallback listener;

  VideoPlayerController get controller => widget.controller;

  VideoProgressColors get colors => widget.colors;

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void deactivate() {
    controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Widget progressIndicator;
    if (controller.value.isInitialized) {
      final int duration = controller.value.duration.inMilliseconds;
      final int position = controller.value.position.inMilliseconds;

      int maxBuffering = 0;
      for (final DurationRange range in controller.value.buffered) {
        final int end = range.end.inMilliseconds;
        if (end > maxBuffering) {
          maxBuffering = end;
        }
      }

      progressIndicator = CustomSlider(
        value: position / duration,
        bufferedValue: maxBuffering / duration,
        playedColor: colors.playedColor,
        bufferedColor: colors.bufferedColor,
        backgroundColor: colors.backgroundColor,
        onChangeEnd: (value) {
          if (!controller.value.isInitialized) {
            return;
          }

          final position = controller.value.duration * value;
          controller.seekTo(position);
        },
      );
    } else {
      progressIndicator = LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(colors.playedColor),
        backgroundColor: colors.backgroundColor,
      );
    }
    final Widget paddedProgressIndicator = Padding(
      padding: widget.padding,
      child: progressIndicator,
    );

    return paddedProgressIndicator;
  }
}

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
    required this.bufferedColor,
    required this.playedColor,
    required this.backgroundColor,
    this.thumbRadius = 3.0,
    required this.value,
    required this.bufferedValue,
    this.trackHeight = 2.0,
    this.draggingTrackHeight = 6.0,
    this.onChanged,
    this.onChangeEnd,
  });

  final Color bufferedColor;

  final Color playedColor;

  final Color backgroundColor;

  final double thumbRadius;

  final double trackHeight;

  final double draggingTrackHeight;

  final double value;

  final double bufferedValue;

  final ValueChanged<double>? onChanged;

  final ValueChanged<double>? onChangeEnd;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double? _dragValue;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: widget.playedColor,
        inactiveTrackColor: Colors.transparent,
        trackHeight:
            _isDragging ? widget.draggingTrackHeight : widget.trackHeight,
        thumbShape: CustomSliderThumbShape(
          enabledThumbRadius: widget.thumbRadius,
          isDragging: _isDragging,
        ),
        thumbColor: widget.playedColor,
        trackShape: const CustomSliderTrackShape(),
        overlayShape: RoundSliderOverlayShape(
          overlayRadius: widget.thumbRadius + 4,
        ),
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: SizedBox(
              height:
                  _isDragging ? widget.draggingTrackHeight : widget.trackHeight,
              child: LinearProgressIndicator(
                value: widget.bufferedValue,
                valueColor: AlwaysStoppedAnimation<Color>(widget.bufferedColor),
                backgroundColor: widget.backgroundColor,
              ),
            ),
          ),
          Slider(
            value: _dragValue ?? widget.value,
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }

              if (widget.onChangeEnd == null) return;

              setState(() {
                _dragValue = value;
                _isDragging = true;
              });
            },
            onChangeEnd: (value) {
              if (widget.onChangeEnd == null) return;

              widget.onChangeEnd!(value);

              setState(() {
                _dragValue = null;
                _isDragging = false;
              });
            },
          ),
        ],
      ),
    );
  }
}

class CustomSliderTrackShape extends RoundedRectSliderTrackShape {
  const CustomSliderTrackShape();
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class CustomSliderThumbShape extends SliderComponentShape {
  const CustomSliderThumbShape({
    this.enabledThumbRadius = 10.0,
    required this.isDragging,
  });

  final double enabledThumbRadius;

  final bool isDragging;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(enabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Tween<double> radiusTween = Tween<double>(
      begin: enabledThumbRadius,
      end: enabledThumbRadius,
    );

    final double radius = radiusTween.evaluate(enableAnimation);

    final color = sliderTheme.thumbColor ?? Colors.white;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    if (isDragging) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: center, width: 8.0, height: 16.0),
          const Radius.circular(4.0),
        ),
        fillPaint,
      );
    } else {
      canvas.drawCircle(center, radius, fillPaint);
    }
  }
}
