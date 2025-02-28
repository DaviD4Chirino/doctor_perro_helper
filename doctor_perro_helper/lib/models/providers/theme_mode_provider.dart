import 'package:doctor_perro_helper/models/use_shared_preferences.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "theme_mode_provider.g.dart";

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    return UseSharedPreferences.preferences.getBool("theme-mode") ?? true
        ? ThemeMode.light
        : ThemeMode.dark;
  }

  void toggleDark() {
    state = ThemeMode.dark;
    _setStatusBarColor();
    UseSharedPreferences.preferences.setBool("theme-mode", false);
  }

  void toggleLight() {
    state = ThemeMode.light;
    _setStatusBarColor();
    UseSharedPreferences.preferences.setBool("theme-mode", true);
  }

  void _setStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness:
            state == ThemeMode.light ? Brightness.dark : Brightness.light));
  }
}
