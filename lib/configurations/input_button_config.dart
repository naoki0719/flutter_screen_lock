import 'package:flutter/material.dart';

class StyledInputConfig {
  /// Button height
  final double height;

  /// Button width
  final double width;

  /// Automatically adjust the size of the square to fit the orientation of the device.
  ///
  /// Default: `true`
  final bool autoSize;

  /// It is recommended that you use [OutlinedButton.styleFrom()] to change it.
  final ButtonStyle buttonStyle;

  const StyledInputConfig({
    this.height,
    this.width,
    this.autoSize = true,
    this.buttonStyle,
  });
}

class InputButtonConfig extends StyledInputConfig {
  static TextStyle getDefaultTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.height * 0.045,
    );
  }

  final TextStyle textStyle;
  const InputButtonConfig({
    double height,
    double width,
    bool autoSize = true,
    ButtonStyle buttonStyle,
    this.textStyle,
  }) : super(
            autoSize: autoSize,
            height: height,
            width: width,
            buttonStyle: buttonStyle);
}
