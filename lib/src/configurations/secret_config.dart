import 'package:flutter/material.dart';

/// Configuration of a [Secret] widget.
class SecretConfig {
  const SecretConfig({
    this.size = 16,
    this.borderSize = 1,
    this.borderColor = Colors.white,
    this.enabledColor = Colors.white,
    this.disabledColor = Colors.transparent,
    this.erroredBorderColor,
    this.erroredColor,
    this.builder,
  });

  /// Size (width and height) the secret.
  final double size;

  /// Border size for the secret.
  final double borderSize;

  /// Border color for the secret.
  final Color borderColor;

  /// Border color for the errored secret.
  final Color? erroredBorderColor;

  /// Color for the enabled secret.
  final Color enabledColor;

  /// Color for the disabled secret.
  final Color disabledColor;

  /// Color for the errored secret.
  final Color? erroredColor;

  final Widget Function(
    BuildContext context,
    SecretConfig config,
    bool enabled,
  )? builder;

  SecretConfig copyWith({
    double? size,
    double? borderSize,
    Color? borderColor,
    Color? enabledColor,
    Color? disabledColor,
    Color? erroredBorderColor,
    Color? erroredColor,
  }) {
    return SecretConfig(
      size: size ?? this.size,
      borderSize: borderSize ?? this.borderSize,
      borderColor: borderColor ?? this.borderColor,
      enabledColor: enabledColor ?? this.enabledColor,
      disabledColor: disabledColor ?? this.disabledColor,
      erroredBorderColor: erroredBorderColor ?? this.erroredBorderColor,
      erroredColor: erroredColor ?? this.erroredColor,
    );
  }
}
