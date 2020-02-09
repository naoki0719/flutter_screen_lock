import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dot_secret_ui.dart';
import 'circle_input_button.dart';

class LockScreen extends StatefulWidget {
  final String correctString;
  final String title;
  final int digits;
  final DotSecretConfig dotSecretConfig;

  LockScreen({
    this.correctString = '',
    this.title = 'Please enter passcode.',
    this.digits = 4,
    this.dotSecretConfig = const DotSecretConfig(),
  });

  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  // receive from circle input button
  final StreamController<String> enteredStream = StreamController<String>();
  final StreamController<int> enteredLengthStream = StreamController<int>();

  List<String> enteredValues = List<String>();

  _enteredStreamListener() {
    if (enteredStream.hasListener) {
      return;
    }

    enteredStream.stream.listen((value) {
      enteredValues.add(value);
      enteredLengthStream.add(enteredValues.length);

      // the same number of digits was entered.
      if (enteredValues.length == widget.digits) {
        StringBuffer buffer = StringBuffer();
        enteredValues.forEach((value) {
          buffer.write(value);
        });
        _verifyCorrectString(buffer.toString());
      }
    });
  }

  void _verifyCorrectString(String enteredValue) {
    if (enteredValue == widget.correctString) {
      // todo: add result to authenticated stream
    } else {
      // todo: failed process
    }
  }

  @override
  Widget build(BuildContext context) {
    _enteredStreamListener();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _buildTitle(),
            DotSecretUI(
              dots: widget.digits,
              config: widget.dotSecretConfig,
              enteredLengthStream: enteredLengthStream.stream,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildNumberTextButton(context, '1'),
                      _buildNumberTextButton(context, '2'),
                      _buildNumberTextButton(context, '3'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildNumberTextButton(context, '4'),
                      _buildNumberTextButton(context, '5'),
                      _buildNumberTextButton(context, '6'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildNumberTextButton(context, '7'),
                      _buildNumberTextButton(context, '8'),
                      _buildNumberTextButton(context, '9'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildNumberTextButton(context, ''),
                      _buildNumberTextButton(context, '0'),
                      _buildNumberTextButton(context, ''),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  CircleInputButton _buildNumberTextButton(
      BuildContext context, String number) {
    return CircleInputButton(
      enteredSink: enteredStream.sink,
      text: number,
    );
  }

  Widget _buildTitle() {
    return Container(
      child: Text(
        widget.title,
      ),
    );
  }

  @override
  void dispose() {
    enteredStream.close();
    enteredLengthStream.close();
    super.dispose();
  }
}
