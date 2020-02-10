import 'package:flutter/material.dart';

class CircleInputButton extends StatelessWidget {
  final String text;
  final Sink<String> enteredSink;

  CircleInputButton({
    @required this.text,
    @required this.enteredSink,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.095,
    );

    return RaisedButton(
      child: Text(
        text,
        style: textStyle,
      ),
      onPressed: () {
        enteredSink.add(text);
      },
      shape: CircleBorder(
        side: BorderSide(
          color: Colors.transparent,
          width: 0,
          style: BorderStyle.solid,
        ),
      ),
      color: Colors.grey.shade600.withOpacity(0.4),
      elevation: 0,
    );
  }
}
