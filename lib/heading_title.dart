import 'package:flutter/material.dart';

class HeadingTitle extends StatelessWidget {
  const HeadingTitle({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Text(
      text,
      style: themeData.textTheme.headline1,
    );
  }
}
