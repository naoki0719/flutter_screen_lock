import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:flutter_screen_lock/src/layout/key_pad.dart';

/// Animated ScreenLock
///
/// - `correctString`: Input correct string (Required).
/// - `onUnlocked`: Called if the value matches the correctString.
/// - `onOpened`: For example, when you want to perform biometric authentication.
/// - `onValidate`: Callback to validate input values filled in [digits].
/// - `onCancelled`: Called when the user cancels the screen.
/// - `onError`: Called if the value does not match the correctString.
/// - `onMaxRetries`: Events that have reached the maximum number of attempts.
/// - `maxRetries`: `0` is unlimited. For example, if it is set to 1, didMaxRetries will be called on the first failure. Default `0`.
/// - `retryDelay`: Delay until we can retry. Duration.zero is no delay.
/// - `title`: Change the title widget.
/// - `screenLockConfig`: Configurations of [ScreenLock].
/// - `secretsConfig`: Configurations of [Secrets].
/// - `keyPadConfig`: Configuration of [KeyPad].
/// - `delayBuilder`: Specify the widget during input invalidation by retry delay.
/// - `customizedButtonChild`: Child for bottom left side button.
/// - `customizedButtonTap`: Tapped for left side lower button.
/// - `footer`: Add a Widget to the footer.
/// - `cancelButton`: Change the child widget for the delete button.
/// - `deleteButton`: Change the child widget for the delete button.
/// - `inputController`: Control inputs externally.
/// - `secretsBuilder`: Custom secrets animation widget builder.
/// - `useBlur`: Blur the background.
/// - `useLandscape`: Use a landscape orientation. Default `true`.
/// - `canCancel`: `true` is show cancel button.
Future<void> screenLock({
  required BuildContext context,
  required String correctString,
  VoidCallback? onUnlocked,
  VoidCallback? onOpened,
  ValidationCallback? onValidate,
  VoidCallback? onCancelled,
  ValueChanged<int>? onError,
  ValueChanged<int>? onMaxRetries,
  int maxRetries = 0,
  Duration retryDelay = Duration.zero,
  Widget? title,
  ScreenLockConfig? config,
  SecretsConfig? secretsConfig,
  KeyPadConfig? keyPadConfig,
  DelayBuilderCallback? delayBuilder,
  Widget? customizedButtonChild,
  VoidCallback? customizedButtonTap,
  Widget? footer,
  Widget? cancelButton,
  Widget? deleteButton,
  InputController? inputController,
  SecretsBuilderCallback? secretsBuilder,
  bool useBlur = true,
  bool useLandscape = true,
  bool canCancel = true,
}) async {
  return Navigator.push<void>(
    context,
    PageRouteBuilder<void>(
      opaque: false,
      barrierColor: Colors.black.withOpacity(0.8),
      pageBuilder: (context, animation, secondaryAnimation) => PopScope(
        canPop: canCancel && onCancelled == null,
        child: ScreenLock(
          correctString: correctString,
          onUnlocked: onUnlocked ?? Navigator.of(context).pop,
          onOpened: onOpened,
          onValidate: onValidate,
          onCancelled:
              canCancel ? onCancelled ?? Navigator.of(context).pop : null,
          onError: onError,
          onMaxRetries: onMaxRetries,
          maxRetries: maxRetries,
          retryDelay: retryDelay,
          title: title,
          config: config,
          secretsConfig: secretsConfig,
          keyPadConfig: keyPadConfig,
          delayBuilder: delayBuilder,
          customizedButtonChild: customizedButtonChild,
          customizedButtonTap: customizedButtonTap,
          footer: footer,
          cancelButton: cancelButton,
          deleteButton: deleteButton,
          inputController: inputController,
          secretsBuilder: secretsBuilder,
          useBlur: useBlur,
          useLandscape: useLandscape,
        ),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 2.4),
          end: Offset.zero,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(0.0, 2.4),
          ).animate(secondaryAnimation),
          child: child,
        ),
      ),
    ),
  );
}

