import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:flutter_screen_lock/src/layout/key_pad.dart';

typedef DelayBuilderCallback = Widget Function(
    BuildContext context, Duration delay);

typedef SecretsBuilderCallback = Widget Function(
  BuildContext context,
  SecretsConfig config,
  int length,
  ValueListenable<String> input,
  Stream<bool> verifyStream,
);

class ScreenLock extends StatefulWidget {
  const ScreenLock({
    Key? key,
    required this.correctString,
    required this.didUnlocked,
    this.didOpened,
    this.didCancelled,
    this.didConfirmed,
    this.didError,
    this.didMaxRetries,
    this.customizedButtonTap,
    this.confirmation = false,
    this.digits = 4,
    this.maxRetries = 0,
    this.retryDelay = Duration.zero,
    Widget? title,
    Widget? confirmTitle,
    ScreenLockConfig? screenLockConfig,
    SecretsConfig? secretsConfig,
    InputButtonConfig? inputButtonConfig,
    this.delayBuilder,
    this.customizedButtonChild,
    this.footer,
    this.cancelButton,
    this.deleteButton,
    this.inputController,
    this.withBlur = true,
    this.secretsBuilder,
  })  : title = title ?? const HeadingTitle(text: 'Please enter passcode.'),
        confirmTitle = confirmTitle ??
            const HeadingTitle(text: 'Please enter confirm passcode.'),
        screenLockConfig = screenLockConfig ?? const ScreenLockConfig(),
        secretsConfig = secretsConfig ?? const SecretsConfig(),
        inputButtonConfig = inputButtonConfig ?? const InputButtonConfig(),
        assert(maxRetries > -1),
        super(key: key);

  /// Input correct string.
  final String correctString;

  /// Called if the value matches the correctString.
  final VoidCallback didUnlocked;

  /// Called when the screen is shown the first time.
  ///
  /// Useful if you want to show biometric authentication.
  final VoidCallback? didOpened;

  /// Called when the user cancels.
  ///
  /// If null, the user cannot cancel.
  final VoidCallback? didCancelled;

  /// Called when the first and second inputs match during confirmation.
  final void Function(String matchedText)? didConfirmed;

  /// Called if the value does not match the correctString.
  final void Function(int retries)? didError;

  /// Events that have reached the maximum number of attempts.
  final void Function(int retries)? didMaxRetries;

  /// Tapped for left side lower button.
  final VoidCallback? customizedButtonTap;

  /// Make sure the first and second inputs are the same.
  final bool confirmation;

  /// Set the maximum number of characters to enter when confirmation is true.
  final int digits;

  /// `0` is unlimited.
  /// For example, if it is set to 1, didMaxRetries will be called on the first failure.
  final int maxRetries;

  /// Delay until we can retry.
  ///
  /// Duration.zero is no delay.
  final Duration retryDelay;

  /// Heading title for ScreenLock.
  final Widget title;

  /// Heading confirm title for ScreenLock.
  final Widget confirmTitle;

  /// Configurations of [ScreenLock].
  final ScreenLockConfig screenLockConfig;

  /// Configurations of [Secrets].
  final SecretsConfig secretsConfig;

  /// Configurations of [InputButton].
  final InputButtonConfig inputButtonConfig;

  /// Specify the widget during input invalidation by retry delay.
  final DelayBuilderCallback? delayBuilder;

  /// Child for bottom left side button.
  final Widget? customizedButtonChild;

  /// Footer widget.
  final Widget? footer;

  /// Cancel button widget.
  final Widget? cancelButton;

  /// delete button widget.
  final Widget? deleteButton;

  /// Control inputs externally.
  final InputController? inputController;

  /// Blur the background.
  final bool withBlur;

  /// Custom secrets animation widget builder.
  final SecretsBuilderCallback? secretsBuilder;

  @override
  State<ScreenLock> createState() => _ScreenLockState();
}

class _ScreenLockState extends State<ScreenLock> {
  late InputController inputController;

  /// Logging retries.
  int retries = 1;

  /// First input completed.
  bool firstInputCompleted = false;

  String firstInput = '';

  final StreamController<Duration> inputDelayController =
      StreamController.broadcast();

  bool inputDelayed = false;

