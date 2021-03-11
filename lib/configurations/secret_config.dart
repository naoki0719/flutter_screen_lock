import 'package:flutter/material.dart';

/// Configuration of [Secret]
class SecretConfig {
  const SecretConfig({
    this.width = 16,
    this.height = 16,
    this.borderSize = 1.0,
    this.borderColor = Colors.white,
    this.enabledColor = Colors.white,
    this.disabledColor = Colors.transparent,
    this.build,
  });

  final double width;
  final double height;
  final double borderSize;
  final Color borderColor;
  final Color enabledColor;
  final Color disabledColor;

  /// `build` override function
  final Widget Function(
    BuildContext context, {
    required bool enabled,
    required SecretConfig config,
  })? build;

  SecretConfig copyWith({
    double? width,
    double? height,
    double? borderSize,
    Color? borderColor,
    Color? enabledColor,
    Color? disabledColor,
  }) {
    return SecretConfig(
      width: width ?? this.width,
      height: height ?? this.height,
      borderSize: borderSize ?? this.borderSize,
      borderColor: borderColor ?? this.borderColor,
      enabledColor: enabledColor ?? this.enabledColor,
      disabledColor: disabledColor ?? this.disabledColor,
    );
  }
}
