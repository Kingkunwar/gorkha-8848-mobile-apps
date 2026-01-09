import 'package:flutter/services.dart';
import 'package:restaurantapp/app/dialogs/custom_confirmation_dialog.dart';

appExitAlert() async {
  final bool confirmation = await getConfirmationDialog(
    title: "Do you want to exit the app ?",
  );
  if (confirmation) {
    SystemNavigator.pop();
    return true;
  } else {
    return false;
  }
}
