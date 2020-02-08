import 'dart:async';

import 'package:flutter/material.dart';

class DotSecretConfig {
  final double dotSize;
  final EdgeInsetsGeometry padding;
  final Color enabledColor;
  final Color disabledColor;
  final Color dotBorderColor;

  const DotSecretConfig({
    this.dotSize = 13.0,
    this.dotBorderColor = Colors.black54,
    this.padding = const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
    this.enabledColor = Colors.black54,
    this.disabledColor = Colors.transparent,
  });
}

class DotSecretUI extends StatelessWidget {
  final DotSecretConfig config;
  final Stream<int> enteredLengthStream;
  final int dots;

  const DotSecretUI({
    @required this.enteredLengthStream,
    @required this.dots,
    this.config = const DotSecretConfig(),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: config.padding,
      child: StreamBuilder<int>(
        stream: enteredLengthStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List<Widget>.generate(
                dots,
                // index less than the input digit is true
                (index) => _buildCircle(index < snapshot.data),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildCircle(bool enabled) {
    return Container(
      width: config.dotSize,
      height: config.dotSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: enabled ? config.enabledColor : config.disabledColor,
        border: Border.all(width: 1, color: config.dotBorderColor),
      ),
    );
  }
}
