import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurantapp/main.dart';

showInfoDialog({
  required String message,
  BuildContext? context,
  final Function()? customFunction,
}) {
  showDialog(
    context: context ?? navigatorKey.currentContext!,
    builder: (context) {
      return CupertinoAlertDialog(
        title: const Text("Info!"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              if (customFunction != null) {
                customFunction();
              } else {
                Navigator.of(context).pop();
              }
            },
            child: const Text(
              "OK",
            ),
          )
        ],
      );
    },
  );
}
