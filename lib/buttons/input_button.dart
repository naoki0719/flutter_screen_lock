import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/buttons/styled_input_button.dart';
import 'package:flutter_screen_lock/configurations/input_button_config.dart';

class InputButton extends StyledInputButton {
  final String displayText;

  @override
  final InputButtonConfig config;

  const InputButton({
    required this.displayText,
    required Function() onPressed,
    this.config = const InputButtonConfig(),
  }) : super(onPressed: onPressed, config: config);

  @override
  ButtonStyle makeDefaultStyle() {
    return super.makeDefaultStyle();
  }

  @override
  Widget build(BuildContext context) {
    final text = Text(
      displayText,
      style: config.textStyle ?? InputButtonConfig.getDefaultTextStyle(context),
    );

    return makeKeyContainer(child: text, context: context);
  }
}
