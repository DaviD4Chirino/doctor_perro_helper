import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade package to version 8.1.0.
///
/// Use in [MaterialApp] like this:
///
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
///     :
/// );
abstract final class AppTheme {
  // The defined light theme.
  static ThemeData light = FlexThemeData.light(
    colors: const FlexSchemeColor(
      // Custom colors
      primary: Color(0xFFF9B142),
      primaryContainer: Color(0xFF382B18),
      primaryLightRef: Color(0xFFF9B142),
      secondary: Color(0xFFE99140),
      secondaryContainer: Color(0xFFFFDCC1),
      secondaryLightRef: Color(0xFFE99140),
      tertiary: Color(0xFFEE4845),
      tertiaryContainer: Color(0xFFF77E7C),
      tertiaryLightRef: Color(0xFFEE4845),
      appBarColor: Color(0xFFFFDCC1),
      error: Color(0xFFD50000),
      errorContainer: Color(0xFFFF8A80),
    ),
    surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
    blendLevel: 2,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnLevel: 10,
      useM2StyleDividerInM3: true,
      defaultRadius: 8.0,
      textButtonRadius: 8.0,
      filledButtonRadius: 8.0,
      elevatedButtonRadius: 8.0,
      outlinedButtonRadius: 8.0,
      outlinedButtonOutlineSchemeColor: SchemeColor.primary,
      outlinedButtonPressedBorderWidth: 2.0,
      toggleButtonsBorderSchemeColor: SchemeColor.primary,
      segmentedButtonSchemeColor: SchemeColor.primary,
      segmentedButtonBorderSchemeColor: SchemeColor.primary,
      unselectedToggleIsColored: true,
      sliderValueTinted: true,
      inputDecoratorSchemeColor: SchemeColor.primary,
      inputDecoratorIsFilled: true,
      inputDecoratorBackgroundAlpha: 21,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: 12.0,
      inputDecoratorUnfocusedHasBorder: false,
      inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
      fabSchemeColor: SchemeColor.primaryContainer,
      popupMenuRadius: 6.0,
      popupMenuElevation: 8.0,
      alignedDropdown: true,
      drawerIndicatorSchemeColor: SchemeColor.primary,
      bottomNavigationBarMutedUnselectedLabel: false,
      bottomNavigationBarMutedUnselectedIcon: false,
      menuRadius: 6.0,
      menuElevation: 8.0,
      menuBarRadius: 0.0,
      menuBarElevation: 1.0,
      navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
      navigationBarIndicatorSchemeColor: SchemeColor.primary,
      navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
      navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
      navigationRailUseIndicator: true,
      navigationRailIndicatorSchemeColor: SchemeColor.primary,
      navigationRailIndicatorOpacity: 1.00,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
  // The defined dark theme.
  static ThemeData dark = FlexThemeData.dark(
    colors: const FlexSchemeColor(
      // Custom colors
      primary: Color(0xFFF9B142),
      primaryContainer: Color(0xFFFFE4B4),
      primaryLightRef: Color(0xFFF9B142),
      secondary: Color(0xFFE99140),
      secondaryContainer: Color(0xFF815328),
      secondaryLightRef: Color(0xFFE99140),
      tertiary: Color(0xFFEE4845),
      tertiaryContainer: Color(0xFFF77E7C),
      tertiaryLightRef: Color(0xFFEE4845),
      appBarColor: Color(0xFFFFDCC1),
      error: Color(0xFFC62828),
      errorContainer: Color(0xFF440005),
    ),
    surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
    blendLevel: 8,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnLevel: 8,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      defaultRadius: 8.0,
      textButtonRadius: 8.0,
      filledButtonRadius: 8.0,
      elevatedButtonRadius: 8.0,
      outlinedButtonRadius: 8.0,
      outlinedButtonOutlineSchemeColor: SchemeColor.primary,
      outlinedButtonPressedBorderWidth: 2.0,
      toggleButtonsBorderSchemeColor: SchemeColor.primary,
      segmentedButtonSchemeColor: SchemeColor.primary,
      segmentedButtonBorderSchemeColor: SchemeColor.primary,
      unselectedToggleIsColored: true,
      sliderValueTinted: true,
      inputDecoratorSchemeColor: SchemeColor.primary,
      inputDecoratorIsFilled: true,
      inputDecoratorBackgroundAlpha: 43,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: 12.0,
      inputDecoratorUnfocusedHasBorder: false,
      fabSchemeColor: SchemeColor.primaryContainer,
      popupMenuRadius: 6.0,
      popupMenuElevation: 8.0,
      alignedDropdown: true,
      drawerIndicatorSchemeColor: SchemeColor.primary,
      bottomNavigationBarMutedUnselectedLabel: false,
      bottomNavigationBarMutedUnselectedIcon: false,
      menuRadius: 6.0,
      menuElevation: 8.0,
      menuBarRadius: 0.0,
      menuBarElevation: 1.0,
      navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
      navigationBarIndicatorSchemeColor: SchemeColor.primary,
      navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
      navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
      navigationRailUseIndicator: true,
      navigationRailIndicatorSchemeColor: SchemeColor.primary,
      navigationRailIndicatorOpacity: 1.00,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}
