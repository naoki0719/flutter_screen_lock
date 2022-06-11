import 'package:flutter_screen_lock/flutter_screen_lock.dart';

class KeyPadConfig {
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

  final StyledInputConfig? buttonConfig;
  final List<String> inputStrings;
  final List<String> displayStrings;
  final bool clearOnLongPressed;

  const KeyPadConfig({
    this.buttonConfig,
    this.inputStrings = _numbers,
    List<String>? displayStrings,
    this.clearOnLongPressed = false,
  }) : displayStrings = displayStrings ?? inputStrings;
}
