import 'package:flutter/material.dart';

class ScreenLockConfig {
  /// ScreenLock default theme data.
  ///
  /// - Heading title is textTheme.heading1
  /// - Bottom both side text color is outlinedButtonTheme > style > primary
  /// - Number text button is outlinedButtonTheme
  static final ThemeData defaultThemeData = ThemeData(
    scaffoldBackgroundColor: const Color(0x88545454),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFF808080),
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(0),
        side: BorderSide.none,
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    ),
  );

  /// background color of ScreenLock.
  final Color? backgroundColor;

  final ThemeData? themeData;

  const ScreenLockConfig({
    this.backgroundColor,
    this.themeData,
  });
}
