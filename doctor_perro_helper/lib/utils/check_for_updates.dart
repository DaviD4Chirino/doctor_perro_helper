import 'package:doctor_perro_helper/utils/get_latest_app_version.dart';
import 'package:doctor_perro_helper/utils/update_app_dialog.dart';
import 'package:doctor_perro_helper/utils/version_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Returns true if query is successful regardless of
/// whether or not there is a new version
Future<bool> checkForUpdates(BuildContext context) async {
  try {
    // done this way so we dont duplicate calls
    final map = await getLatestAppVersion();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    int currentVersion = versionStringToInt(packageInfo.version);
    int remoteVersion = versionStringToInt(map["tag_name"]);

    if (kDebugMode) {
      print("<-----CHECK FOR UPDATES BEGIN------>");
      print("packageInfo:\n$packageInfo");
      print("currentVersion: $currentVersion");
      print("remoteVersion: $remoteVersion");
      print("Remote is higher?: ${remoteVersion > currentVersion}");
      print("<-----CHECK FOR UPDATES ENDS------->");
    }

    List<dynamic> assets = map["assets"];

    List<dynamic> apkAsset = assets
        .where(
          (e) => (e["name"] as String).endsWith(".apk"),
        )
        .toList();

    /* dynamic downloadUrl = (map["assets"] as List<dynamic>).map(
      (e) => (e["label"] as String).endsWith(".apk"),
    ); */

    if (remoteVersion > currentVersion) {
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
      return true;
    }
    return false;

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
    return false;
  }
}


// Future<Directory> getDownloadsDirectoryNonNullable() async {
//   Directory? downloadsDirectory;

//   if (Platform.isAndroid) {
//     downloadsDirectory = await getExternalStorageDirectory();
//     // Append the "Download" directory to get the correct path
//     downloadsDirectory = Directory('${downloadsDirectory?.path}/Download');
//   } else if (Platform.isIOS) {
//     downloadsDirectory = await getApplicationDocumentsDirectory();
//     // For iOS, manually append the "Downloads" directory (or any other desired directory)
//     downloadsDirectory = Directory('${downloadsDirectory.path}/Downloads');
//   } else {
//     // Handle other platforms if necessary
//     downloadsDirectory = await getApplicationDocumentsDirectory();
//   }

//   return downloadsDirectory ?? Directory.systemTemp.path;
// }