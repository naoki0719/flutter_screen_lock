import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/src/configurations/styled_input_button_config.dart';

/// [OutlinedButton] based button.
class StyledInputButton extends StatelessWidget {
  const StyledInputButton({
    Key? key,
    this.child,
    required this.onPressed,
    this.onLongPress,
    StyledInputConfig? config,
  })  : config = config ?? const StyledInputConfig(),
        super(key: key);

  factory StyledInputButton.transparent({
    Key? key,
    Widget? child,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    StyledInputConfig? config,
  }) =>
      StyledInputButton(
        key: key,
        onPressed: onPressed,
        onLongPress: onLongPress,
        config: StyledInputConfig(
          height: config?.height,
          width: config?.width,
          autoSize: config?.autoSize ?? true,
          buttonStyle:
              (config?.buttonStyle ?? OutlinedButton.styleFrom()).copyWith(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
          ),
        ),
        child: child,
      );

  final Widget? child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final StyledInputConfig config;

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

  double _computeAutoSize(Size size) {
    return size.width < size.height ? size.width : size.height;
  }

  ButtonStyle _makeButtonStyle(BuildContext context) {
    return (config.buttonStyle ?? OutlinedButton.styleFrom()).copyWith(
      textStyle: MaterialStateProperty.all<TextStyle>(
        config.textStyle ?? StyledInputConfig.getDefaultTextStyle(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final boxSize = defaultSize(context);
    return Container(
      height: computeHeight(boxSize),
      width: computeWidth(boxSize),
      margin: const EdgeInsets.all(10),
      child: OutlinedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: _makeButtonStyle(context),
        child: child ?? const Text(''),
      ),
    );
  }
}
