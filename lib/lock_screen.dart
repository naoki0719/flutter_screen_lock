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
  final StreamController<String> inputStream = StreamController<String>();
  final StreamController<int> inputLengthStream = StreamController<int>();

  // input data
  List<String> inputData = List<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _buildTitle(),
            DotSecretUI(
              dots: widget.digits,
              config: widget.dotSecretConfig,
              inputLengthStream: inputLengthStream.stream,
            ),
            Container(
              child: StreamBuilder(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // 入力値を保存する
                    inputData.add(snapshot.data);
                    inputLengthStream.add(inputData.length);
                    if (inputData.length == widget.digits) {
                      StringBuffer buffer = StringBuffer();
                      inputData.forEach((s) {
                        buffer.write(s);
                      });
                      inputData.clear();
                      return Text(buffer.toString());
                    }
                    return Text(snapshot.data);
                  }
                  return Container();
                },
                stream: inputStream.stream,
              ),
              alignment: Alignment.center,
              color: Colors.amber,
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
      inputSink: inputStream.sink,
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
    inputStream.close();
    inputLengthStream.close();
    super.dispose();
  }
}
