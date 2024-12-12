import 'package:flutter/material.dart';

class ImageWidgetLoading extends StatelessWidget {
  final double? width;
  final double? height;

  const ImageWidgetLoading({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
