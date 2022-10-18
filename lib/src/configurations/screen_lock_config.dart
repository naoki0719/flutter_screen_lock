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

  /// Base [ThemeData] that is overriden by other specified values.
  final ThemeData? themeData;

  /// Adds the values of this config to another [ThemeData].
  ThemeData withThemeData(ThemeData other) {
    return other.copyWith(
      scaffoldBackgroundColor: backgroundColor,
      outlinedButtonTheme: OutlinedButtonThemeData(style: buttonStyle),
      textTheme: TextTheme(
        headline1: titleTextStyle,
        bodyText2: textStyle,
      ),
    );
  }

  /// Returns this config as a [ThemeData].
  ThemeData toThemeData() => withThemeData(themeData ?? ThemeData());

  // Copies a [ScreenLockConfig] with new values.
  ScreenLockConfig copyWith({
    Color? backgroundColor,
    TextStyle? titleTextStyle,
    TextStyle? textStyle,
    ButtonStyle? buttonStyle,
  }) {
    return ScreenLockConfig(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      textStyle: textStyle ?? this.textStyle,
      buttonStyle: buttonStyle ?? this.buttonStyle,
    );
  }

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
