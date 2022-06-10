import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/src/layout/styled_input_button.dart';
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
    this.enabled = true,
    KeyPadConfig? keyPadConfig,
    this.customizedButtonChild,
    this.customizedButtonTap,
    this.deleteButton,
    this.cancelButton,
  })  : keyPadConfig = keyPadConfig ?? const KeyPadConfig(),
        super(key: key);

  final InputController inputState;
  final VoidCallback? didCancelled;
  final bool enabled;
  final KeyPadConfig keyPadConfig;
  final Widget? customizedButtonChild;
  final VoidCallback? customizedButtonTap;
  final Widget? deleteButton;
  final Widget? cancelButton;

  Widget _buildDeleteButton() {
    return StyledInputButton.transparent(
      onPressed: () => inputState.removeCharacter(),
      onLongPress:
          keyPadConfig.clearOnLongPressed ? () => inputState.clear() : null,
      config: keyPadConfig.buttonConfig,
      child: deleteButton ?? const Icon(Icons.backspace),
    );
  }

  Widget _buildCancelButton() {
    if (didCancelled == null) {
      return _buildHiddenButton();
    }

    return StyledInputButton.transparent(
      onPressed: didCancelled,
      config: keyPadConfig.buttonConfig,
      child: cancelButton ??
          const FittedBox(
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16,
              ),
              softWrap: false,
            ),
          ),
    );
  }

  Widget _buildHiddenButton() {
    return StyledInputButton.transparent(
      onPressed: () {},
      config: keyPadConfig.buttonConfig,
    );
  }

  Widget _buildRightSideButton() {
    return ValueListenableBuilder<String>(
      valueListenable: inputState.currentInput,
      builder: (context, value, child) {
        if (!enabled || value.isEmpty) {
          return _buildCancelButton();
        } else {
          return _buildDeleteButton();
        }
      },
    );
  }

  Widget _buildLeftSideButton() {
    if (customizedButtonChild == null) {
      return _buildHiddenButton();
    }

    return StyledInputButton.transparent(
      onPressed: customizedButtonTap!,
      config: keyPadConfig.buttonConfig,
      child: customizedButtonChild!,
    );
  }

  Widget _generateRow(BuildContext context, int rowNumber) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final number = (rowNumber - 1) * 3 + index + 1;
        final input = keyPadConfig.inputStrings[number];
        final display = keyPadConfig.displayStrings[number];

        return StyledInputButton(
          config: keyPadConfig.buttonConfig,
          onPressed: enabled ? () => inputState.addCharacter(input) : null,
          child: Text(display),
        );
      }),
    );
  }

  Widget _generateLastRow(BuildContext context) {
    final input = keyPadConfig.inputStrings[0];
    final display = keyPadConfig.displayStrings[0];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLeftSideButton(),
        StyledInputButton(
          config: keyPadConfig.buttonConfig,
          onPressed: enabled ? () => inputState.addCharacter(input) : null,
          child: Text(display),
        ),
        _buildRightSideButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(keyPadConfig.displayStrings.length == 10);
    assert(keyPadConfig.inputStrings.length == 10);

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
