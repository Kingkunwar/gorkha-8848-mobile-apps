import 'package:restaurantapp/core/constants/app_constants.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? getUserEmail() {
  return locator<SharedPreferences>().getString(AppConstants.userEmail);
}
