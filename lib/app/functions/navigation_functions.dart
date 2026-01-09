import 'package:flutter/material.dart';
import 'package:restaurantapp/main.dart';

popPage({BuildContext? context}) {
  Navigator.of(context ?? navigatorKey.currentContext!).pop();
}

pushNamed({
  required BuildContext context,
  required String routeName,
  Object? arguments,
}) {
  Navigator.of(context).pushNamed(
    routeName,
    arguments: arguments,
  );
}

pushAndRemoveUntil(
    {BuildContext? context, required String routeName, Object? arguments}) {
  Navigator.of(
    context ?? navigatorKey.currentContext!,
  ).pushNamedAndRemoveUntil(
    routeName,
    (route) => false,
    arguments: arguments,
  );
}
