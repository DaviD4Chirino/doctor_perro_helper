import 'package:doctor_perro_helper/utils/get_latest_app_version.dart';
import 'package:doctor_perro_helper/utils/update_app_dialog.dart';
import 'package:doctor_perro_helper/utils/version_checker.dart';
import 'package:doctor_perro_helper/utils/version_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> checkForUpdates(BuildContext context) async {
  try {
    // done this way so we dont duplicate calls
    final map = await getLatestAppVersion();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int currentVersion = versionStringToInt(packageInfo.version);
    int tag = versionStringToInt(map["tag_name"]);

    List<dynamic> assets = map["assets"];

    List<dynamic> apkAsset = assets
        .where(
          (e) => (e["name"] as String).endsWith(".apk"),
        )
        .toList();

    /* dynamic downloadUrl = (map["assets"] as List<dynamic>).map(
      (e) => (e["label"] as String).endsWith(".apk"),
    ); */

    if (kDebugMode) {
      print(map["body"]);
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => updateAlertDialog(
          context,
          downloadUrl:
              apkAsset.isNotEmpty ? apkAsset[0]["browser_download_url"] : "",
          localVersion: packageInfo.version,
          remoteVersion: map["tag_name"],
          body: map["body"],
        ),
      );
    }

    /* if (currentVersion <= tag) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => updateAlertDialog(),
      );
    } */
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}