  void inputDelay() {
    if (widget.retryDelay == (Duration.zero)) {
      return;
    }

    inputController.clear();
    DateTime unlockTime = DateTime.now().add(widget.retryDelay);
    inputDelayController.add(widget.retryDelay);

    setState(() {
      inputDelayed = true;
    });

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      Duration difference = unlockTime.difference(DateTime.now());
      if (difference <= Duration.zero) {
        setState(() {
          inputDelayed = false;
        });
        timer.cancel();
      } else {
        inputDelayController.add(difference);
      }
    });
  }

  void error() {
    widget.didError?.call(retries);

    if (widget.maxRetries >= 1 && widget.maxRetries <= retries) {
      widget.didMaxRetries?.call(retries);

      // reset retries
      retries = 0;

      inputDelay();
    }

    retries++;
  }

  Widget makeDelayBuilder(Duration duration) {
    if (widget.delayBuilder != null) {
      return widget.delayBuilder!(context, duration);
    } else {
      return HeadingTitle(
        text:
            'Input locked for ${(duration.inMilliseconds / 1000).ceil()} seconds.',
      );
    }
  }

  Widget buildHeadingText() {
    Widget child = widget.title;

    if (widget.confirmation) {
      child = StreamBuilder<bool>(
        stream: inputController.confirmed,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            return widget.confirmTitle;
          }
          return child;
        },
      );
    }

    if (widget.retryDelay != (Duration.zero)) {
      child = StreamBuilder<Duration>(
        stream: inputDelayController.stream,
        builder: (context, snapshot) {
          if (inputDelayed && snapshot.hasData) {
            return makeDelayBuilder(snapshot.data!);
          }
          return child;
        },
      );
    }

    return child;
  }

  ThemeData makeThemeData() {
    return widget.screenLockConfig.themeData ??
        ScreenLockConfig.defaultThemeData;
  }

  @override
  void initState() {
    super.initState();
    inputController = widget.inputController ?? InputController();
    inputController.initialize(
      correctString: widget.correctString,
      digits: widget.digits,
      isConfirmed: widget.confirmation,
    );

    inputController.verifyInput.listen((success) {
      // Wait for the animation on failure.
      Future.delayed(const Duration(milliseconds: 300), () {
        inputController.clear();
      });

      if (success) {
        if (widget.confirmation) {
          widget.didConfirmed?.call(inputController.confirmedInput);
        } else {
          widget.didUnlocked();
        }
      } else {
        error();
      }
    });

    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.didOpened?.call());
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final secretLength =
        widget.confirmation ? widget.digits : widget.correctString.length;

    Widget buildSecrets() {
      return widget.secretsBuilder == null
          ? SecretsWithShakingAnimation(
              config: widget.secretsConfig,
              length: secretLength,
              input: inputController.currentInput,
              verifyStream: inputController.verifyInput,
            )
          : widget.secretsBuilder!(
              context,
              widget.secretsConfig,
              secretLength,
              inputController.currentInput,
              inputController.verifyInput,
            );
    }

    Widget buildKeyPad() {
      return Center(
        child: KeyPad(
          enabled: !inputDelayed,
          inputButtonConfig: widget.inputButtonConfig,
          inputState: inputController,
          didCancelled: widget.didCancelled,
          customizedButtonTap: widget.customizedButtonTap,
          customizedButtonChild: widget.customizedButtonChild,
          deleteButton: widget.deleteButton,
          cancelButton: widget.cancelButton,
        ),
      );
    }

    Widget buildContent() {
      return OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return Center(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildHeadingText(),
                            buildSecrets(),
                          ],
                        ),
                      ),
                      buildKeyPad(),
                    ],
                  ),
                  widget.footer ?? Container(),
                ],
              ),
            ),
          );
        }

        return SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildHeadingText(),
              buildSecrets(),
              buildKeyPad(),
              widget.footer ?? Container(),
            ],
          ),
        );
      });
    }

    Widget buildContentWithBlur() {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
        child: buildContent(),
      );
    }

    return Theme(
      data: makeThemeData(),
      child: Scaffold(
        backgroundColor: widget.screenLockConfig.backgroundColor,
        body: SafeArea(
          child: widget.withBlur ? buildContentWithBlur() : buildContent(),
        ),
      ),
    );
  }
}
