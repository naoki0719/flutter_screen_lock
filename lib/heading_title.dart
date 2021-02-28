import 'package:flutter/material.dart';

class HeadingTitle extends StatelessWidget {
  final String text;

  const HeadingTitle({
    @required this.text,
  }) : assert(text != null);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Text(
      text,
      style: themeData.textTheme.headline1,
    );
  }
}
