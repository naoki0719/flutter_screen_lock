import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/src/configurations/secret_config.dart';
import 'package:flutter_screen_lock/src/configurations/secrets_config.dart';

class SecretsWithShakingAnimation extends StatefulWidget {
  const SecretsWithShakingAnimation({
    super.key,
    required this.config,
    required this.length,
    required this.input,
    required this.verifyStream,
  });

  final SecretsConfig config;
  final int length;
  final ValueListenable<String> input;
  final Stream<bool> verifyStream;

  @override
  State<SecretsWithShakingAnimation> createState() =>
      _SecretsWithShakingAnimationState();
}

class _SecretsWithShakingAnimationState
    extends State<SecretsWithShakingAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _animation;
  late AnimationController _animationController;
  late StreamSubscription<bool> _verifySubscription;
  bool errored = false;

  @override
  void initState() {
    super.initState();

    _verifySubscription = widget.verifyStream.listen((valid) {
      if (!valid) {
        // shake animation when invalid
        _animationController.forward();
        errored = true;
      }
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    );

    _animation = _animationController
        .drive(CurveTween(curve: Curves.elasticIn))
        .drive(Tween<Offset>(begin: Offset.zero, end: const Offset(0.05, 0)))
      ..addListener(() => setState(() {}))
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _animationController.reverse();
            Future.delayed(const Duration(milliseconds: 200), () {
              setState(() {
                errored = false;
              });
            });
          }
        },
      );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _verifySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Secrets(
        input: widget.input,
        length: widget.length,
        config: widget.config,
        errored: errored,
      ),
    );
  }
}

class Secrets extends StatefulWidget {
  const Secrets({
    super.key,
    SecretsConfig? config,
    required this.input,
    required this.length,
    this.errored = false,
  }) : config = config ?? const SecretsConfig();

  final SecretsConfig config;
  final ValueListenable<String> input;
  final int length;
  final bool errored;

  @override
  State<Secrets> createState() => _SecretsState();
}

class _SecretsState extends State<Secrets> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: widget.input,
      builder: (context, value, child) => Padding(
        padding: widget.config.padding,
        child: Wrap(
          spacing: widget.config.spacing,
          children: List.generate(
            widget.length,
            (index) {
              if (value.isEmpty) {
                return Secret(
                  config: widget.config.secretConfig,
                  enabled: false,
                  errored: widget.errored,
                );
              }

              return Secret(
                config: widget.config.secretConfig,
                enabled: index < value.length,
                errored: widget.errored,
              );
            },
            growable: false,
          ),
        ),
      ),
    );
  }
}

class Secret extends StatelessWidget {
  const Secret({
    super.key,
    SecretConfig? config,
    this.enabled = false,
    this.errored = false,
  }) : config = config ?? const SecretConfig();

  final SecretConfig config;
  final bool enabled;
  final bool errored;

  Color get _dotColor {
    if (errored && config.erroredColor != null && enabled) {
      return config.erroredColor!;
    }

    return enabled ? config.enabledColor : config.disabledColor;
  }

  Color get _borderColor {
    if (errored && config.erroredBorderColor != null) {
      return config.erroredBorderColor!;
    }

    return config.borderColor;
  }

  @override
  Widget build(BuildContext context) {
    if (config.builder != null) {
      return config.builder!(
        context,
        config,
        enabled,
      );
    }

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _dotColor,
        border: Border.all(
          width: config.borderSize,
          color: _borderColor,
        ),
      ),
      width: config.size,
      height: config.size,
    );
  }
}
