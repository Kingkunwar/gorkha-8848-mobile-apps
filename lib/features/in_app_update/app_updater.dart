import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppUpdater {
  bool isAndroidUpdateDialogAlreadyShown = false;

  checkForAndroidAppUpdate() async {
    try {
      AppUpdateInfo appUpdateInfo = await InAppUpdate.checkForUpdate();
      if (appUpdateInfo.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        if (appUpdateInfo.immediateUpdateAllowed) {
          _checkForAndroidImmediateUpdate();
        } else {
          _checkForAndroidFlexibleUpdate(appUpdateInfo);
        }
      } else {
        _checkForAndroidFlexibleUpdate(appUpdateInfo);
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  _checkForAndroidImmediateUpdate() async {
    try {
      final appUpdateResult = await InAppUpdate.performImmediateUpdate();
      switch (appUpdateResult) {
        case AppUpdateResult.userDeniedUpdate:
          SystemNavigator.pop();
          break;
        case AppUpdateResult.success:
        case AppUpdateResult.inAppUpdateFailed:
        default:
          break;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _checkForAndroidFlexibleUpdate(AppUpdateInfo appUpdateInfo) async {
    if (appUpdateInfo.flexibleUpdateAllowed) {
      AppUpdateResult appUpdateResult = await InAppUpdate.startFlexibleUpdate();
      if (appUpdateResult == AppUpdateResult.success) {
        try {
          await InAppUpdate.completeFlexibleUpdate();
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }
  }
}

class PackageInformation {
  static Future<String> getAppVersion() async =>
      (await PackageInfo.fromPlatform()).version;

  static Future<String> getBuildNumber() async =>
      (await PackageInfo.fromPlatform()).buildNumber;

  static Future<String> getAppPackageName() async =>
      (await PackageInfo.fromPlatform()).packageName;
}
