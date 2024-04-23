import 'package:flutter/material.dart';

class ScreenLockConfig {
  const ScreenLockConfig({
    this.backgroundColor,
    this.titleTextStyle,
    this.textStyle,
    this.buttonStyle,
    this.themeData,
  });

  /// Background color of the ScreenLock.
  final Color? backgroundColor;

  /// Text style for title Texts.
  final TextStyle? titleTextStyle;

  /// Text style for other Texts.
  final TextStyle? textStyle;

  /// Button style for keypad buttons.
  final ButtonStyle? buttonStyle;

  /// Base [ThemeData] that is overridden by other specified values.
  final ThemeData? themeData;

  /// Returns this config as a [ThemeData].
  ThemeData toThemeData() {
    return (themeData ?? ThemeData()).copyWith(
      scaffoldBackgroundColor: backgroundColor,
      outlinedButtonTheme: OutlinedButtonThemeData(style: buttonStyle),
      textTheme: TextTheme(
        titleLarge: titleTextStyle,
        bodyMedium: textStyle,
      ),
    );
  }

  /// Copies a [ScreenLockConfig] with new values.
  ScreenLockConfig copyWith({
    Color? backgroundColor,
    TextStyle? titleTextStyle,
    TextStyle? textStyle,
    ButtonStyle? buttonStyle,
    ThemeData? themeData,
  }) {
    return ScreenLockConfig(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      textStyle: textStyle ?? this.textStyle,
      buttonStyle: buttonStyle ?? this.buttonStyle,
      themeData: themeData ?? this.themeData,
    );
  }

  /// Default [ScreenLockConfig].
  static final ScreenLockConfig defaultConfig = ScreenLockConfig(
    backgroundColor: const Color(0x88545454),
    buttonStyle: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFFFFFFFF),
      backgroundColor: const Color(0xFF808080),
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(0),
      side: BorderSide.none,
    ),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
  );
}
