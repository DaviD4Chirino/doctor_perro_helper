import 'package:doctor_perro_helper/models/use_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "theme_mode_provider.g.dart";

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    if (UseSharedPreferences.preferences.getBool("theme-mode") == null) {
      return ThemeMode.system;
    } else {
      return UseSharedPreferences.preferences.getBool("theme-mode")!
          ? ThemeMode.light
          : ThemeMode.dark;
    }
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
    SystemUiOverlayStyle brightness = state == ThemeMode.light
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light;

    SystemChrome.setSystemUIOverlayStyle(brightness);
  }
}
