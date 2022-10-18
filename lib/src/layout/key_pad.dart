import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/src/configurations/key_pad_config.dart';
import 'package:flutter_screen_lock/src/layout/key_pad_button.dart';
import 'package:flutter_screen_lock/src/input_controller.dart';

/// [GridView] or [Wrap] make it difficult to specify the item size intuitively.
/// We therefore arrange them manually with [Column]s and [Row]s
class KeyPad extends StatelessWidget {
  const KeyPad({
    super.key,
    required this.inputState,
    required this.didCancelled,
    this.enabled = true,
    KeyPadConfig? keyPadConfig,
    this.customizedButtonChild,
    this.customizedButtonTap,
    this.deleteButton,
    this.cancelButton,
  }) : keyPadConfig = keyPadConfig ?? const KeyPadConfig();

  final InputController inputState;
  final VoidCallback? didCancelled;
  final bool enabled;
  final KeyPadConfig keyPadConfig;
  final Widget? customizedButtonChild;
  final VoidCallback? customizedButtonTap;
  final Widget? deleteButton;
  final Widget? cancelButton;

  Widget _buildDeleteButton() {
    return KeyPadButton.transparent(
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

    return KeyPadButton.transparent(
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
    return KeyPadButton.transparent(
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

    return KeyPadButton.transparent(
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

        return KeyPadButton(
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
        KeyPadButton(
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