/// Animated ScreenLock
///
/// - `onConfirmed`: Called when the first and second inputs match during confirmation.
/// - `onOpened`: For example, when you want to perform biometric authentication.
/// - `onValidate`: Callback to validate input values filled in [digits].
/// - `onCancelled`: Called when the user cancels the screen.
/// - `onError`: Called if the value does not match the correctString.
/// - `onMaxRetries`: Events that have reached the maximum number of attempts.
/// - `maxRetries`: `0` is unlimited. For example, if it is set to 1, didMaxRetries will be called on the first failure. Default `0`.
/// - `digits`: Set the maximum number of characters to enter.
/// - `retryDelay`: Delay until we can retry. Duration.zero is no delay.
/// - `title`: Change the title widget.
/// - `confirmTitle`: Change the confirm title widget.
/// - `screenLockConfig`: Configurations of [ScreenLock].
/// - `secretsConfig`: Configurations of [Secrets].
/// - `keyPadConfig`: Configuration of [KeyPad].
/// - `delayBuilder`: Specify the widget during input invalidation by retry delay.
/// - `customizedButtonChild`: Child for bottom left side button.
/// - `customizedButtonTap`: Tapped for left side lower button.
/// - `footer`: Add a Widget to the footer.
/// - `cancelButton`: Change the child widget for the delete button.
/// - `deleteButton`: Change the child widget for the delete button.
/// - `inputController`: Control inputs externally.
/// - `secretsBuilder`: Custom secrets animation widget builder.
/// - `useBlur`: Blur the background.
/// - `useLandscape`: Use a landscape orientation. Default `true`.
/// - `canCancel`: `true` is show cancel button.
Future<void> screenLockCreate({
  required BuildContext context,
  required ValueChanged<String> onConfirmed,
  VoidCallback? onOpened,
  ValidationCallback? onValidate,
  VoidCallback? onCancelled,
  ValueChanged<int>? onError,
  ValueChanged<int>? onMaxRetries,
  int maxRetries = 0,
  int digits = 4,
  Duration retryDelay = Duration.zero,
  Widget? title,
  Widget? confirmTitle,
  ScreenLockConfig? config,
  SecretsConfig? secretsConfig,
  KeyPadConfig? keyPadConfig,
  DelayBuilderCallback? delayBuilder,
  Widget? customizedButtonChild,
  VoidCallback? customizedButtonTap,
  Widget? footer,
  Widget? cancelButton,
  Widget? deleteButton,
  InputController? inputController,
  SecretsBuilderCallback? secretsBuilder,
  bool useBlur = true,
  bool useLandscape = true,
  bool canCancel = true,
}) async {
  return Navigator.push<void>(
    context,
    PageRouteBuilder<void>(
      opaque: false,
      barrierColor: Colors.black.withOpacity(0.8),
      pageBuilder: (context, animation, secondaryAnimation) => PopScope(
        canPop: canCancel && onCancelled == null,
        child: ScreenLock.create(
          onConfirmed: onConfirmed,
          onOpened: onOpened,
          onValidate: onValidate,
          onCancelled:
              canCancel ? onCancelled ?? Navigator.of(context).pop : null,
          onError: onError,
          onMaxRetries: onMaxRetries,
          maxRetries: maxRetries,
          digits: digits,
          retryDelay: retryDelay,
          title: title,
          confirmTitle: confirmTitle,
          config: config,
          secretsConfig: secretsConfig,
          keyPadConfig: keyPadConfig,
          delayBuilder: delayBuilder,
          customizedButtonChild: customizedButtonChild,
          customizedButtonTap: customizedButtonTap,
          footer: footer,
          cancelButton: cancelButton,
          deleteButton: deleteButton,
          inputController: inputController,
          secretsBuilder: secretsBuilder,
          useBlur: useBlur,
          useLandscape: useLandscape,
        ),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 2.4),
          end: Offset.zero,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(0.0, 2.4),
          ).animate(secondaryAnimation),
          child: child,
        ),
      ),
    ),
  );
}
