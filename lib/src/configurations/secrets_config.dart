import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/src/configurations/secret_config.dart';

class SecretsConfig {
  const SecretsConfig({
    double? spacing,
    this.padding = const EdgeInsets.only(top: 20, bottom: 50),
    this.secretConfig = const SecretConfig(),
  }) : spacing = 12;

  /// Space between secret widgets.
  final double spacing;

  /// Padding of secrets widget.
  final EdgeInsetsGeometry padding;

  /// Config for secrets.
  final SecretConfig secretConfig;

  /// Copies a [SecretsConfig] with new values.
  SecretsConfig copyWith({
    double? spacing,
    EdgeInsetsGeometry? padding,
    SecretConfig? secretConfig,
  }) {
    return SecretsConfig(
      spacing: spacing ?? this.spacing,
      padding: padding ?? this.padding,
      secretConfig: secretConfig ?? this.secretConfig,
    );
  }
}
