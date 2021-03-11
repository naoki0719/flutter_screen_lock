import 'package:flutter/material.dart';

class StyledInputConfig {
  const StyledInputConfig({
    this.height,
    this.width,
    this.autoSize = true,
    this.buttonStyle,
  });

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
}

class InputButtonConfig extends StyledInputConfig {
  const InputButtonConfig({
    double? height,
    double? width,
    bool autoSize = true,
    ButtonStyle? buttonStyle,
    this.textStyle,
    this.inputStrings = const [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9'
    ],
    this.displayStrings = const [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9'
    ],
  }) : super(
          autoSize: autoSize,
          height: height,
          width: width,
          buttonStyle: buttonStyle,
        );

  static TextStyle getDefaultTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.height * 0.045,
    );
  }

  final TextStyle? textStyle;
  final List<String> inputStrings;
  final List<String> displayStrings;
}
