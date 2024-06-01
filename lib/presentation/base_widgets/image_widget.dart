import 'dart:io';
import 'package:flutter_base_project/constants/exports.dart';
import 'package:flutter_base_project/core/enums/enums.dart';
import 'package:flutter_base_project/core/helper/exports.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'image_widget_loading.dart';

// ignore: must_be_immutable
class ImageWidget extends StatelessWidget {
  ImageWidget(
    String this.urlImage, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.colorIconsSvg,
  });

  ImageWidget.file(
    this.file, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  ImageWidget.icon(
    IconData this.icon, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color = AppColors.OUTER_SPACE,
    this.size,
  });

  String? urlImage;
  final double? width;
  final double? height;
  final BoxFit? fit;
  File? file;
  IconData? icon;
  Color? color;
  Color? colorIconsSvg;
  double? size;

  ImageType checkImageType(String url) {
    if (nullOrEmpty(url) && nullOrEmpty(file) && nullOrEmpty(icon)) {
      return ImageType.NOT_IMAGE;
    }
    if (url.endsWith(".svg")) {
      return ImageType.SVG;
    }
    return ImageType.IMAGE;
  }

  ImageUrlType checkImageUrlType(String url) {
    if (nullOrEmpty(url)) {
      if (icon != null) {
        return ImageUrlType.ICON;
      }
      return ImageUrlType.FILE;
    }
    if (url.startsWith('http') || url.startsWith('https')) {
      return ImageUrlType.NETWORK;
    } else if (url.startsWith('assets/')) {
      return ImageUrlType.ASSET;
    } else if (icon != null) {
      if (icon!.fontFamily
              .toString()
              .toLowerCase()
              .contains('CupertinoIcons'.toLowerCase()) ||
          icon!.fontFamily
              .toString()
              .toLowerCase()
              .contains('MaterialIcons'.toLowerCase())) {
        return ImageUrlType.ICON;
      }
      return ImageUrlType.FILE;
    }
    return ImageUrlType.FILE;
  }

  Widget imageTypeWidget(String urlImage, ImageType imageType,
      ImageUrlType imageUrlType, double devicePexelRatio) {
    if (imageType == ImageType.IMAGE) {
      if (imageUrlType == ImageUrlType.NETWORK) {
        return CachedNetworkImage(
          imageUrl: urlImage,
          fadeOutDuration: Duration.zero,
          fadeInDuration: Duration.zero,
          width: width,
          height: height,
          // memCacheHeight: (height ?? 1 * devicePexelRatio/2).round(),
          // memCacheWidth: (width ?? 1 * devicePexelRatio/2).round(),
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
            height: height ?? 0.1.sh,
            width: width ?? 0.1.sh,
          ),
        );
      } else if (imageUrlType == ImageUrlType.ASSET) {
        return Image.asset(
          urlImage,
          fit: fit,
          height: height,
          width: width,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              AppImages.placeHolder,
              fit: fit,
              height: height ?? 0.1.sh,
              width: width ?? 0.1.sh,
            );
          },
        );
      } else if (imageUrlType == ImageUrlType.FILE) {
        return Image.file(
          file!,
          fit: fit,
          height: height,
          width: width,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              AppImages.placeHolder,
              fit: fit,
              height: height ?? 0.1.sh,
              width: width ?? 0.1.sh,
            );
          },
        );
      } else if (imageUrlType == ImageUrlType.ICON) {
        return SizedBox(
          height: height,
          width: width,
          child: Icon(
            icon,
            color: color,
            size: size ?? 0.08.sh,
          ),
        );
      }
    }

    if (imageType == ImageType.SVG) {
      if (imageUrlType == ImageUrlType.NETWORK) {
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
      } else if (imageUrlType == ImageUrlType.ASSET) {
        return SvgPicture.asset(
          urlImage,
          fit: fit!,
          height: height,
          width: width,
          color: colorIconsSvg,
          placeholderBuilder: (BuildContext context) => ImageWidgetLoading(
            width: width,
            height: height,
          ),
        );
      } else if (imageUrlType == ImageUrlType.FILE) {
        return Expanded(
          child: SvgPicture.file(
            file!,
            fit: fit!,
            height: height,
            width: width,
            placeholderBuilder: (BuildContext context) => ImageWidgetLoading(
              width: width,
              height: height,
            ),
          ),
        );
      } else if (imageUrlType == ImageUrlType.ICON) {
        return SizedBox(
          height: height,
          width: width,
          child: Icon(
            icon,
            color: color,
          ),
        );
      }
    }

    if (imageType == ImageType.NOT_IMAGE) {
      return Image.asset(
        AppImages.placeHolder,
        fit: fit,
        height: height ?? 0.1.sh,
        width: width ?? 0.1.sh,
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final imageType = checkImageType(urlImage.toString());
    final imageUrlType = checkImageUrlType(urlImage.toString());
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    return imageTypeWidget(
      urlImage.toString(),
      imageType,
      imageUrlType,
      devicePixelRatio,
    );
  }
}
