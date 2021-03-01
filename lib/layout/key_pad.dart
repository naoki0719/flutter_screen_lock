import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/buttons/cancel_button.dart';
import 'package:flutter_screen_lock/buttons/customizable_button.dart';
import 'package:flutter_screen_lock/buttons/delete_button.dart';
import 'package:flutter_screen_lock/buttons/hidden_button.dart';
import 'package:flutter_screen_lock/buttons/input_button.dart';
import 'package:flutter_screen_lock/configurations/input_button_config.dart';
import 'package:flutter_screen_lock/input_state.dart';

/// In order to arrange the buttons neatly by their size,
/// I dared to adjust them without using GridView or Wrap.
/// If you use GridView, you have to specify the overall width to adjust the size of the button,
/// which makes it difficult to specify the size intuitively.
class KeyPad extends StatelessWidget {
  final InputState inputState;
  final bool canCancel;
  final Widget customizedButtonChild;
  final Future<void> Function() customizedButtonTap;
  final InputButtonConfig inputButtonConfig;
  final Widget cancelButton;
  final Widget deleteButton;

  const KeyPad({
    @required this.inputState,
    @required this.canCancel,
    @required this.customizedButtonChild,
    @required this.customizedButtonTap,
    this.inputButtonConfig = const InputButtonConfig(),
    this.deleteButton,
    this.cancelButton,
  });

  Widget _buildRightSideButton() {
    return StreamBuilder<String>(
      stream: inputState.currentInput,
      builder: (context, snapshot) {
        if (snapshot.hasData == false || snapshot.data.isEmpty) {
          if (canCancel) {
            return CancelButton(
              child: cancelButton,
              onPressed: () {
                Navigator.pop(context);
              },
            );
          }
          return HiddenButton();
        } else {
          return DeleteButton(
            child: deleteButton,
            onPressed: () => inputState.removeCharacter(),
          );
        }
      },
    );
  }

  Widget _buildLeftSideButton() {
    if (customizedButtonChild == null) {
      return HiddenButton();
    }

    return CustomizableButton(
      child: customizedButtonChild,
      onPressed: customizedButtonTap,
    );
  }

  Widget _generateRow(BuildContext context, int rowNumber) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
