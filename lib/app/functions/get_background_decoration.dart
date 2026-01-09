import 'package:flutter/material.dart';
import 'package:restaurantapp/core/constants/asset_source.dart';

getBackgroundDecoration() {
  return const BoxDecoration(
    image: DecorationImage(
      image: AssetImage(AssetSource.backgroundImage),
      fit: BoxFit.cover,
    ),
  );
}
