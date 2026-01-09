import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurantapp/core/constants/asset_source.dart';

extension ImageExtension on CachedNetworkImage {
  withPlaceHolder() {
    String cacheKey = imageUrl.split("?").first;
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      placeholder: (context, url) => Image.asset(
        AssetSource.backgroundImage,
      ),
      fit: fit,
      cacheKey: cacheKey,
      errorWidget: (context, url, error) => Image.asset(
        AssetSource.backgroundImage,
      ),
    );
  }
}
