import 'package:flutter_screen_lock/flutter_screen_lock.dart';

class KeyPadConfig {
  const KeyPadConfig({
    this.buttonConfig,
    this.actionButtonConfig,
    this.inputStrings = _numbers,
    List<String>? displayStrings,
    this.clearOnLongPressed = false,
  }) : displayStrings = displayStrings ?? inputStrings;

  /// Config for numeric [KeyPadButton]s.
  final KeyPadButtonConfig? buttonConfig;

  /// Config for actionable [KeyPadButton]s.
  final KeyPadButtonConfig? actionButtonConfig;

  /// The strings the user can input.
  final List<String> inputStrings;

  /// The strings that are displayed to the user.
  /// Mapped 1:1 to [inputStrings].
  /// Defaults to [inputStrings].
  final List<String> displayStrings;

  /// Whether to clear the input when long pressing the clear key.
  final bool clearOnLongPressed;

  static const List<String> _numbers = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];

  /// Copies a [KeyPadConfig] with new values.
  KeyPadConfig copyWith({
    KeyPadButtonConfig? buttonConfig,
    List<String>? inputStrings,
    List<String>? displayStrings,
    bool? clearOnLongPressed,
  }) {
    return KeyPadConfig(
      buttonConfig: buttonConfig ?? this.buttonConfig,
      inputStrings: inputStrings ?? this.inputStrings,
      displayStrings: displayStrings ?? this.displayStrings,
      clearOnLongPressed: clearOnLongPressed ?? this.clearOnLongPressed,
    );
  }
}
