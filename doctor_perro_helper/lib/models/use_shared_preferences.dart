import 'package:shared_preferences/shared_preferences.dart';

class UseSharedPreferences {
  static late SharedPreferences preferences;

  static Future init() async =>
      preferences = await SharedPreferences.getInstance();
}
