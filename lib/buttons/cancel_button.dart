import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/buttons/styled_input_button.dart';
import 'package:flutter_screen_lock/configurations/input_button_config.dart';

class CancelButton extends StyledInputButton {
  const CancelButton({
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
    final defaultChild = const Text(
      'Cancel',
      style: TextStyle(
        fontSize: 16,
      ),
      softWrap: false,
    );
    return makeKeyContainer(child: child ?? defaultChild, context: context);
  }
}
