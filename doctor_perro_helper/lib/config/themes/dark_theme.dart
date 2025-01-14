import 'package:doctor_perro_helper/config/themes/shared_theme_data.dart';
import 'package:flutter/material.dart';

const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFB937F5),
  onPrimary: Color(0xFF30254C),
  primaryContainer: Color(0xFF403266),
  onPrimaryContainer: Color(0xFFCBC0E6),
  secondary: Color(0xFFD8D2E6),
  onSecondary: Color(0xFF433E4C),
  secondaryContainer: Color(0xFF595366),
  onSecondaryContainer: Color(0xFFDCD8E6),
  tertiary: Color(0xFFE6C3CE),
  onTertiary: Color(0xFF4C323B),
  tertiaryContainer: Color(0xFF66434F),
  onTertiaryContainer: Color(0xFFE6CDD5),
  error: Color(0xFFE69490),
  onError: Color(0xFF4C100D),
  errorContainer: Color(0xFF661511),
  onErrorContainer: Color(0xFFE6ACA9),
  surface: Color(0xFF161616),
  onSurface: Color(0xFFe4e4e6),
  surfaceContainerHighest: Color(0xFF5e5c66),
  onSurfaceVariant: Color(0xFFdedbe6),
  outline: Color(0xFFaaa7b3),
);

final sharedThemeData = SharedThemeData();

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  appBarTheme: sharedThemeData.appBarTheme(darkColorScheme),
);
