import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// the latest app version from Github
Future<Map<String, dynamic>> getLatestAppVersion() async {
  try {
    final httpPackageUrl = Uri.https(
      "api.github.com",
      "/repos/DaviD4Chirino/doctor_perro_helper/releases/latest",
    );
    final data = await http.read(httpPackageUrl);
    final map = JsonDecoder().convert(data);
    return map;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return {};
  }
}
