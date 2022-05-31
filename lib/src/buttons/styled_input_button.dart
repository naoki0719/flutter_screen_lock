import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/src/configurations/input_button_config.dart';

/// [OutlinedButton] based button.
abstract class StyledInputButton extends StatelessWidget {
  const StyledInputButton({
    Key? key,
    StyledInputConfig? config,
    required this.onPressed,
    this.onLongPress,
  })  : config = config ?? const StyledInputConfig(),
        super(key: key);

  final StyledInputConfig config;
  final void Function() onPressed;
  final void Function()? onLongPress;

  double computeHeight(Size boxSize) {
    if (config.autoSize) {
      return _computeAutoSize(boxSize);
    }

    return boxSize.height;
  }

  double computeWidth(Size boxSize) {
    if (config.autoSize) {
      return _computeAutoSize(boxSize);
    }

    return boxSize.width;
  }

  Size defaultSize(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return Size(
        config.height ?? MediaQuery.of(context).size.height * 0.125,

        /// Subtract padding(horizontal: 50) from screen_lock.dart to calculate
        config.width ?? (MediaQuery.of(context).size.width - 100) * 0.14,
      );
    }

    return Size(
      config.height ?? MediaQuery.of(context).size.height * 0.6 * 0.16,

      /// Subtract padding(horizontal: 50) from screen_lock.dart to calculate
      config.width ?? (MediaQuery.of(context).size.width - 100) * 0.22,
    );
  }

  EdgeInsetsGeometry defaultMargin() {
    return const EdgeInsets.all(10);
  }

  double _computeAutoSize(Size size) {
    return size.width < size.height ? size.width : size.height;
  }

  /// Make default style from [OutlinedButton]
  ///
  /// Override this to customize the style.
  ButtonStyle makeDefaultStyle() {
    return config.buttonStyle ?? OutlinedButton.styleFrom();
  }

  Widget makeKeyContainer({
    required BuildContext context,
    required Widget? child,
  }) {
    final boxSize = defaultSize(context);
    return Container(
      height: computeHeight(boxSize),
      width: computeWidth(boxSize),
      margin: const EdgeInsets.all(10),
      child: OutlinedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: makeDefaultStyle(),
        child: child ?? const Text(''),
      ),
    );
  }
}
