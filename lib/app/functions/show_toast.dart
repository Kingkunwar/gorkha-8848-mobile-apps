import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(
  String message, {
  SnackBarAction? action,
}) {
  Fluttertoast.showToast(
    msg: message,
  );
}

showErrorToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.red,
  );
}

// SnackBarAction cartSnackBarAction() {
//   return SnackBarAction(
//     label: "Go to cart".toUpperCase(),
//     textColor: Colors.white,
//     onPressed: () {
//       pushNamed(
//         context: navigatorKey.currentContext!,
//         routeName: AppRoutes.cartScreen,
//       );
//     },
//   );
// }

extension SnackExtension on String {
  toSnackBar({SnackBarAction? action}) {
    return SnackBar(
      content: Row(
        children: [
          Text(
            this,
          ),
        ],
      ),
      action: action,
    );
  }
}
