import 'package:doctor_perro_helper/utils/get_latest_app_version.dart';
import 'package:doctor_perro_helper/utils/version_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

// * https://api.github.com/repos/DaviD4Chirino/doctor_perro_helper/releases/latest

Future<bool> updateAvailable() async {
  try {
    final map = await getLatestAppVersion();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int currentVersion = versionStringToInt(packageInfo.version);
    int tag = versionStringToInt(map["tag_name"]);

    return currentVersion <= tag;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return false;
  }
}
