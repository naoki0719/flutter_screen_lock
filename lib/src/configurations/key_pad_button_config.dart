import 'package:flutter/material.dart';

class KeyPadButtonConfig {
  const KeyPadButtonConfig({
    double? size,
    double? fontSize,
    this.foregroundColor,
    this.backgroundColor,
    this.buttonStyle,
  })  : size = size ?? 68,
        fontSize = fontSize ?? 36;

  /// Button width and height.
  final double size;

  /// Button font size.
  final double fontSize;

  /// Button foreground (text) color.
  final Color? foregroundColor;

  /// Button background color.
  final Color? backgroundColor;

  /// Full button style. Overrides all other values except [size].
  final ButtonStyle? buttonStyle;

  /// Creates a configuration from an existing [ButtonStyle].
  KeyPadButtonConfig fromButtonStyle({
    double? size,
    required ButtonStyle style,
  }) {
    Set<MaterialState> states = MaterialState.values.toSet();
    return KeyPadButtonConfig(
      size: size,
      fontSize: style.textStyle?.resolve(states)?.fontSize,
      foregroundColor: style.foregroundColor?.resolve(states),
      backgroundColor: style.backgroundColor?.resolve(states),
    );
  }

  /// Base [ButtonStyle] that is overriden by other specified values.
  ButtonStyle toButtonStyle() {
    ButtonStyle composed = OutlinedButton.styleFrom(
      textStyle: TextStyle(fontSize: fontSize),
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
    );
    if (buttonStyle != null) {
      return buttonStyle!.copyWith(
        textStyle: composed.textStyle,
        foregroundColor: composed.foregroundColor,
        backgroundColor: composed.backgroundColor,
      );
    } else {
      return composed;
    }
  }

  // Copies a [KeyPadButtonConfig] with new values.
  KeyPadButtonConfig copyWith({
    double? size,
    double? fontSize,
    Color? foregroundColor,
    Color? backgroundColor,
    ButtonStyle? buttonStyle,
  }) {
    return KeyPadButtonConfig(
      size: size ?? this.size,
      fontSize: fontSize ?? this.fontSize,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      buttonStyle: buttonStyle ?? this.buttonStyle,
    );
  }
}
