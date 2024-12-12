import 'dart:io';
import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter_base_project/core/enums/enums.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'image_widget_loading.dart';

// ignore: must_be_immutable
class ImageWidget extends StatelessWidget {
  const ImageWidget(
    this.urlImage, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.colorSvg,
    this.icon,
    this.color,
    this.blendModeSvg,
  });

  final String urlImage;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final IconData? icon;
  final Color? color;
  final Color? colorSvg;
  final BlendMode? blendModeSvg;

  ImageType _checkImageUrlType(String url) {
    if (nullOrEmpty(icon)) {
      return ImageType.ICON;
    }
    if (nullOrEmpty(url) && nullOrEmpty(icon)) {
      return ImageType.NOT_IMAGE;
    }
    if (url.endsWith(".svg") &&
        (url.startsWith('http') || url.startsWith('https'))) {
      return ImageType.SVG_HTTP;
    }
    if (url.endsWith(".svg")) {
      return ImageType.SVG;
    }
    if (url.startsWith('http') || url.startsWith('https')) {
      return ImageType.NETWORK;
    }
    if (url.startsWith('assets/')) {
      return ImageType.ASSET;
    }
    return ImageType.NOT_IMAGE;
  }

  Widget _imageTypeWidget(String urlImage, ImageType imageType) {
    if (imageType == ImageType.NETWORK) {
      return CachedNetworkImage(
        imageUrl: urlImage,
        fadeOutDuration: Duration.zero,
        fadeInDuration: Duration.zero,
        width: width,
        height: height,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        ),
        placeholder: (context, url) => ImageWidgetLoading(
          width: width,
          height: height,
        ),
        errorWidget: (context, url, error) => Image.asset(
          AppImages.placeHolder,
          fit: fit,
          height: height ?? SizeUtil.defaultSize,
          width: width ?? SizeUtil.defaultSize,
        ),
      );
    } else if (imageType == ImageType.ASSET) {
      return Image.asset(
        urlImage,
        fit: fit,
        height: height,
        width: width,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            AppImages.placeHolder,
            fit: fit,
            height: height ?? SizeUtil.defaultSize,
            width: width ?? SizeUtil.defaultSize,
          );
        },
      );
    } else if (imageType == ImageType.FILE) {
      return Image.file(
        File(urlImage),
        fit: fit,
        height: height,
        width: width,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            AppImages.placeHolder,
            fit: fit,
            height: height ?? SizeUtil.defaultSize,
            width: width ?? SizeUtil.defaultSize,
          );
        },
      );
    } else if (imageType == ImageType.ICON) {
      return SizedBox(
        height: height,
        width: width,
        child: Icon(
          icon,
          color: color,
          size: width ?? SizeUtil.defaultSize,
        ),
      );
    } else if (imageType == ImageType.SVG_HTTP) {
      return SvgPicture.network(
        urlImage,
        fit: fit!,
        height: height,
        width: width,
        placeholderBuilder: (BuildContext context) => ImageWidgetLoading(
          width: width,
          height: height,
        ),
      );
    } else if (imageType == ImageType.SVG_ASSET) {
      return SvgPicture.asset(
        urlImage,
        fit: fit!,
        height: height,
        width: width,
        colorFilter: ColorFilter.mode(
            colorSvg ?? Colors.white, blendModeSvg ?? BlendMode.srcIn),
        placeholderBuilder: (BuildContext context) => ImageWidgetLoading(
          width: width,
          height: height,
        ),
      );
    } else if (imageType == ImageType.SVG_FILE) {
      return Expanded(
        child: SvgPicture.file(
          File(urlImage),
          fit: fit!,
          height: height,
          width: width,
          placeholderBuilder: (BuildContext context) => ImageWidgetLoading(
            width: width,
            height: height,
          ),
        ),
      );
    } else if (imageType == ImageType.ICON) {
      return SizedBox(
        height: height,
        width: width,
        child: Icon(
          icon,
          color: color,
        ),
      );
    }

    if (imageType == ImageType.NOT_IMAGE) {
      return Image.asset(
        AppImages.placeHolder,
        fit: fit,
        height: height ?? SizeUtil.defaultSize,
        width: width ?? SizeUtil.defaultSize,
      );
    }

    return Container(
      width: SizeUtil.defaultSize,
      height: SizeUtil.defaultSize,
      color: Colors.white,
      child: Text('Image error'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageType = _checkImageUrlType(urlImage.toString());
    return _imageTypeWidget(urlImage.toString(), imageType);
  }
}
