import 'package:flutter/material.dart';

/// Configuration of a [Secret] widget.
class SecretConfig {
  const SecretConfig({
    this.size = 16,
    this.borderSize = 1,
    this.borderColor = Colors.white,
    this.enabledColor = Colors.white,
    this.disabledColor = Colors.transparent,
    this.builder,
  });

  /// Size (width and height) the secret.
  final double size;

  /// Border size for the secret.
  final double borderSize;

  /// Border color for the secret.
  final Color borderColor;

  /// Color for the enabled secret.
  final Color enabledColor;

  /// Color for the disabled secret.
  final Color disabledColor;

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
  }) {
    return SecretConfig(
      size: size ?? this.size,
      borderSize: borderSize ?? this.borderSize,
      borderColor: borderColor ?? this.borderColor,
      enabledColor: enabledColor ?? this.enabledColor,
      disabledColor: disabledColor ?? this.disabledColor,
    );
  }
}
