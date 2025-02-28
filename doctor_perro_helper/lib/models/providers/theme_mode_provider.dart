import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "theme_mode_provider.g.dart";

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    return ThemeMode.dark;
  }

  void toggleDark() {
    state = ThemeMode.dark;
    _setStatusBarColor();
  }

  void toggleLight() {
    state = ThemeMode.light;
    _setStatusBarColor();
  }

  void _setStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness:
            state == ThemeMode.light ? Brightness.dark : Brightness.light));
  }
}
