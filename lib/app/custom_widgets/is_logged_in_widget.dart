import 'package:flutter/material.dart';
import 'package:restaurantapp/main.dart';

class IsLoggedInWidget extends StatelessWidget {
  final Widget child;
  final Widget? notLoggedInWidget;
  const IsLoggedInWidget({
    super.key,
    required this.child,
    this.notLoggedInWidget,
  });

  @override
  Widget build(BuildContext context) {
    return isLoggedIn() ? child : notLoggedInWidget ?? const SizedBox();
  }
}
