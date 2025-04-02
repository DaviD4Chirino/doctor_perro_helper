import 'dart:convert';

import 'package:doctor_perro_helper/utils/version_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// * https://api.github.com/repos/DaviD4Chirino/doctor_perro_helper/releases/latest

Future<bool> updateAvailable() async {
  final httpPackageUrl = Uri.https(
    "api.github.com",
    "/repos/DaviD4Chirino/doctor_perro_helper/releases/latest",
  );

  try {
    final data = await http.read(httpPackageUrl);
    final map = JsonDecoder().convert(data);

    if (kDebugMode) {
      print(map["tag_name"]);
      print(versionStringToInt(map["tag_name"]) > versionStringToInt("v0.5.1"));
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return false;
  }

  return false;
}
