import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dot_secret_ui.dart';
import 'circle_input_button.dart';

Future showLockScreen({
  @required BuildContext context,
  String correctString,
  String title = 'Please enter passcode.',
  Widget leftSideInput,
  int digits = 4,
  DotSecretConfig dotSecretConfig = const DotSecretConfig(),
  void Function(BuildContext, String) onCompleted,
}) {
  return Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secodaryAnimation,
      ) {
        return LockScreen(
          correctString: correctString,
          title: title,
          leftSideInput: leftSideInput,
          digits: digits,
          dotSecretConfig: dotSecretConfig,
          onCompleted: onCompleted,
        );
      },
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 0.01),
            end: Offset.zero,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(0.0, 0.01),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      },
    ),
  );
}

class LockScreen extends StatefulWidget {
  final String correctString;
  final String title;
  final Widget rightSideInput;
  final Widget leftSideInput;
  final int digits;
  final DotSecretConfig dotSecretConfig;
  final void Function(BuildContext, String) onCompleted;

  LockScreen({
    this.correctString,
    this.title = 'Please enter passcode.',
    this.digits = 4,
    this.dotSecretConfig = const DotSecretConfig(),
    this.rightSideInput,
    this.leftSideInput,
    this.onCompleted,
  });

  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  // receive from circle input button
  final StreamController<String> enteredStream = StreamController<String>();
  final StreamController<int> enteredLengthStream = StreamController<int>();
  final StreamController<bool> authenticatedStream = StreamController<bool>();

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
      // authenticatedStream.add(true);
      enteredValues.clear();
      enteredLengthStream.add(enteredValues.length);

      if (widget.onCompleted != null) {
        // call user function
        widget.onCompleted(context, enteredValue);
      } else {
        Navigator.of(context).maybePop();
      }
    } else {
      // todo: failed process
      // authenticatedStream.add(false);
      enteredValues.clear();
      enteredLengthStream.add(enteredValues.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    _enteredStreamListener();
    double _rowMarginSize = MediaQuery.of(context).size.width * 0.025;
    double _columnMarginSize = MediaQuery.of(context).size.width * 0.065;

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.7),
      body: SafeArea(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
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
                horizontal: _columnMarginSize,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: _rowMarginSize),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildNumberTextButton(context, '1'),
                        _buildNumberTextButton(context, '2'),
                        _buildNumberTextButton(context, '3'),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: _rowMarginSize),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildNumberTextButton(context, '4'),
                        _buildNumberTextButton(context, '5'),
                        _buildNumberTextButton(context, '6'),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: _rowMarginSize),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildNumberTextButton(context, '7'),
                        _buildNumberTextButton(context, '8'),
                        _buildNumberTextButton(context, '9'),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: _rowMarginSize),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        widget.leftSideInput ?? _buildBothSidesButton(context),
                        _buildNumberTextButton(context, '0'),
                        widget.rightSideInput ??
                            _buildNumberTextButton(context, ''),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildNumberTextButton(
    BuildContext context,
    String number,
  ) {
    final buttonSize = MediaQuery.of(context).size.width * 0.215;
    return Container(
      width: buttonSize,
      height: buttonSize,
      child: CircleInputButton(
        enteredSink: enteredStream.sink,
        text: number,
      ),
    );
  }

  Widget _buildBothSidesButton(BuildContext context) {
    final buttonSize = MediaQuery.of(context).size.width * 0.215;
    return Container(
      width: buttonSize,
      height: buttonSize,
      child: RaisedButton(
        padding: EdgeInsets.all(0),
        onPressed: () {},
        child: Icon(Icons.fingerprint),
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.black,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        widget.title,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  @override
  void dispose() {
    enteredStream.close();
    enteredLengthStream.close();
    authenticatedStream.close();
    super.dispose();
  }
}
