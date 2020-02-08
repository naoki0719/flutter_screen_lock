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
      fontSize: MediaQuery.of(context).size.width / 10,
    );

    return Container(
      child: RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width / 18,
          ),
          child: Text(
            text,
            style: textStyle,
          ),
        ),
        onPressed: () {
          enteredSink.add(text);
        },
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.black,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        color: Colors.transparent,
        elevation: 0,
      ),
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width / 45,
      ),
    );
  }
}
