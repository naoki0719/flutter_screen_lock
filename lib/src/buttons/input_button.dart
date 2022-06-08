import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/src/buttons/styled_input_button.dart';
import 'package:flutter_screen_lock/src/configurations/input_button_config.dart';

class InputButton extends StyledInputButton {
  const InputButton({
    Key? key,
    required this.displayText,
    required VoidCallback? onPressed,
    InputButtonConfig? config,
  })  : config = config ?? const InputButtonConfig(),
        super(key: key, onPressed: onPressed, config: config);

  final String displayText;

  @override
  // ignore: overridden_fields
  final InputButtonConfig config;

  @override
  Widget build(BuildContext context) {
    final text = Text(
      displayText,
      style: config.textStyle ?? InputButtonConfig.getDefaultTextStyle(context),
    );

    return makeKeyContainer(child: text, context: context);
  }
}
