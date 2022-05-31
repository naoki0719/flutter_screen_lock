import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/src/buttons/cancel_button.dart';
import 'package:flutter_screen_lock/src/buttons/customizable_button.dart';
import 'package:flutter_screen_lock/src/buttons/delete_button.dart';
import 'package:flutter_screen_lock/src/buttons/hidden_button.dart';
import 'package:flutter_screen_lock/src/buttons/input_button.dart';
import 'package:flutter_screen_lock/src/configurations/input_button_config.dart';
import 'package:flutter_screen_lock/src/input_controller.dart';

/// In order to arrange the buttons neatly by their size,
/// I dared to adjust them without using GridView or Wrap.
/// If you use GridView, you have to specify the overall width to adjust the size of the button,
/// which makes it difficult to specify the size intuitively.
class KeyPad extends StatelessWidget {
  const KeyPad({
    Key? key,
    required this.inputState,
    required this.didCancelled,
    InputButtonConfig? inputButtonConfig,
    this.customizedButtonChild,
    this.customizedButtonTap,
    this.deleteButton,
    this.cancelButton,
  })  : inputButtonConfig = inputButtonConfig ?? const InputButtonConfig(),
        super(key: key);

  final InputController inputState;
  final InputButtonConfig inputButtonConfig;
  final Widget? customizedButtonChild;
  final void Function()? didCancelled;
  final void Function()? customizedButtonTap;
  final Widget? cancelButton;
  final Widget? deleteButton;

  Widget _buildRightSideButton() {
    return ValueListenableBuilder<String>(
      valueListenable: inputState.currentInput,
      builder: (context, value, child) {
        if (value.isEmpty) {
          if (didCancelled != null) {
            return CancelButton(
              onPressed: didCancelled!,
              config: inputButtonConfig,
              child: cancelButton,
            );
          }
          return HiddenButton(config: inputButtonConfig);
        } else {
          return DeleteButton(
            onPressed: () => inputState.removeCharacter(),
            onLongPress: inputButtonConfig.clearOnLongPressed
                ? () => inputState.clear()
                : null,
            config: inputButtonConfig,
            child: deleteButton,
          );
        }
      },
    );
  }

  Widget _buildLeftSideButton() {
    if (customizedButtonChild == null) {
      return HiddenButton(config: inputButtonConfig);
    }

    return CustomizableButton(
      onPressed: customizedButtonTap!,
      child: customizedButtonChild!,
    );
  }

  Widget _generateRow(BuildContext context, int rowNumber) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final number = (rowNumber - 1) * 3 + index + 1;
        final input = inputButtonConfig.inputStrings[number];
        final display = inputButtonConfig.displayStrings[number];

        return InputButton(
          config: inputButtonConfig,
          onPressed: () => inputState.addCharacter(input),
          displayText: display,
        );
      }),
    );
  }

  Widget _generateLastRow(BuildContext context) {
    final input = inputButtonConfig.inputStrings[0];
    final display = inputButtonConfig.displayStrings[0];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLeftSideButton(),
        InputButton(
          config: inputButtonConfig,
          onPressed: () => inputState.addCharacter(input),
          displayText: display,
        ),
        _buildRightSideButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(inputButtonConfig.displayStrings.length == 10);
    assert(inputButtonConfig.inputStrings.length == 10);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _generateRow(context, 1),
        _generateRow(context, 2),
        _generateRow(context, 3),
        _generateLastRow(context),
      ],
    );
  }
}
