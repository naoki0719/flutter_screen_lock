import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/src/buttons/styled_input_button.dart';
import 'package:flutter_screen_lock/src/configurations/input_button_config.dart';

class DeleteButton extends StyledInputButton {
  const DeleteButton({
    Key? key,
    this.child,
    required void Function() onPressed,
    InputButtonConfig config = const InputButtonConfig(),
  }) : super(key: key, onPressed: onPressed, config: config);

  final Widget? child;

  @override
  ButtonStyle makeDefaultStyle() {
    return super.makeDefaultStyle().copyWith(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        );
  }

  @override
  Widget build(BuildContext context) {
    return makeKeyContainer(
        child: child ?? const Icon(Icons.backspace), context: context);
  }
}
