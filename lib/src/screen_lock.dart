import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/src/configurations/input_button_config.dart';
import 'package:flutter_screen_lock/src/configurations/screen_lock_config.dart';
import 'package:flutter_screen_lock/src/configurations/secrets_config.dart';
import 'package:flutter_screen_lock/src/heading_title.dart';
import 'package:flutter_screen_lock/src/input_controller.dart';
import 'package:flutter_screen_lock/src/layout/key_pad.dart';
import 'package:flutter_screen_lock/src/layout/secrets.dart';

class ScreenLock extends StatefulWidget {
  const ScreenLock({
    Key? key,
    required this.correctString,
    this.title = const HeadingTitle(text: 'Please enter passcode.'),
    this.confirmTitle =
        const HeadingTitle(text: 'Please enter confirm passcode.'),
    this.screenLockConfig = const ScreenLockConfig(),
    this.secretsConfig = const SecretsConfig(),
    this.inputButtonConfig = const InputButtonConfig(),
    this.canCancel = true,
    this.confirmation = false,
    this.digits = 4,
    this.didUnlocked,
    this.didConfirmed,
    this.didError,
    this.maxRetries = 0,
    this.didMaxRetries,
    this.customizedButtonTap,
    this.customizedButtonChild,
    this.footer,
    this.cancelButton,
    this.deleteButton,
    this.inputController,
  })  : assert(maxRetries > -1),
        super(key: key);

  /// Configurations of [ScreenLock].
  final ScreenLockConfig screenLockConfig;

  /// Configurations of [Secrets].
  final SecretsConfig secretsConfig;

  /// Configurations of [InputButton].
  final InputButtonConfig inputButtonConfig;

  /// Input correct string.
  final String correctString;

  /// Heading title for ScreenLock.
  final Widget title;

  /// Heading confirm title for ScreenLock.
  final Widget confirmTitle;

  /// You can cancel and close the ScreenLock.
  final bool canCancel;

  /// Make sure the first and second inputs are the same.
  final bool confirmation;

  /// Set the maximum number of characters to enter when confirmation is true.
  final int digits;

  /// Called if the value matches the correctString.
  ///
  /// To close the screen, call `Navigator.pop(context)`.
  final void Function()? didUnlocked;

  /// Called when the first and second inputs match during confirmation.
  ///
  /// To close the screen, call `Navigator.pop(context)`.
  final void Function(String matchedText)? didConfirmed;

  /// Called if the value does not match the correctString.
  final void Function(int retries)? didError;

  /// `0` is unlimited.
  /// For example, if it is set to 1, didMaxRetries will be called on the first failure.
  final int maxRetries;

  /// Events that have reached the maximum number of attempts.
  final void Function(int retries)? didMaxRetries;

  /// Tapped for left side lower button.
  final Future<void> Function()? customizedButtonTap;

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

  @override
  _ScreenLockState createState() => _ScreenLockState();
}

class _ScreenLockState extends State<ScreenLock> {
  late InputController inputController;

  /// Logging retries.
  int retries = 1;

  /// First input completed.
  bool firstInputCompleted = false;

  String firstInput = '';

  void unlocked() {
    if (widget.didUnlocked != null) {
      widget.didUnlocked!();
      return;
    }

    Navigator.pop(context);
  }

  void error() {
    if (widget.didError != null) {
      widget.didError!(retries);
    }

    if (widget.maxRetries >= 1 && widget.maxRetries <= retries) {
      widget.didMaxRetries!(retries);
    }

    retries++;
  }

  Widget buildHeadingText() {
    if (widget.confirmation) {
      return StreamBuilder<bool>(
        stream: inputController.confirmed,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            return widget.confirmTitle;
          }
          return widget.title;
        },
      );
    }

    return widget.title;
  }

  ThemeData makeThemeData() {
    if (widget.screenLockConfig.themeData != null) {
      return widget.screenLockConfig.themeData!;
    }

    return ScreenLockConfig.defaultThemeData;
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
          if (widget.didConfirmed != null) {
            widget.didConfirmed!(inputController.confirmedInput);
          }
        } else {
          unlocked();
        }
      } else {
        error();
      }
    });
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
    return WillPopScope(
      onWillPop: () async => widget.canCancel,
      child: Theme(
        data: makeThemeData(),
        child: Scaffold(
          backgroundColor: widget.screenLockConfig.backgroundColor,
          body: SafeArea(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildHeadingText(),
                    Secrets(
                      config: widget.secretsConfig,
                      length: secretLength,
                      inputStream: inputController.currentInput,
                      verifyStream: inputController.verifyInput,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: KeyPad(
                        inputButtonConfig: widget.inputButtonConfig,
                        inputState: inputController,
                        canCancel: widget.canCancel,
                        customizedButtonTap: widget.custmizedButtonTap,
                        customizedButtonChild: widget.customizedButtonChild,
                        deleteButton: widget.deleteButton,
                        cancelButton: widget.cancelButton,
                      ),
                    ),
                    widget.footer ?? Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
