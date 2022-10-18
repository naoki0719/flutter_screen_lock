import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

/// Animated ScreenLock
///
/// - `correctString`: Input correct string (Required).
///   If [confirmation] is `true`, it will be ignored, so set it to any string or empty.
/// - `screenLockConfig`: Configurations of [ScreenLock]
/// - `secretsConfig`: Configurations of [Secrets]
/// - `inputButtonConfig`: Configurations of [InputButton]
/// - `canCancel`: `true` is show cancel button
/// - `confirmation`: Make sure the first and second inputs are the same.
/// - `digits`: Set the maximum number of characters to enter when [confirmation] is `true`.
/// - `maxRetries`: `0` is unlimited. For example, if it is set to 1, didMaxRetries will be called on the first failure. Default `0`
/// - `retryDelay`: Delay until we can retry. Duration.zero is no delay.
/// - `delayChild`: Specify the widget during input invalidation by retry delay.
/// - `onUnlocked`: Called if the value matches the correctString.
/// - `onValidate`: Callback to validate input values filled in [digits].
/// - `onError`: Called if the value does not match the correctString.
/// - `onMaxRetries`: Events that have reached the maximum number of attempts
/// - `onOpened`: For example, when you want to perform biometric authentication
/// - `onConfirmed`: Called when the first and second inputs match during confirmation
/// - `onCancelled`: Called when the user cancels the screen
/// - `customizedButtonTap`: Tapped for left side lower button
/// - `customizedButtonChild`: Child for bottom left side button
/// - `footer`: Add a Widget to the footer
/// - `cancelButton`: Change the child widget for the delete button
/// - `deleteButton`: Change the child widget for the delete button
/// - `title`: Change the title widget
/// - `confirmTitle`: Change the confirm title widget
/// - `inputController`: Control inputs externally
/// - `withBlur`: Blur the background
/// - `secretsBuilder`: Custom secrets animation widget builder
/// - `useLandscape`: Use a landscape orientation. Default `true`
Future<void> screenLock({
  required BuildContext context,
  required String correctString,
  VoidCallback? onUnlocked,
  ValidationCallback? onValidate,
  VoidCallback? onOpened,
  VoidCallback? onCancelled,
  void Function(String matchedText)? onConfirmed,
  void Function(int retries)? onError,
  void Function(int retries)? onMaxRetries,
  VoidCallback? customizedButtonTap,
  bool confirmation = false,
  bool canCancel = true,
  int digits = 4,
  int maxRetries = 0,
  Duration retryDelay = Duration.zero,
  Widget? title,
  Widget? confirmTitle,
  ScreenLockConfig? screenLockConfig,
  SecretsConfig? secretsConfig,
  KeyPadConfig? keyPadConfig,
  DelayBuilderCallback? delayBuilder,
  Widget? customizedButtonChild,
  Widget? footer,
  Widget? cancelButton,
  Widget? deleteButton,
  InputController? inputController,
  SecretsBuilderCallback? secretsBuilder,
  bool useBlur = true,
  bool useLandscape = true,
}) async {
  return Navigator.push<void>(
    context,
    PageRouteBuilder<void>(
      opaque: false,
      barrierColor: Colors.black.withOpacity(0.8),
      pageBuilder: (context, animation, secondaryAnimation) => WillPopScope(
        onWillPop: () async => canCancel && onCancelled == null,
        child: ScreenLock(
          correctString: correctString,
          screenLockConfig: screenLockConfig,
          secretsConfig: secretsConfig,
          keyPadConfig: keyPadConfig,
          onCancelled:
              canCancel ? onCancelled ?? Navigator.of(context).pop : null,
          confirmation: confirmation,
          digits: digits,
          maxRetries: maxRetries,
          retryDelay: retryDelay,
          delayBuilder: delayBuilder,
          onUnlocked: onUnlocked ?? Navigator.of(context).pop,
          onError: onError,
          onMaxRetries: onMaxRetries,
          onConfirmed: onConfirmed,
          onOpened: onOpened,
          customizedButtonTap: customizedButtonTap,
          customizedButtonChild: customizedButtonChild,
          footer: footer,
          deleteButton: deleteButton,
          cancelButton: cancelButton,
          title: title,
          confirmTitle: confirmTitle,
          inputController: inputController,
          useBlur: useBlur,
          secretsBuilder: secretsBuilder,
          useLandscape: useLandscape,
          onValidate: onValidate,
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
