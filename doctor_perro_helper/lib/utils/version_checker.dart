import 'dart:convert';

import 'package:doctor_perro_helper/utils/version_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

// * https://api.github.com/repos/DaviD4Chirino/doctor_perro_helper/releases/latest

Future<bool> updateAvailable() async {
  final httpPackageUrl = Uri.https(
    "api.github.com",
    "/repos/DaviD4Chirino/doctor_perro_helper/releases/latest",
  );

  try {
    final data = await http.read(httpPackageUrl);
    final map = JsonDecoder().convert(data);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int currentVersion = versionStringToInt(packageInfo.version);
    int tag = versionStringToInt(map["tag_name"]);

    if (kDebugMode) {
      print(currentVersion >= tag ? "up tp date" : "new version available");
    }
    return currentVersion <= tag;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return false;
  }
}
