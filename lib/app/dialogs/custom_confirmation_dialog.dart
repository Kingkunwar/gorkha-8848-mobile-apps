import 'package:flutter/material.dart';
import 'package:restaurantapp/main.dart';

Future<bool> getConfirmationDialog({
  BuildContext? context,
  required String title,
}) async {
  return await showDialog(
    context: context ?? navigatorKey.currentContext!,
    builder: (context) {
      return AlertDialog(
        surfaceTintColor: Colors.grey,
        title: Text(
          "Are you sure?",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        content: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: <Widget>[
          MaterialButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          MaterialButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  ).then(
    (value) => value ?? false,
  );
}
