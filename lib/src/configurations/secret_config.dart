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

  final double size;
  final double borderSize;
  final Color borderColor;
  final Color enabledColor;
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
