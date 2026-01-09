import 'package:flutter/material.dart';
import 'package:restaurantapp/app/custom_widgets/custom_circular_progress_indicator.dart';
import 'package:restaurantapp/main.dart';

showLoadingDialog() {
  showDialog(
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    context: navigatorKey.currentContext!,
    builder: (appContext) {
      return Material(
        color: Colors.grey.withOpacity(0.4),
        child: const SizedBox(
          height: 150,
          child: Center(
            child: CustomCircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}

hideLoadingDialog() {
  Navigator.of(navigatorKey.currentContext!).pop();
}
