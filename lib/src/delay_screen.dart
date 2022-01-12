import 'package:flutter/material.dart';

class DelayScreen extends StatelessWidget {
  const DelayScreen({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child != null
          ? child!
          : const Center(
              child: Text('Temporarily unable to input'),
            ),
    );
  }
}
