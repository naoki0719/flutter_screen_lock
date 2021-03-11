import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/buttons/styled_input_button.dart';
import 'package:flutter_screen_lock/configurations/input_button_config.dart';

/// Hidden button.
class HiddenButton extends StyledInputButton {
  HiddenButton({
    Key? key,
    this.child = const Text(''),
    InputButtonConfig config = const InputButtonConfig(),
  }) : super(key: key, onPressed: () {}, config: config);

  final Widget child;

  @override
  ButtonStyle makeDefaultStyle() {
    return super.makeDefaultStyle().copyWith(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        );
  }

  @override
  Widget build(BuildContext context) {
    return makeKeyContainer(child: child, context: context);
  }
}
