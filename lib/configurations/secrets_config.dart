import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/configurations/secret_config.dart';

class SecretsConfig {
  /// Absolute space between secret widgets.
  /// If specified together with spacingRatio, this will take precedence.
  final double spacing;

  /// Space ratio between secret widgets.
  ///
  /// Default [0.05]
  final double spacingRatio;

  /// padding of Secrets Widget.
  final EdgeInsetsGeometry padding;

  final SecretConfig secretConfig;

  const SecretsConfig({
    this.spacing,
    this.spacingRatio = 0.05,
    this.padding = const EdgeInsets.only(top: 20, bottom: 50),
    this.secretConfig = const SecretConfig(),
  });
}
