import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ImageExtension on CachedNetworkImage {
  withPlaceHolder() {
    String cacheKey = imageUrl.split("?").first;
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      placeholder: (context, url) => Container(
        height: 90.w,
        width: 90.w,
        color: const Color(0xFFE3E1E1),
      ),
      fit: fit,
      cacheKey: cacheKey,
      errorWidget: (context, url, error) => Container(
        height: 90.w,
        width: 90.w,
        color: const Color(0xFFE3E1E1),
      ),
    );
  }
}
