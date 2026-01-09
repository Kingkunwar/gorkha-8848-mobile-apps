import 'package:restaurantapp/core/constants/app_constants.dart';
import 'package:restaurantapp/core/network/service_locator/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map<String, String> getHeader({bool requiresAuthorization = true}) {
  String? token =
      locator<SharedPreferences>().getString(AppConstants.bearerToken);

  return {
    "Content-Type": "application/json",
    "Accept": "application/json",
    if (token != null && requiresAuthorization)
      "Authorization": "Bearer $token",
  };
}
