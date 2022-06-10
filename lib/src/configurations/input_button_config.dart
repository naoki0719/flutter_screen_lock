import 'package:flutter/material.dart';

class StyledInputConfig {
  const StyledInputConfig({
    this.height,
    this.width,
    this.autoSize = true,
    this.textStyle,
    this.buttonStyle,
  });

  // TextStyle for this button
  final TextStyle? textStyle;

  /// Button height
  final double? height;

  /// Button width
  final double? width;

  /// Automatically adjust the size of the square to fit the orientation of the device.
  ///
  /// Default: `true`
  final bool autoSize;

  /// It is recommended that you use [OutlinedButton.styleFrom()] to change it.
  final ButtonStyle? buttonStyle;

  /// Returns the default text style for buttons.
  static TextStyle getDefaultTextStyle(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.07,
      );
    }

    return TextStyle(
      fontSize: MediaQuery.of(context).size.height * 0.045,
    );
  }
}

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
