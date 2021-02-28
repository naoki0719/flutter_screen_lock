import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/configurations/input_button_config.dart';
import 'package:flutter_screen_lock/configurations/screen_lock_config.dart';

import 'package:flutter_screen_lock/configurations/secrets_config.dart';
import 'package:flutter_screen_lock/heading_title.dart';
import 'package:flutter_screen_lock/input_state.dart';
import 'package:flutter_screen_lock/layout/key_pad.dart';
import 'package:flutter_screen_lock/layout/secrets.dart';

class ScreenLock extends StatefulWidget {
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
  final void Function() didUnlocked;

  /// Called when the first and second inputs match during confirmation.
  ///
  /// To close the screen, call `Navigator.pop(context)`.
  final void Function(String matchedText) didConfirmed;

  /// Called if the value does not match the correctString.
  final void Function(int retries) didError;

  /// `0` is unlimited.
  /// For example, if it is set to 1, didMaxRetries will be called on the first failure.
  final int maxRetries;

  /// Events that have reached the maximum number of attempts.
  final void Function(int retries) didMaxRetries;

  /// Tapped for left side lower button.
  final Future<void> Function() custmizedButtonTap;

  /// Child for bottom left side button.
  final Widget customizedButtonChild;

  /// Footer widget.
  final Widget footer;

  /// Cancel button widget.
  final Widget cancelButton;

  /// delete button widget.
  final Widget deleteButton;

  ScreenLock({
    @required this.correctString,
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
    this.custmizedButtonTap,
    this.customizedButtonChild,
    this.footer,
    this.cancelButton,
    this.deleteButton,
  }) : assert(maxRetries > -1);

  @override
  _ScreenLockState createState() => _ScreenLockState();
}

class _ScreenLockState extends State<ScreenLock> {
  final inputState = InputState();

  /// Logging retries.
  int retries = 1;

  /// First input completed.
  bool firstInputCompleted = false;

  String firstInput = '';

  void unlocked() {
    if (widget.didUnlocked != null) {
      widget.didUnlocked();
      return;
    }

    Navigator.pop(context);
  }

  void error() {
    if (widget.didError != null) {
      widget.didError(retries);
    }

    if (widget.maxRetries >= 1 && widget.maxRetries <= retries) {
      widget.didMaxRetries(retries);
    }

    retries++;
  }

  Widget buildHeadingText() {
    if (widget.confirmation) {
      return StreamBuilder<bool>(
        stream: inputState.confirmed,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data) {
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
      return widget.screenLockConfig.themeData;
    }

    return ScreenLockConfig.defaultThemeData;
  }

  /// Verifying correctString.
  void inputListener() {
    inputState.currentInput.listen((text) {
      if (widget.correctString.length > text.length) {
        return;
      }

      inputState.verify(widget.correctString);
    });
  }

  /// Verifying first input string.
  void confirmInputListener() {
    inputState.currentInput.listen((text) {
      if (widget.digits > text.length) {
        return;
      }

      if (!firstInputCompleted) {
        firstInput = text;
        firstInputCompleted = true;
        inputState.clear();
        inputState.setConfirmed();
      } else {
        inputState.verify(firstInput);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    inputState.initialize(widget.confirmation);

    if (widget.confirmation) {
      confirmInputListener();
    } else {
      inputListener();
    }

    inputState.verifyInput.listen((success) {
      // Wait for the animation on failure.
      Future.delayed(Duration(milliseconds: 300), () {
        inputState.clear();
      });

      if (success) {
        if (widget.confirmation) {
          if (widget.didConfirmed != null) {
            widget.didConfirmed(firstInput);
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
    inputState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final secretLength =
        widget.confirmation ? widget.digits : widget.correctString.length;
    return Theme(
      data: makeThemeData(),
      child: Scaffold(
        backgroundColor: widget.screenLockConfig.backgroundColor,
        body: SafeArea(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildHeadingText(),
                  Secrets(
                    config: widget.secretsConfig,
                    length: secretLength,
                    inputStream: inputState.currentInput,
                    verifyStream: inputState.verifyInput,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: KeyPad(
                      inputButtonConfig: widget.inputButtonConfig,
                      inputState: inputState,
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
    );
  }
}
